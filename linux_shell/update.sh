#/bin/bash
abc=`date +%d-%m-%Y`
cd ~
echo -e "--------------\t${abc}\t--------------------"
echo 
echo `pwd`

#for i in allinone drYangSpot algorithm_demo webscript cpp app
for i in `ls ~`
do
    cat << eof
--------------------------------
eof
	echo $i
	cat << eof
-------------------------------
eof
	if [ -d ${i} ];then
		cd ${i} && echo `pwd`
    	git status && git pull 
		cd ~
	fi
done

exit 0
