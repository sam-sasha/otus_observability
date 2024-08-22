## Задача
Для Prometheus необходимо установить отдельно хранилище метрик (Victoria Metrics, Grafana Mimir, Thanos, etc.).

Во время записи метрики в хранилище Prometheus должен дополнительно добавлять лейбл site: prod.

Дополнительные параметры хранилища:

Metrics retention - 2 weeks
В качестве результата ДЗ принимаются - файл конфигурации системы хранения, файл конфигурации Prometheus.

## Решение
![Alt text](../img/minio.png?raw=true "Minio")
