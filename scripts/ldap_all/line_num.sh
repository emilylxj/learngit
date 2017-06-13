#!/bin/bash

#This scripts is used to get the linenumber of 'uid= or cn =' for each  user;
#usage:./line_num.sh username
#name=solps
#num=`cat -n export.ldif |grep  --color   "dn:\ uid=$1"  |awk '{print $1}'`
export num1=`cat -n export.ldif |grep  --color   "dn:\ uid=$1"  |awk '{print $1}'`
export num2=`cat -n export.ldif |grep  --color   "dn:\ cn=$1"  |awk '{print $1}'`
#echo $num
if [[ "$num1" == "" && "$num2" == "" ]]
then
exit
elif [[ "$num1" == "" ]]
then
num=$num2
else
num=$num1
fi
#num=${num1}+${num2}

echo $num
