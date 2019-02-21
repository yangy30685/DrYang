#!/bin/bash

# backup dir
BACK_DIR=/root
#BACK_DIR=/home/yang/backup 

# folder dir
# DATA_DIR=/var/www 
DATA_DIR=/


# user name             
LINUX_USER=root  

# time        
date=`date +%Y%m%d`

# restore
cd $BACK_DIR
tar xvpfz server${date}.tar.gz -C ${DATA_DIR}
 
 mkdir proc
 mkdir lost+found
 mkdir mnt
 mkdir tmp
 mkdir home


