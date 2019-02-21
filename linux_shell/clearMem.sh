#!/bin/bash

echo "check mem" "------------------------------------------------------------"
free -h
#1. Clear PageCache only.
#sync; echo 1 > /proc/sys/vm/drop_caches

#2. Clear dentries and inodes.
#    sync; echo 2 > /proc/sys/vm/drop_caches

#3. Clear PageCache, dentries and inodes.
# sync; echo 3 > /proc/sys/vm/drop_caches 
#Explanation of above command.

#sync will flush the file system buffer. Command Separated by “;” run sequentially. The shell wait for each command to terminate before executing the next command in the sequence. As mentioned in kernel documentation, writing to drop_cache will clean cache without killing any application/service, command echo is doing the job of writing to file.

#If you have to clear the disk cache, the first command is safest in enterprise and production as  “...echo 1 > ….” will clear the PageCache only. It is not recommended to use third option above  “...echo 3 >” in production until you know what you are doing, as it will clear PageCache, dentries and inodes.

# clear RAM Cache and Swap Space.

sync; echo 3 > /proc/sys/vm/drop_caches
swapoff -a 
swapon -a

if [ $? -eq 0 ];then
    printf '\n%s\n' 'Ram-cache and Swap Cleared'
fi

echo "check again" "------------------------------------------------------------"
    free -h
exit 0
