#!/bin/bash

BACK_DIR=/root
DATA_DIR=/
DAYS=4    
LINUX_USER=root  

DATE="`date +%Y%m%d`"
if [ -d "${DATA_DIR}" ]; then
	cd ${DATA_DIR}
fi

tar --exclude='./proc' --exclude='./lost+found' --exclude='./mnt' --exclude='./tmp' --exclude='./root' --exclude='./server${date}.tar.gz' -cpzvf server${DATE}.tar.gz . >/dev/null 2>&1

mv server${DATE}.tar.gz ${BACK_DIR}

chown -R ${LINUX_USER}:${LINUX_USER} ${BACK_DIR} 

find ${BACK_DIR} -name "server*" -type f -mtime +${DAYS} -exec rm {} \;  

exit 0
