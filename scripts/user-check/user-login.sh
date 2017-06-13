#!/bin/bash
name=`cat usename-theroy1`
for i in $name
do
echo $i 

#edquota -p liul -u $i
su - $i "exit"
done
