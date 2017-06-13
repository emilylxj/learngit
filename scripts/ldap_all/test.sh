#!/bin/bash
while read line; 
do
if [[ $line =~ $NAME ]]
then
        flag=1
fi
if [[ $line = "gidNumber:\ 509" ]]
then
       echo $line
        flag=1
fi
if [ $flag == 1 ]
then
   echo $line;
fi

if [[ $line =~ $userpassword ]]
then
        flag=0
fi
done < users-0803.ldif

