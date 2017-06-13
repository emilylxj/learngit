#!/bin/bash
service dhcpd restart
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

echo "Boot Cluster "| logger

echo -n "Mount NFS (HP NAS) "

while true
do
   RES=`showmount -e 10.10.1.36|grep ibfs|wc -l`
   if [ -z $RES ]; then
     waiting 10
   else
     break
   fi
done

mount -t nfs -o rsize=8192,wsize=8192 10.10.1.36:/ibfs/pkg /pkg
mount -t nfs -o rsize=8192,wsize=8192 10.10.1.36:/ibfs/install /install
mount -t nfs -o rsize=8192,wsize=8192 10.10.1.36:/ibfs/home /home
mount -t nfs -o rsize=8192,wsize=8192 10.10.1.36:/ibfs/project /project

echo -n "[Done]"

echo
echo -n "Mount Lustre system  "

rpower node68 on  > /dev/null
waiting 120
rpower node[64-67] on  > /dev/null

while true
do
   if [ `xdsh node[64-67] df |grep ParaStor|wc -l` -lt 4  ]; then
     waiting 10
   else  
     break     
   fi 
done 

mount -t lustre -o flock 12.0.1.64@o2ib0:12.0.1.65@o2ib0:/ParaStor /scratch

echo -n "![Done]"
echo

echo -n "Power on shenma[1-10,101~163] "
rpower shenma[1-10] on  > /dev/null
waiting 30
rpower shenma[101-114] on  > /dev/null
waiting 30
rpower shenma[115-128] on  > /dev/null
waiting 30
rpower shenma[129-142] on  > /dev/null
waiting 30
rpower shenma[143-163] on  > /dev/null
waiting 30

NUM_OF_NODE=73
RES='ls /scratch|wc -l'
while true
do
   if [ `xdsh shenma[1-10,101-163] uname | grep Linux | wc -l` -lt $NUM_OF_NODE  ]; then
     waiting 10
   else
     break
   fi
done

xdsh shenma[1-10,101-161] mount -t nfs -o ro,rsize=8192,wsize=8192,timeo=14,intr 10.10.1.36:/ibfs/pkg /pkg
xdsh shenma[1-10,101-161] mount -t nfs -o ro,rsize=8192,wsize=8192,timeo=14,intr 10.10.1.37:/ibfs/install /install
xdsh shenma[1-10,101-161] mount -t nfs -o ro,rsize=8192,wsize=8192,timeo=14,intr 10.10.1.38:/ibfs/home /home
xdsh shenma[1-10,101-161] mount -t nfs -o ro,rsize=8192,wsize=8192,timeo=14,intr 10.10.1.39:/ibfs/project /project
xdsh shenma[1-10,101-161] mount -t lustre -o flock 12.0.1.64@o2ib0:12.0.1.65@o2ib0:/ParaStor /scratch


xdsh shenma[162,163] mount -t nfs -o ro,rsize=8192,wsize=8192,timeo=14,intr 10.10.1.36:/ibfs/pkg /pkg
xdsh shenma[162,163] mount -t nfs -o ro,rsize=8192,wsize=8192,timeo=14,intr 10.10.1.36:/ibfs/install /install
xdsh shenma[162,163] mount -t nfs -o ro,rsize=8192,wsize=8192,timeo=14,intr 10.10.1.36:/ibfs/home /home
xdsh shenma[162,163] mount -t nfs -o ro,rsize=8192,wsize=8192,timeo=14,intr 10.10.1.36:/ibfs/project /project
xdsh shenma[162,163] mount -t lustre -o flock 12.0.1.64@o2ib0:12.0.1.65@o2ib0:/ParaStor /scratch



ssh shenma mount -t nfs -o rsize=8192,wsize=8192,timeo=14,intr 10.10.1.36:/ibfs/pkg/pkg_centos5 /pkg 
ssh shenma mount -t nfs -o rsize=8192,wsize=8192,timeo=14,intr 10.10.1.36:/ibfs/install /install
ssh shenma mount -t nfs -o rsize=8192,wsize=8192,timeo=14,intr 10.10.1.36:/ibfs/home /home



echo -n "![Done]"

echo 


echo "Start load balance"

balance 22 shenma162:22 shenma163:22 &

echo "Now, ShenMa is ready for use!"

echo "Now, ShenMa is ready for use!" | logger


