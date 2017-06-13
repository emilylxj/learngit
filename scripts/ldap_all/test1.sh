#!/bin/bash
name=509
while read line; 
do
if [[ $line =~ $name ]]
then
       echo $line
fi
done < test.sh
