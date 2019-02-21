#!/bin/bash
cat << EOF
#-------------------------------------------------------
# demo of ping.sh
#
# please input ipaddress(e.g. 1.1.1.1/google.com) after running the script
#
# author@yangspot.com 
#-------------------------------------------------------
EOF

read -p "input host address: " HOST
#hostAdd=192.168.0.42
#hostAdd=$1  position input

if ping -c1 ${HOST} >/dev/null 2>&1;then
	echo "${HOST} is up"
else
	echo "${HOST} is down!"
fi
exit 0
