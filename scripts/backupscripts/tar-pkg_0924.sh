#!/bin/bash
#The scripts is created by liuxj at 09-24-2015
TYPE=pkg
SourceDir=/scratch/$TYPE
BakDir=/backup02/backup_tar_start_0924/$TYPE
RetainDay=14
cd $SourceDir
ls >$BakDir/name.list
LIST=$BakDir/name.list
##################################################
YEAR=`date +%Y`
MONTH=`date +%m`
DAY=`date +%-%d`
DATE=`date +"%Y-%m-%d"`
#echo "backup start at $(date +"%Y-%m-%d %H:%M:%S")" >$LogFile
#echo "--------------------------------------------------" >>$LogFile
cd $BakDir
mkdir $TYPE-$DATE
DesDir=$BakDir/$TYPE-$DATE
mkdir $DesDir/log
LogDir=$DesDir/log
NLIST=`cat $LIST`
for i  in $NLIST
do
echo "backup $i  start at $(date +"%Y-%m-%d %H:%M:%S")" >> $LogDir/$i.log 2>&1
echo "-------------------------------------------" >> $LogDir/$i.log 2>&1
  
        PackFile=$DesDir/$i.tar
        tar -zcvf $PackFile   $SourceDir/$i  >> $LogDir/$i.log  2>&1
        echo "backup $i done into $PackFile" >> $LogDir/$i.log  2>&1
     
  #  fi
echo "------------------------------------------" >> $LogDir/$i.log  2>&1
echo "backup $i end at $(date +"%Y-%m-%d %H:%M:%S")" >> $LogDir/$i.log  2>&1
echo " " >> $LogDir/$i.log  2>&1

done

find $BakDir -prune  -type d  -mtime +$RetainDay  -exec rm -r {} \; >/dev/null

