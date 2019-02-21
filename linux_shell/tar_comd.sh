#!/bin/bash

#useage: tar [a file name]

if [ $# -ne 0 ];then

tar -zcvf "$(date +%Y-%m-%d).tar.gz" $1

[ $? -eq 0 ] && echo ok || echo error

elif [ $# -eq 0 ];then

read -p "input a file name" target

tar -zcvf "$(date +%Y-%m-%d).tar.gz" $target

[[ $? -eq 0 ]] && echo ok || echo fail

else

echo check the sytanx

fi
