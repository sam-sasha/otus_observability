## Задача
Для Prometheus необходимо установить отдельно хранилище метрик (Victoria Metrics, Grafana Mimir, Thanos, etc.).

Во время записи метрики в хранилище Prometheus должен дополнительно добавлять лейбл site: prod.

Дополнительные параметры хранилища:

Metrics retention - 2 weeks
В качестве результата ДЗ принимаются - файл конфигурации системы хранения, файл конфигурации Prometheus.

## Решение
### Запускаем тестовый стенд в качестве базы используется Grafana Mimir

Создайте копию репозитория Grafana Mimir с помощью командной строки Git:

````
git clone https://github.com/sam-sasha/otus_observability.git
````

Перейдите в каталог задачи GAP-2:

````
cd GAP-2
````
Запустите MinIO, Mimir, Prometheus, Grafana и NGINX

```
docker compose up -d
```

![Alt text](../img/tutorial-architecture-mimir.png?raw=true "mimir")

На хосте  открыты следующие порты:

Grafana к записи http://ip:9000

Grafana Mimir на http://ip:9009

Prometheus на http://ip:9090

Minio http://ip:9000

Файлы конфигурации Grafana Mimir, вы можете просмотреть .config/mimir.yaml

Файлы конфигурации promrtheus , вы можете просмотреть .config/prometheus.yml

...

### Как навесить дополнительных меток хостам

правим prometheus.yml

```
scrape_configs:
  - job_name: demo/mimir
    static_configs:
      - targets: ["mimir-1:8080"]
        labels:
          site: prod
          pod: "mimir-1"
      - targets: ["mimir-2:8080"]
        labels:
          site: prod
          pod: "mimir-2"
      - targets: ["mimir-3:8080"]
        labels:
          site: prod
          pod: "mimir-3"
```

Перезапускаем prometheus

```
curl -X POST :9090/-/reload
```
        
Проверяем лейбл site: prod
![Alt text](../img/label.jpg?raw=true "mimir")


### Как долго Prometheus должен хранить метрики

Есть две опции:

--storage.tsdb.retention.time=..  определяет как долго Prometheus будет хранить собранные метрики.

--storage.tsdb.retention.size=..  определяет сколько дискового пространства Prometheus может использовать под метрики.

Выставляем соответствующие значения, перезапкскаем прометеус. 
