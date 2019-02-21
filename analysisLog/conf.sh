#!/bin/bash

log_path=/var/log/nginx
top_item_num=20
log_file_suffix=`date -d "-0 day" +%Y%m%d`
log_config="localhost|$log_path/access.log"
#log_config="localhost|$log_path/access.log-${log_file_suffix}"


