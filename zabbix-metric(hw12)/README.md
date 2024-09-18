## Задача:

Настройка zabbix, создание LLD, оповещение на основе триггеров

Установить и настроить zabbix, настроить автоматическую отправку аллертов в телеграмм канал.


Описание/Пошаговая инструкция выполнения домашнего задания:
Необходимо сформировать скрипт генерирующий метрики формата:

````
otus_important_metrics[metric1]
otus_important_metrics[metric2]
otus_important_metrics[metric3]
````

С рандомным значение от 0 до 100

Создать правила LLD для обнаружения этих метрик и автоматического добавления триггеров. Триггер должен срабатывать тогда, когда значение больше или равно 95.

Реализовать автоматическую отправку уведомлений в телеграмм канал.

В качестве результаты выполнения ДЗ необходимо предоставить скрипт генерации метрик, скриншоты графиков полученных метрик, ссылку на телеграмм канал с уже отпраленными уведомлениями.

## Решение

На установленном заббикс добавляем скрипт поиска  метрик и генерации данных.

Путь к файлу
/usr/lib/zabbix/externalscripts/generate_data_metrics.sh

````
#!/bin/bash

cat << EOF
{ "data" :[
  {    "{#METRICNAME}": "metric1"  },
  {    "{#METRICNAME}": "metric2"  },
  {    "{#METRICNAME}": "metric3"  },
  {    "{#METRICNAME}": "metric4"  },
  {    "{#METRICNAME}": "metric5"  }
]}
EOF

for  i in  "metric1" "metric2" "metric3" "metric4" "metric5";
do
metric=$(( ($RANDOM % 100) +1));
zabbix_sender -z localhost -p 10051 -s  "Trapper_data" -k item[$i] -o $metric >> /dev/null 2>&1
done
````

###
## Создаем темплейт поиска метрик и добавления итемов и триггеров. 

![Alt text](../img/discovery4.jpg?raw=true "discovery4")

Нстройки поиска

![Alt text](../img/discovery1.jpg?raw=true "discovery1")

Настройки итемов

![Alt text](../img/discovery2.jpg?raw=true "discovery2")

Настройки Триггеров

![Alt text](../img/discovery3.jpg?raw=true "discovery3")


###

## Добавляем хост и привязываем к нему Темплейт

Сам хост
![Alt text](../img/host1.jpg?raw=true "host1")

Найденные Итемы
![Alt text](../img/host2.jpg?raw=true "host2")

Найденные Триггеры
![Alt text](../img/host3.jpg?raw=true "host3")


Проверяем поток данных полученных из генерации

![Alt text](../img/host_data1.jpg?raw=true "host_data1")

![Alt text](../img/host_data2.jpg?raw=true "host_data2")



###

## Проверяем срабатывание триггеров

Триггеры срабатывают,отправка происходит
![Alt text](../img/trigger1.jpg?raw=true "host_trigger1")

Доставка в телеграм канал производтится

![Alt text](../img/trigger2.jpg?raw=true "host_trigger2")

