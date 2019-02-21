#!/bin/bash
clear #clear the screen 
echo "This is inforamtion provided by s1.sh"
echo
echo "Hi $USER"
echo
echo "Today's date is `date`, this is week $(date +%U)." #%U sunday
echo
echo "These users are currently connected:"
#w | cut -d " " -f 1 | grep -v USER | sort -u           #w/who list users 
w -h | cut -d " " -f 1 # get rid of header
echo "This is `uname -s` running on a $(uname -m) processor"
echo
echo "This is the uptime information:"
uptime    # Online time 
echo
source ./disk_used.sh
echo "That's all bro!"

