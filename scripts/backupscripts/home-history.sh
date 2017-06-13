#!/bin/bash

#LOG=/backup/pkg/log
cd /home
ls >name.list
Rsynclist=/home/name.list
Rsyncname=`cat $Rsynclist`

for i in $Rsyncname
do
cat /home/$i/.bash_history |grep modulefiles >> /home/liuxj/$i-bashhistory.log 2>&1
#cp /home/liuxj/.ssh/config /home/$i/.ssh/
#echo "==========Begin rsync $i: $(date)===========" >>$LOG/$i.log 2>&1
#rsync -avzrtopglH  /scratch/pkg/$i  /backup/pkg/  >>$LOG/$i.log 2>&1
#echo "==========End rsync $i: $(date)===========" >>$LOG/$i.log 2>&1

done       
