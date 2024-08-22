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
git clone https://github.com/grafana/mimir.git
````

Перейдите в каталог руководства:

````
cd mimir/docs/sources/mimir/get-started/play-with-grafana-mimir/
````
Запустите MinIO, Mimir, Prometheus, Grafana и NGINX

```
docker compose up -d
```

![Alt text](../img/tutorial-architecture-mimir.png?raw=true "mimir")

На хосте  открыты следующие порты:

Grafana к записи http://localhost:9000

Grafana Mimir на http://localhost:9009

Файлы конфигурации Grafana Mimir, вы можете просмотреть .config/mimir.yaml
