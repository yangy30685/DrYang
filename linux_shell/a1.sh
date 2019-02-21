#!/bin/bash

a="hi world!"
printf '%s\n' "A is $a"
num=2
echo "this is the ${num}nd"
var=0
(( var += 1))
echo $var
(( var++ ))
echo $var
(( var = var* var ))

echo $var
#space does not matter here
let 'var =var/3'
echo ${var}
echo $((var+=2))
echo $var
echo "--------------------"
var=1
var=`expr "$var" + 1`
#carefull space also `is not' 
echo $var
exit 0