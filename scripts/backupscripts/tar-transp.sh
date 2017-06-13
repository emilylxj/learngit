#!/bin/bash
#author:        InBi
#date:          2011-08-05
#role:          backup files periodically.
#website:       http://www.itwhy.org/2011/07-28/707.html
##################################################
#LOGDIR=/backup/pkg-bk/log/
SourceDir=/scratch/transp
BakDir=/backup02/scratch/transp
RetainDay=4
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
mkdir transp-$DATE
DesDir=$BakDir/transp-$DATE
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

find $Bakdir -type f -mtime +$RetainDay -name "*.$scratch*" -exec rm -r {} \; >/dev/null
#find $Bakdir -type f -mtime +$RetainDay -name "*.$log*" -exec rm -r {} \; >/dev/null

