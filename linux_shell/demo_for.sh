#!/bin/bash
T=0;

for i in {1..9}; do 
    for j in `seq $i`; do
        T=$(($i+$j))
        echo -ne "$i "x" $j "=" $T\t"
    done
echo 
done
exit 0
