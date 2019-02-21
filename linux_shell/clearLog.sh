#!bin/bash
fileLoc="/var/log/nginx";
if [ ! -d "${fileLoc}" ]; then
	echo "no file exists in $fileLoc";
else
	find ${fileLoc} -type f -mtime +3 -exec rm {} \;
fi

exit 0