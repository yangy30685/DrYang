#!/bin/bash

# 备份文件存放路径
BACK_DIR=/home/backup 
#BACK_DIR=/home/yang/backup 

# 目标路径  
# DATA_DIR=/var/www 
DATA_DIR=/

# DAYS=7代表删除7天前的备份，即只保留最近7天的备份    
DAYS=7    

# 系统用户名               
LINUX_USER=root  

# 时间        
date=`date +%Y%m%d`

# 打包备份
if [ -d "${DATA_DIR}" ]; then

# cd to target file  avoid tar error removing / ...
	cd ${DATA_DIR}
else
	echo "${DATA_DIR} does not exist!"
fi

# cd to target file to avoid tar error removing / ...
# exclude the files dont want to backup
# backup system
tar --exclude='./proc' --exclude='./lost+found' --exclude='./mnt' --exclude='./tmp' --exclude='./home' --exclude='./server${date}.tar.gz' -cpzvf server${date}.tar.gz .

# backup other
# tar -cpzvf server${date}.tar.gz .

if [ -d "${BACK_DIR}" ]; then
	mv server${date}.tar.gz ${BACK_DIR}/
	[ $? -eq 0 ] && echo "server${date}.tar.gz is in ${BACK_DIR}" || echo "moving file error"
else
	#rm server${date}.tar.gz
	echo "${BACK_DIR} does not exist "
	echo "server${date}.tar.gz is still in ${DATA_DIR}"
	exit 1
fi

# 更改备份数据库文件的所有者
chown -R ${LINUX_USER}:${LINUX_USER} ${BACK_DIR} 

# 删除7天前的备份文件(注意：{} \;中间有空格)
find ${BACK_DIR} -name "server*" -type f -mtime +${DAYS} -exec rm {} \;  

# 完成!
cd ${BACK_DIR} && ls -al
[ $? -eq 0 ] && echo "updating done!" || echo "updating error!"

exit 0

# restore
# cd $BACK_DIR
# tar xvpfz server${date}.tar.gz -C ${DATA_DIR}
# mkdir proc
# mkdir lost+found
# mkdir mnt
# mkdir tmp
# mkdir home

# use for ftp
# 删除ftp服务器空间7天前的备份
# deldate=` date -d -7day +%Y%m%d `  
# ftp -n< open 47.254.45.119  21 #打开ftp服务器。21为ftp端口
# user ufpt 123456  #用户名、密码
# binary  #设置二进制传输
# cd wwwrootbak  #进入ftp目录
# lcd /home/wwwrootbak  #列出本地目录
# prompt
# mput wwwroot$date.tar.gz   wwwroot$date.tar.gz   #上传目录中的文件
# mdelete wwwroot$deldate.tar.gz  wwwroot$deldate.tar.gz  #删除ftp空间7天前的备份
# close
exit 0