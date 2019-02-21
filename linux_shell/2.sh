#!/bin/bash

#demo for case
echo "-------------------------------"
echo -e "\t 1 php-1"
echo -e "\t 2 php-2"
echo -e "\t 3 php-3"
echo -e "\t 4 php-4"
echo -e "\t 5 php-5"
echo -e "\t 6 php-6"
echo -e "\t 7 php-7"
echo "-------------------------------"

read -p "input a version number [1-7]:" version

case $version in 
1) echo "php-1"
	;;
2) echo "php-2"
	;;
3) echo "php-3"
	;;				
4) echo "php-4"
	;;
5) echo "php-5"
	;;
6) echo "php-6"
	;;
7) echo "php-7"
	;;
*) echo "error"
	;;
esac

exit 0
