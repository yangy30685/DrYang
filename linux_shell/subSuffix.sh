#!/bin/bash
#this command change all files is current folder named after .sh to none postfix
for file in `ls`
do
	new_name=`echo $file | sed 's/\.sh//g'`
	mv $file $new_name
done
