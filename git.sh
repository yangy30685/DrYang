#!/bin/bash 

DATE="`date +%Y-%m-%d+%H:%M:%S`";

echo "start..."
git pull
echo "update done!"

git add . > /dev/null 2>&1

if [ $? -eq 0 ] 
then
	git commit -m "update by dryang at $DATE" 
fi

if [ $? -eq 0 ]
then
	git push origin master > /dev/null 2>&1
	echo "push done!"
	exit 0
else 
	echo "no change made!"
	exit 1
fi
