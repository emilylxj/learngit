#!/bin/bash

FILENAME=$1
sed 's/set tokid = $cwd:t/#set tokid = $cwd:t/g' -i $FILENAME
NUMBER=$(sed -n '/#set tokid = $cwd:t/=' $FILENAME )
#echo $NUMBER
sed "${NUMBER}a cd ..\nset tokid = \$cwd:t\ncd -" -i  $FILENAME
sed -n "${NUMBER},$[${NUMBER}+4]p" $FILENAME
echo "=============================================="

for i in `seq 1 63`;
do 
sed -i "s/node${i}/shenma20${i}/g /etc/sysconfig/network"
done 

