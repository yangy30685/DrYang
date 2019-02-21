#!/bin/bash

#touch $(date) # commond in commond
#touch `date`

if [ $# -eq 0 ];then
	echo "usage: `basename $0` ip"
	exit
fi

ping -c 1 $1 >&/dev/null

if [ $? -eq 0 ];then
	echo "$1 is up"
else 	
	ehco "$1 is down"
fi

echo "PID: $$"
