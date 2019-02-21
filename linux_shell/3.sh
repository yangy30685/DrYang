#!/bin/bash
i=1
#groupadd ssss
while [ $i -le 30 ]
do 
	if [ $i -le 9 ]; then
	buff=nnnn0${i}
	else 
	buff=nnnn${i}
	fi
#useradd $buff
userdel -r $buff

#	mkdir /home/$buff
#	chown -R $buff /home/$buff
#	chgrp -R ssss /home/$buff

#let  i+=1; not useful
#((i++));

i=$(($i+1))

done
exit 0