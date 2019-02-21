#!/bin/bash
#useradd --input a number for how many users you want to add
#auther: @DrYang 18/05/2018

while true
do
read -p "input a number:" nnn
if [[ $nnn =~ ^[0-9]+$ ]]; then	
	break
else
	echo "error number!"
fi
done

read -p "input a prefix:" prefix

for i in `seq $nnn`
do 
	echo ${prefix}${i}
	temp=${prefix}${i}
	#useradd $temp
     	if [ $? -eq 0 ]; then
		echo "user $temp is added!"
	fi
done

exit 0
