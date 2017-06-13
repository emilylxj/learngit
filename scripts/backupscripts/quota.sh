#!/bin/bash
name=`cat group.list`
for i in $name
do
echo $i
 edquota -p liuxj -u $i
done
~      
