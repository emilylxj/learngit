#!/bin/bash
mkdir /project/log
LOG=/project/log
#for i in lsc
#for i in acml        gcc           libs         modulefiles.old  pgi           
#for i in ADAS  gacode OMFIT  gaps  lidehui  LUKE  rf       transp       vorpal cql3d  imd   lsc      phg   simpla  theory    tsc
#LOG = /backup/pkg/log
#echo $LOG
cd /project
ls >name.list
scplist=/project/name.list
scpname=`cat $scplist`

for i in $scpname
do

echo "==========Begin scp $i: $(date)===========" >>$LOG/$i.log 2>&1
scp -r  root@shenma162:/scratch/project/$i  /project/  >>$LOG/$i.log 2>&1
echo "==========End scp  $i: $(date)===========" >>$LOG/$i.log 2>&1

done       
