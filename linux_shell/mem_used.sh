#!/bin/bash

war_file=/home/yang/log.txt

var1=`free -m | grep '^Mem'| awk '{print $3}'`

var2=`free -m | grep '^Mem'| awk '{print $2}'`

var3=`echo| awk "{print ${var1}/${var2}*100}"`

var3=${var3%.*} #change to percentage

echo $var3

if [ $var3 -ge 1 ];then

echo "`date +%F-%T`"
echo 'the memused is beyound 1%'

fi

if [ -f $war_file ]; then
	echo "the file exist"
	rm -rf $war_file
else
	echo "the file is not exit"
fi
exit 0
