#!/bin/bash

for var in "$@"; do 
if [ -x "$var" ];
then
      echo "$var can excute"
else
      echo "$var can't excute"
fi                 
done
exit 0
