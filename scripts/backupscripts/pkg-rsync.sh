#!/bin/bash

LOG=/backup/pkg/log
#for i in lsc
#for i in acml        gcc           libs         modulefiles.old  pgi           
#for i in ADAS  gacode OMFIT  gaps  lidehui  LUKE  rf       transp       vorpal cql3d  imd   lsc      phg   simpla  theory    tsc
#LOG = /backup/pkg/log
#echo $LOG
cd /pkg
ls >name.list
Rsynclist=/pkg/name.list
Rsyncname=`cat $Rsynclist`
for i in $Rsyncname
do

echo "==========Begin rsync $i: $(date)===========" >>$LOG/$i.log 2>&1
rsync -azvH  /scratch/pkg/$i  /backup/pkg/  >>$LOG/$i.log 2>&1
echo "==========End rsync $i: $(date)===========" >>$LOG/$i.log 2>&1

done       
