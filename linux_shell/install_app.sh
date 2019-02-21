#!/bin/bash

#root log in
if [ $UID -ne 0 ];then
	echo "error! change to root!"
exit 1
fi
	echo "please wait..."
	echo #empty line
	apt-get update
	echo "now its upgrading!!!"
	apt-get dist-upgrade -y

if [ $? -eq 0 ]; then
	echo "the update is finished!"
fi

	echo
	echo "now clean the file"
	apt-get clean

#suppres the error using 2>&1

	dpkg --list | grep "^rc" | cut -d " " -f 3| xargs dpkg --purge >/dev/null 2>&1
	echo "FINISH!"	
	exit 0

