#!/bin/bash

function get_report_title() {
    echo ""
}

function get_single_title() { 
    single_title=" 
|----------------------------------------------\n
|\n
|  target domain name:\t$1\n 
|  target log file:\t$2\n
|  this file created time:\t`date +%Y-%m-%d" "%H":"%M`\n
|----------------------------------------------\n
|\n"
    echo $single_title
}

function get_block_title() {
    echo "|\n
|---$1---\n"    
    
}

function format_list_data() {
    data=$1;
    echo `awk $data 'BEGIN{FS="\\t";RS="\\n";OFS="\\\t";ORS="\\\n |\\\t"}{print $1,$2}'`
}

function get_single_report() {
    domain=$1;
    log_file=$2;
    single_report="\n
`get_single_title $domain $log_file`
|　　总访问量:\t`get_total_visit $log_file`\n
|　　　总带宽:\t`get_total_bandwidth $log_file`\n
|　　独立访客:\t`get_total_unique $log_file`\n
`get_block_title 访问IP统计`
|\t`get_ip_top $log_file $top_item_num | format_list_data`\n

`get_block_title 访问url统计`

|\t`get_url_top $log_file $top_item_num | format_list_data`\n

`get_block_title 来源页面统计`

|\t`get_referer_top $log_file $top_item_num | format_list_data`\n

`get_block_title 404统计`

|\t`get_notfound_top $log_file $top_item_num | format_list_data`\n

`get_block_title 蜘蛛统计`

|\t`get_spider $log_file | format_list_data`\n

`get_block_title 搜索引擎来源统计`

|\t`get_search_enigne $log_file | format_list_data`\n
|----------------------------------------------\n"

    echo $single_report
}
