#!/bin/bash

function waiting {
   if [ -n $1 ] ; then
     COUNTER=$1
   else
     COUNTER=1
   fi
   while [ $COUNTER -gt 0 ]; do
      sleep 1
      echo -n "."
      let COUNTER-=1
   done
}


if [ -z $1 ]; then
 WAITTIME="now"
else 
 WAITTIME=$1
fi

echo "Shutdown ShenMa!" | logger
echo "Shutdown ShenMa!"


echo  "Shutdown compute compute nodes !" |logger

echo -n "Shutdown compute nodes"
xdsh shenma[1-10,101-163] shutdown $WAITTIME
waiting 30

NUM_OF_NODE=73

if [ `rpower shenma[1-10,101-163] status |grep off|wc -l` -lt $NUM_OF_NODE ]; then
    rpower shenma[1-10,101-163] off
fi

while true
do
   RES=`rpower shenma[1-10,101-163] status |grep off|wc -l`
   if [ $RES -lt $NUM_OF_NODE ]; then
     waiting 10
   else
     break
   fi
done
echo "![Done]"


echo "Shutdown Luster system " |logger
echo -n "Shutdown Luster system "
umount /scratch

xdsh node[64-68] shutdown now

waiting 90

NUM_OF_NODE=5

if [ `rpower node[64-68] status |grep off|wc -l` -lt $NUM_OF_NODE ]; then
    rpower node[64-68] off
    echo " "
fi

while true
do
   RES=`rpower node[64-68] status |grep off|wc -l`
   if [ $RES -lt $NUM_OF_NODE ]; then
     waiting 10
   else
     break
   fi
done
echo -n "![Done]"

echo  "Shutdown NFS (HP NAS)  "
umount /pkg
umount /home
umount /install
umount /project

echo "Now, you can shutdown the master node!"




