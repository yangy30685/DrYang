#!/bin/bash
if [ $# -eq 0 ]; then
    echo -e "type -v, -b or -h for options"
fi

while getopts vbh opt
do 
	case ${opt} in
		v)aaa=1
		;;
		b)bbb=1
		;;
		h)ccc=1
		;;
		*)echo "wrong input"
		;;
	esac
done

if [[ ! -z $aaa ]]; then 
    echo 'this is version1.0.0'
    dir_Name=$(pwd)
    echo 'current dir is :'
    echo $dir_Name
    echo 'current base name is'
    echo $(basename $dir_Name)
#basename "$(test -L "$0" && readlink "$0" || echo "$0")" > /tmp/scriptname
#basename命令会删掉所有的前缀包括最后一个slash（‘/’）字符，然后将字符串显示出来
#scriptname=$(echo -e -n $wd/ && cat /tmp/scriptname)
#scriptname就是tecmint_monitor.sh的地址
#su -c "cp $scriptname /usr/bin/monitor" root && echo "Congratulations! Script Installed, now run monitor Command" || echo "Installation failed"
fi

if [[ ! -z $bbb ]]; then 
echo -e "Hi bro!\nWelcome to Dr Yang's spot!"
echo "The system info is displayed below:"
fi

if [[ ! -z $ccc ]]; then
echo "-v  display version"
echo "-b  display greetings from Dr.Yang"
echo "-h  display help"
fi

echo 
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

# Check network
ping -c 1 www.baidu.com >/dev/null 2>&1 && echo -e '\E[32m' "Internet:Connected" || echo -e '\E32m' "Internet:Disconnected"

# Check system info

a1=`uname -s`
a2=`uname -r`
a3=`uname -m`
a4=`hostname -I | cut -d " " -f 1`

echo -e '\e[31;1m'   "Architecture:${a3}"
echo -e '\e[36;2m'  "Kernel:${a2}" #only recognise one space 
echo -e '\e[95;3m' "System:$a1"
echo -e '\e[92m' "Local IP:$a4"
echo -e '\e[0;30;107m' "External IP:`curl ifconfig.co`" '\e[0m'

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo
	free -h > /tmp/aaaa
	cat /tmp/aaaa | grep -v "Swap:"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	cat /tmp/aaaa | grep -v "Mem:"
echo

df -h| grep 'Filesystem\|/dev/sda*' > /tmp/bbbb
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
cat /tmp/bbbb

a5=$(top -n 1 -b | grep "^top" | awk '{print $10 $11 $12 $13 $14}')
echo -e "\e[96m$a5"

a6=$(uptime | awk '{print $3 $4}'| sed 's/,//g')
a7=$(uptime | awk '{print $5}'| sed 's/,//g')
echo -e "\e[31;1mSystem uptime Days/(HH:MM):\e[0m" $a6/$a7

# Clean 

rm -rf /tmp/aaaa /tmp/bbbb 

for i in $(seq 7);do
	unset a$i
done
# Shift $(($OPTIND -1))

exit 0
