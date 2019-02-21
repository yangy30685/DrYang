#!/bin/bash
if [ $# -eq 0 ];then
	echo "no parameters "
	echo "the demo is `basename $0` + a filename "
	exit 1
fi

if [ ! -f $1 ];then
	echo "error file"
	exit 2
fi

for ip in `cat $1`;do
ping -c 1 $ip >/dev/null 2>&1
	if [ $? -eq 0 ];then
		echo "$ip is up"
	else
		echo "$ip is down" 
fi

done	
exit 0
