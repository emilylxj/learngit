#!/bin/bash

LOG=/backup/scratch/log
cd $LOG
mkdir $1
SourceDir=/backup02/scratch/$1
DenDir=/backup/scratch/$1
cd $SourceDir
ls >name.list
Rsynclist=$SourceDir/name.list
Rsyncname=`cat $Rsynclist`
for i in $Rsyncname

do

echo "==========Begin rsync $i: $(date)===========" >>$LOG/$1/$i.log 2>&1
rsync -avzrtopglH  $SourceDir/$i  $DenDir/  >>$LOG/$1/$i.log 2>&1
echo "==========End rsync $i: $(date)===========" >>$LOG/$1/$i.log 2>&1

done       
