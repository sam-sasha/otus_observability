#!/bin/bash

metrics1=$(( $RANDOM % 100 +1))
metrics2=$(( $RANDOM % 100 +1))
metrics3=$(( $RANDOM % 100 +1))
metrics4=$(( $RANDOM % 100 +1))

zabbix_sender -z 192.168.1.58 -p 10051 -s "Trapper" -k metric1 -o "$metrics1"
zabbix_sender -z 192.168.1.58 -p 10051 -s "Trapper" -k metric2 -o "$metrics2"
zabbix_sender -z 192.168.1.58 -p 10051 -s "Trapper" -k metric3 -o "$metrics3"
zabbix_sender -z 192.168.1.58 -p 10051 -s "Trapper" -k metric4 -o "$metrics4"
