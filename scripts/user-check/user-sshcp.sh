#!/bin/bash
name=`cat usename-theroy`
for i in $name
do
echo $i 
cp -r /scratch/home/$i/.ssh  /home/users/$i/
chown $i:users -R /home/users/$i/.ssh 
#edquota -p liul -u $i
#su - $i "exit"
mkdir  /scratch1/$i

chown $i:theory  -R  /scratch1/$i

done
