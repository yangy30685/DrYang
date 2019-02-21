#!/bin/bash

# get dir and report type
this_file=`pwd`"/"$0
this_dir=`dirname $this_file`
report_type="cli"

# include conf and func
. $this_dir/conf.sh
. $this_dir/compute.sh
. $this_dir/$report_type.sh

# get report

all_report="`get_report_title`"
for conf in $log_config
{
    domain=`echo $conf | awk 'BEGIN{FS = "|";}{print $1}'`
    log_file="`echo $conf | awk 'BEGIN{FS = "|";}{print $2}'`"
    all_report=$all_report`get_single_report $domain $log_file`
}

# show report
echo -e $all_report
