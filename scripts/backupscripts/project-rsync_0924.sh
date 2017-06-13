#!/bin/bash

LOG=/backup/backup_start_0924/project/log
BACKDIR=/scratch/project
DESDIR=/backup/backup_start_0924/project/
LOG=$DESDIR/log
cd $BACKDIR
ls >$DESDIR/name.list
Rsynclist=$DESDIR/name.list
Rsyncname=`cat $Rsynclist`
for i in $Rsyncname
do

echo "==========Begin rsync $i: $(date)===========" >>$LOG/$i.log 2>&1
rsync -azvH  $BACKDIR/$i  $DESDIR/  >>$LOG/$i.log 2>&1
echo "==========End rsync $i: $(date)===========" >>$LOG/$i.log 2>&1

done       
