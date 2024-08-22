## Задача
Для Prometheus необходимо установить отдельно хранилище метрик (Victoria Metrics, Grafana Mimir, Thanos, etc.).

Во время записи метрики в хранилище Prometheus должен дополнительно добавлять лейбл site: prod.

Дополнительные параметры хранилища:

Metrics retention - 2 weeks
В качестве результата ДЗ принимаются - файл конфигурации системы хранения, файл конфигурации Prometheus.

## Решение
![Alt text](../img/minio.png?raw=true "Minio")

### Устанавливаем хранилище на базе Minio

Чтобы развернуть Distributed MinIO на Docker Compose, загрузите docker-compose.yaml и nginx.conf  из папки  minio в текущий рабочий каталог.  Затем выполните одну из следующих команд

````
docker compose up -d
````
![Alt text](../img/docker-compose-minio.jpg?raw=true "Minio")

Распределенные экземпляры теперь доступны на хосте с помощью Minio CLI на порту 9000 и Minio Web Console на порту 9001.

Пользователь: minioadmin

Пароль: minioadmin
