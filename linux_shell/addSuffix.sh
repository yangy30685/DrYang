#!/bin/bash

#this command .sh suffix to all files in current folder
for file in `ls`; do
    new_name=`echo $file | sed 's/.*/&sh/'`
    mv $file $new_name
done
exit 0