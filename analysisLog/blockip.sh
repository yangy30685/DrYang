#!/bin/bash

# configure
log_path=/var/log/nginx
log_config="$log_path/access.log"

# get ip top N
function get_ip() 
{
    log_file=$log_config
    top=10
    ip_pv=`awk '{count[$1]++}END{for (ip in count){print count[ip],ip}}' ${log_file} | sort -rn | head -${top} | awk 'BEGIN{OFS = "\\\t"; ORS = "\\\n"}{print $1"="$2}'`
    echo -e $ip_pv
}
get_ip > /root/drYangSpot/analysisLog/ip.txt
sed -i '/^\s*$/d' /root/drYangSpot/analysisLog/ip.txt

# use iptables to block IP
DEFINE="100"
for i in `cat /root/drYangSpot/analysisLog/ip.txt`
do
        IP=`echo $i|awk -F "=" '{print $2}'`
        NUM=`echo $i|awk -F "=" '{print $1}'`
        if [ $NUM -gt $DEFINE ]
        then
                ipExists=`grep $IP /root/drYangSpot/analysisLog/ipblock.txt | grep -v grep |wc -l`
                if [ $ipExists -lt 1 ]
                then
                echo "$IP" >> /root/drYangSpot/analysisLog/ipblock.txt  
                iptables -A INPUT -s ${IP} -j DROP
                fi

        fi
done
exit 0
