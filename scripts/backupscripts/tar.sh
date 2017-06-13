#!/bin/bash
Root=/backup/other/scratch-backup/scratch-back-20150318
SourceDir=/backup/other/scratch-backup/scratch-back-20150318/pkg-20150318
BakDir=/backup/other/scratch-backup/scratch-back-20150318/pkg-20150318-tar
cd $SourceDir
ls >name.list
ProjectLst=$SourceDir/name.list
cd $BakDir
LogDir=$Root/log/tar
PROJECTLIST=`cat $ProjectLst`
for i  in $PROJECTLIST
do
echo "backup $i  start at $(date +"%Y-%m-%d %H:%M:%S")" >> $LogDir/$i.log 2>&1
echo "-------------------------------------------" >> $LogDir/$i.log 2>&1
PackFile=$BakDir/$i.tar
tar -zcvf $PackFile   $SourceDir/$i  >> $LogDir/$i.log  2>&1
echo "backup $i done into $PackFile" >> $LogDir/$i.log  2>&1
echo "------------------------------------------" >> $LogDir/$i.log  2>&1
echo "backup $i end at $(date +"%Y-%m-%d %H:%M:%S")" >> $LogDir/$i.log  2>&1
echo " " >> $LogDir/$i.log  2>&1

done


