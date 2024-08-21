## Задача

На виртуальной машине установите любую open source CMS, которая включает в себя следующие компоненты: nginx, php-fpm, database (MySQL or Postgresql)

На этой же виртуальной машине установите Prometheus exporters для сбора метрик со всех компонентов системы (начиная с VM и заканчивая DB, не забудьте про blackbox exporter, который будет проверять доступность вашей CMS)

На этой же или дополнительной виртуальной машине установите Prometheus, задачей которого будет раз в 5 секунд собирать метрики с экспортеров.

## Решение
![Alt text](../img/logo.jpg?raw=true "BitrixDock")

## Ручная установка виртуальной машины vm1
### Выполните настройку окружения с веб окружением 

Установил Ubuntu 24.04 LTS на HyperV.
Произвел первичную настройку системы, пользователя и ПО.
Установил docker, docker-compose.
С помощью docker-compose установил и настроил CMS Bitrix с БД MySQL. (Далее все устанавливается с помощью docker-compose)
Установил и настроил mysqld-exporter. 

Скачайте репозиторий `git clone https://github.com/bitrixdock/bitrixdock.git`

Скопируйте файл `.env_template` в `.env`

### Добавление mysql-exporter
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

##
![Alt text](../img/prom_graf.png?raw=true "BitrixDock")

## На второй машине разворачиваем систему мониторинга с prometheus grafana

Установил prometheus, grafana, black_box_exporter и node_exporter.

Настроил сбор метрик посредствам prometheus. Визуализацию в Grafana.

Приложены файлы кофигурации prometheus.yml, docker-compose.yml, blackboxconfig.yml 


