#!/bin/bash
#This scripts is created by liuxj,To get the ldif for each user from the export.ldif;
#usage:./user_ldif.sh username > username.ldif  
#usage:for i in `cat name.list`;do ./user_ldif.sh $i >>group.ldif ;done
#usage:for i in `cat name.list`;do ./user_ldif.sh $i >>$i.ldif ;done
export num1=`cat -n export.ldif |grep  --color   "dn:\ uid=$1,"  |awk '{print $1}'`
export num2=`cat -n export.ldif |grep  --color   "dn:\ cn=$1,"  |awk '{print $1}'`
if [[ "$num1" == "" && "$num2" == "" ]]
then
exit
elif [[ "$num1" == "" ]]
then
export num=$num2
else
export num=$num1
fi

#echo $num
#num=$[${num1}+${num2}]

#echo $num
echo "######################################################"
echo "`sed -n "${num}p" export.ldif`"
flag=1
until [[ $flag == 0 ]] ;
#for i in `seq 1 25`
do
num=$[${num} + 1]
result=`sed -n "${num}p" export.ldif|grep userpassword`
if [[ "$result"  = "" ]]
then
  echo "`sed -n "${num}p" export.ldif`"
else
  echo "`sed -n "${num}p" export.ldif`"
  flag=0
  #exit
fi 
done
#echo $flag
#awk -v num="$num" 'BEGIN{


