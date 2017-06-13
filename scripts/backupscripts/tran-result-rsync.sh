#!/bin/bash

LOG=/backup/scratch/log
backupdir=/scratch/transp
backupdes=/backup/scratch/transp
cd $backupdir
ls >name.list
Rsynclist=$backupdir/name.list
Rsyncname=`cat $Rsynclist`
for i in $Rsyncname

#LOG = /backup/pkg/log
#echo $LOG
do

echo "==========Begin rsync $i: $(date)===========" >>$LOG/transp/$i.log 2>&1
rsync -avzrtopglH  $backupdir/$i  $backupdes/  >>$LOG/transp/$i.log 2>&1
echo "==========End rsync $i: $(date)===========" >>$LOG/transp/$i.log 2>&1

done       
