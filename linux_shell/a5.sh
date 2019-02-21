#!/bin/bash

echo "What is your favourite OS?"
select var in "Linux" "Gnu Hurd" "Free BSD" "Other"; do
  break;
done
echo "You have selected $var"

pocket=()
select var in 跳跳糖 糖 很多糖 企鹅糖; do
echo "除了 $var 还要什么吗？"
if ((RANDOM%4 == 0)); then
echo "呀！时间不够了，快上车！"
break
fi
pocket+=("$var")
done
echo "你最后说的那个 $var 弄丢了……"
IFS='、'
echo "现在口袋里只有：${pocket[*]}。"
IFS=$' \t\n'

exit 0