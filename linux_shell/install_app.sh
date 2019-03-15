#!/bin/bash

#root log in
if [ $UID -ne 0 ];then
	echo
	echo "Error! change to root!"
exit 1
fi

echo "Please wait..."
echo 

apt-get update

if [ $? -ne 0 ];then
	echo
	yum update -y
	echo
	echo "update complete!"
	echo
fi

DATE=`date +%Y-%m-%d`
echo "------------ ${DATE} --------------------"
echo "now its upgrading!!!"
apt-get dist-upgrade -y

if [ $? -eq 0 ]; then
	echo "the update is finished!"
fi

if [ $? -ne 0 ];then
	echo
	yum update -y
	echo
	echo "update complete!"
	exit 0
fi

echo
echo "Now clean the file"
apt-get clean && apt-get autoremove

#suppres the error using 2>&1
dpkg --list | grep "^rc" | cut -d " " -f 3 | xargs dpkg --purge >/dev/null 2>&1
echo "FINISH!"	
exit 0
