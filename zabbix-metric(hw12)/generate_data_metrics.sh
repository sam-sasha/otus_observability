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



#cat /dev/null > /usr/local/zdata.txt
for  i in  "metric1" "metric2" "metric3" "metric4" "metric5";
do
metric=$(( ($RANDOM % 100) +1));
#echo  $i=$metric
#echo zabbix_sender -z 192.168.1.58 -p 10051 -s  "Trapper_data" -k item[$i] -o $metric
zabbix_sender -z localhost -p 10051 -s  "Trapper_data" -k item[$i] -o $metric >> /dev/null 2>&1
done


