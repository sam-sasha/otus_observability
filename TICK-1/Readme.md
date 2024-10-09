## Установить и настроить Telegraf, Influxdb, Chronograf, Kapacitor.

Результатом выполнения данного ДЗ будет являться публичный репозиторий, в системе контроля версий (Github, Gitlab, etc.), в котором будет находиться Readme с описанием выполненных действий. Файлы конфигурации Telegraf, Influxdb, Chronograf, Kapacitor должны находиться в директории TICK-1.

## Описание/Пошаговая инструкция выполнения домашнего задания:

1. На виртуальной машине установите любую open source CMS, которая включает в себя следующие компоненты: nginx, php-fpm, database (MySQL or Postgresql);
2. На этой же виртуальной машине установите Telegraf для сбора метрик со всех компонентов системы (начиная с VM и заканчивая DB);
3. На этой же или дополнительной виртуальной машине установите Influxdb, Chronograf, Kapacitor
4. Настройте отправку метрик в InfluxDB.
5. Создайте сводный дашборд с самыми на ваш взгляд важными графиками, которые позволяют оценить работоспостобность вашей CMS;
6. Настройте правила алертинга для черезмерного потребления ресурсов, падения компонентов CMS и 500х ошибок;

   ## Решение

 1)   Устанавливаем LEMP по инструкции  https://github.com/sam-sasha/otus_observability/blob/main/TICK-1/install-wordpress.md
    

 2) Устанавливаем телеграф агента по инструкции https://www.influxdata.com/downloads/
![Alt text](../img/telegrafsetup.jpg?raw=true "telegrafsetup")

 3) На дополнительной виртуальной машине установите Influxdb, Chronograf, Kapacitor, Telegraf
    docker_compose.yaml
    ````
    docker compose up -d
    ````
    

 4) Настраиваем отправку метрик отправку метрик в InfluxDB.
![Alt text](../img/influx-connection.jpg?raw=true "influx-connection")
![Alt text](../img/systembucket.jpg?raw=true "systembucket")

5) Создаем сводный дашборд с самыми на наш взгляд важными графиками, которые позволяют оценить работоспостобность CMS;
   
 ![Alt text](../img/system1.jpg?raw=true "system1")
 ![Alt text](../img/nginx.jpg?raw=true "nginx")
 ![Alt text](../img/mysql.jpg?raw=true "mysql")
 
 
