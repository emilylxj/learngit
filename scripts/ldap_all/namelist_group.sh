#!/bin/bash
#This scripts is used to get the namelist of speical groups .
#usage:./namelist_group.sh theory 
ls /home/users >name.list
for i in `cat name.list`
do
groups $i >>group.log
done
cat group.log |grep $1 |awk '{print $1}' >>namelist_group_$1
