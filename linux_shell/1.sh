#!/bin/bash

cat << EOF
welcome to yangspot.com
this is a simple tutorial
email yangy30685@live.co.uk
EOF

os_check() 
{
	if [ -e /etc/redhat-release ]; then
		REDHAT=`cat /etc/redhat-release | cut -d' ' -f1`

	else 
		DEBIAN=`cat /etc/issue.net | cut -d' ' -f1`
	fi

	if [ "${REDHAT}" == "CentOS" -o "${REDHAT}" == "Red" ]; then
		P_M=yum
		echo $P_M
	elif [ "${DEBIAN}" == "Ubuntu" -o "${DENIAM}" == "ubuntu" ]; then
		P_M=apt-get
		echo $P_M
	else
		echo operating system not support.
		exit 1
	fi
}

os_check
