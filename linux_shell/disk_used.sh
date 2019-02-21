#!/bin/bash

disk_used=$(df -Ph | grep "/$" | awk '{print $5}' | sed  s/\%//g)

if [ $disk_used -gt 5 ]; then
	echo "$(date +%F:%M) disk usage is : ${disk_used}%"
fi

exit 0
