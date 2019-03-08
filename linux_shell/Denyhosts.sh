#!/bin/bash
#Denyhosts SHELL SCRIPT
cat /var/log/secure|awk '/Invalid/{print $(NF-2)}'|sort|uniq -c|awk '{print $2"="$1;}' >/root/dryang/linux_shell/Denyhosts.txt
DEFINE="5"
for i in `cat /root/dryang/linux_shell/Denyhosts.txt`
do
        IP=`echo $i|awk -F= '{print $1}'`
        NUM=`echo $i|awk -F= '{print $2}'`
        if [ $NUM -gt $DEFINE ]
        then
                ipExists=`grep $IP /etc/hosts.deny |grep -v grep |wc -l`
                if [ $ipExists -lt 1 ]
                then
                echo "sshd:$IP" >> /etc/hosts.deny
                fi
        fi
done
