#!/bin/bash
#author:        InBi
#date:          2011-08-05
#role:          backup files periodically.
#website:       http://www.itwhy.org/2011/07-28/707.html
##################################################
#LOGDIR=/backup/project-bk/log/
SourceDir=/scratch/project
BakDir=/backup02/backup_nfs/project
RetainDay=7
cd $SourceDir
ls >name.list
ProjectLst=$SourceDir/name.list
##################################################
YEAR=`date +%Y`
MONTH=`date +%m`
DAY=`date +%d`
DATE=`date +"%Y-%m-%d"`
#echo "backup start at $(date +"%Y-%m-%d %H:%M:%S")" >$LogFile
#echo "--------------------------------------------------" >>$LogFile
cd $BakDir
mkdir project-$DATE
DesDir=$BakDir/project-$DATE
mkdir $DesDir/log-$DATE
LogDir=$DesDir/log-$DATE
PROJECTLIST=`cat $ProjectLst`
for i  in $PROJECTLIST
do
echo "backup $i  start at $(date +"%Y-%m-%d %H:%M:%S")" >> $LogDir/$i-$DATE.log 2>&1
echo "-------------------------------------------" >> $LogDir/$i-$DATE.log 2>&1
  
        PackFile=$DesDir/$i-$DATE.tar
        tar -zcvf $PackFile   $SourceDir/$i  >> $LogDir/$i-$DATE.log  2>&1
        echo "backup $i done into $PackFile" >> $LogDir/$i-$DATE.log  2>&1
     
  #  fi
echo "------------------------------------------" >> $LogDir/$i-$DATE.log  2>&1
echo "backup $i end at $(date +"%Y-%m-%d %H:%M:%S")" >> $LogDir/$i-$DATE.log  2>&1
echo " " >> $LogDir/$i-$DATE.log  2>&1

done

find $BakDir -type f -mtime +$RetainDay -name "*project-2015-04*" -exec rm -r {} \; >/dev/null

