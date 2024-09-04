## Задача:
Установите Alertmanager, настройки алертинг в один из каналов оповещений на ваш выбор (Telegram, email, Slack, etc.);

Создайте набор alert`ов с различными Severity. Для начала ограничтесь warning и critical;

Alertmanager должен уметь отправлять алерты с severity critical в один канал оповещений, в то время как алерты с severity warning в другой;

В качестве результата ДЗ принимаются - файл конфигурации Alertmanager

## Решение 

## Устанавливаем Alertmanager 
Устана


Добавляем модуль в docker-compose.yml

````
  alertmanager:
    image: prom/alertmanager:latest
    container_name: alertmanager
    volumes:
      - ./alertmanager:/etc/alertmanager
    command:
      - '--config.file=/etc/alertmanager/config.yml'
      - '--storage.path=/alertmanager'
    restart: unless-stopped
    ports:
      - 9093:9093
    networks:
      - monitoring
    labels:
      org.label-schema.group: "monitoring"
````

В файле настроек alertmanager/config.yml устанавливаем каналы отправкиВ разделе receivers описаны получатели сообщений:

blackhole —  пустой получатель, который игнорирует все сообщения;
telegram-test — получатель, который отправляет сообщения в Telegram.
Чтобы отправлять сообщения в Telegram, используется конфигурация telegram_configs, которая содержит следующие параметры:

chat_id — ID чата в Telegram, куда будут отправляться сообщения. Здесь нужно указать свой ID чата.
bot_token — токен бота в Telegram. Здесь нужно указать свой токен.
api_url — URL API Telegram.
send_resolved — отвечает за отправку уведомлений при восстановлении.
parse_mode — режим парсинга сообщений (HTML, Markdown и т. д.).
message — содержание сообщения. 


````
global:
 resolve_timeout: 5m
 telegram_api_url: "https://api.telegram.org"

templates:
  - '/etc/alertmanager/*.tmpl'

receivers:
 - name: blackhole
 - name: telegram-test
   telegram_configs:
    - chat_id: -1002171684793 #"ID вашего чата без кавычек"
      bot_token: 1234567890 #"Ваш токен без кавычек"
      api_url: "https://api.telegram.org"
      send_resolved: true
      parse_mode: HTML
      message: '{{ template "telegram.default" . }}'


route:
# group_by: ['ds_id'] # Алерты группируются по UUID кластера.
 group_by: ['alertname', 'severity']
 group_wait: 15s
 group_interval: 30s
 repeat_interval: 30m
 receiver: telegram-test
 routes:
  - receiver: telegram-test
    continue: true
    matchers:
     - severity="critical"
  - receiver: blackhole
    matchers:
     - alertname="Watchdog
````

В примере используется шаблон telegram.default, который определен в файле telegram.tmpl.

````
    {{ define "telegram.default" }}
    {{ range .Alerts }}
    {{ if eq .Status "firing"}}&#x1F525<b>{{ .Status | toUpper }}</b>&#x1F525{{ else }}&#x2705<b>{{ .Status | toUpper }>    <b>{{ .Labels.alertname }}</b>
    {{- if .Labels.severity }}
    <b>Severity:</b> {{ .Labels.severity }}
    {{- end }}
    {{- if .Labels.ds_name }}
    <b>Database:</b> {{ .Labels.ds_name }}
    {{- if .Labels.ds_group }}
    <b>Database group:</b> {{ .Labels.ds_group }}
    {{- end }}
    {{- end }}
    {{- if .Labels.ds_id }}
    <b>Cluster UUID: </b>
    <code>{{ .Labels.ds_id }}</code>
    {{- end }}
    {{- if .Labels.instance }}
    <b>DBaaS region:</b> {{ .Labels.instance }}
    {{- end }}
    {{- if .Annotations.message }}
    {{ .Annotations.message }}
    {{- end }}
    {{- if .Annotations.summary }}
    {{ .Annotations.summary }}
    {{- end }}
    {{- if .Annotations.description }}
    {{ .Annotations.description }}
    {{- end }}
    {{ end }}
    {{ end }}
````

Сохраняем файл и выполняем тестовый запуск контейнера:

````
docker-compose up -d
````

Для проверки отбивок можно использовать команду

````
curl -H  'Content-Type: application/json' -d '[{"labels":{"alertname":"это проверка доставки алерта", "severity":"critical" }}]' http://127.0.0.1:9093/api/v2/alerts
````
Если все правильно настроено, в телеграм должно прийти сообщение.

![Alt text](../img/telega_alert.jpg?raw=true "telega_alert")


### Использование почтового отправителя

В файле настроек alertmanager/config.yml Добавляем второй отправитель alertmanager-smtp:

````
global:
 resolve_timeout: 5m
 telegram_api_url: "https://api.telegram.org"

templates:
  - '/etc/alertmanager/*.tmpl'

receivers:
 - name: blackhole
 - name: telegram-test
   telegram_configs:
    - chat_id: -1002171684793 #"ID вашего чата без кавычек"
      bot_token: 6615053934:AAFBcdWr8jjEdATlVcEmSVvXP25FTi7GvbU #"Ваш токен без кавычек"
      api_url: "https://api.telegram.org"
      send_resolved: true
      parse_mode: HTML
      message: '{{ template "telegram.default" . }}'
 - name: alertmanager-smtp
   email_configs:
   - to: 'a.petunin@2bservice.ru'
     from: 'alert@otushomework.net'
     smarthost: 'mx.2bservice.ru:25'
     require_tls: false

route:
# group_by: ['ds_id'] # Алерты группируются по UUID кластера.
 group_by: ['alertname', 'severity']
 group_wait: 15s
 group_interval: 30s
 repeat_interval: 30m
 receiver: telegram-test
 routes:
  - receiver: telegram-test
    continue: true
    matchers:
     - severity="critical"
  - receiver: alertmanager-smtp
    continue: true
    matchers:
     - severity="warning"
  - receiver: blackhole
    matchers:
     - alertname="Watchdog"
````

Пересоздаем контейнеры:

````
docker stop  $(docker ps -qa) && docker rm  $(docker ps -qa)
docker compose up -d
````

Отправляем тестовое сообщение с меткой warning

````
curl -H  'Content-Type: application/json' -d '[{"labels":{"alertname":"это проверка доставки алерта", "severity":"warning" }}]' http://127.0.0.1:9093/api/v2/alerts
````
Видим в Алертменеджере данные 

![Alt text](../img/smtp_alert.jpg?raw=true "smtp_alert")

в почтовом ящике видим сообщение

![Alt text](../img/smtp_alert_mail.jpg?raw=true "smtp_alert_mail")

Итог: Отправка сообщений с разным уровнем критичности идет по разным каналам.
