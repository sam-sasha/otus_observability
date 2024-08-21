![Alt text](../img/logo.jpg?raw=true "BitrixDock")

## Ручная установка виртуальной машины 
### Выполните настройку окружения с веб окружением

Скачайте репозиторий `git clone https://github.com/bitrixdock/bitrixdock.git`

Скопируйте файл `.env_template` в `.env`

Внесите изменения в docker-compose.yml
````
    mysqld-exporter:
      image: prom/mysqld-exporter:latest
      container_name: mysql-exporter
      restart: always
      command:
       - --config.my-cnf=/etc/mysqld-exporter/.my.cnf
       - --collect.global_status
       - --collect.info_schema.innodb_metrics
       - --collect.auto_increment.columns
       - --collect.info_schema.processlist
       - --collect.binlog_size
       - --collect.info_schema.tablestats
       - --collect.global_variables
       - --collect.info_schema.query_response_time
       - --collect.info_schema.userstats
       - --collect.info_schema.tables
       - --collect.perf_schema.tablelocks
       - --collect.perf_schema.file_events
       - --collect.perf_schema.eventswaits
       - --collect.perf_schema.indexiowaits
       - --collect.perf_schema.tableiowaits
       - --collect.slave_status
       - --web.listen-address=0.0.0.0:9104
      environment:
        - DATA_SOURCE_NAME=bitrix:123@tcp(localhost:3306)/
      ports:
        - 9104:9104
      volumes:
        - "./.my.cnf:/etc/mysqld-exporter/.my.cnf"
      networks:
        - bitrixdock
````
