#!/bin/bash
for DATE in `seq 01 31`
do 
echo $DATE
if  [ $(($DATE%7)) == 0 ] ; then  
echo "this is an even num"  
else  
echo "this is not an even num"  
fi
done
