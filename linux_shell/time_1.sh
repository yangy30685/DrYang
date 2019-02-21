#!/bin/bash
clear
printf "This is information provided by Dr Yang"
printf "\n"
printf "Hello, $USER.\n\n"

printf "Today's date is `date +%Y-%m-%d`, time is `date +%H:%M:%S`.\n\n"

printf "Today's date is `date`, this is week `date +%V`.\n\n"

printf "These users are currently connected:\n"
w | cut -d " " -f 1 | grep -v USER | sort -u
printf "\n" #start a new line

printf "This is `uname -s` running on a `uname -m` processor.\n\n"

printf "This is the uptime information:\n"
uptime
printf "\n"

printf "That's all folks!\n"
