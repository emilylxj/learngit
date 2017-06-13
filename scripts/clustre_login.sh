#!/bin/bash
CLUSTRE_LOGIN_DIR=/scratch/liuxj/cluster_login
if  ! [ -d $CLUSTRE_LOGIN_DIR ];then
        exit
fi
if [ -f $CLUSTRE_LOGIN_DIR/`hostname`_log  ] ;then 
rm -rf $CLUSTRE_LOGIN_DIR/`hostname`_log
fi 
cd /var/log
ls wtmp*>$CLUSTRE_LOGIN_DIR/name.list
cd $CLUSTRE_LOGIN_DIR
for i in `cat name.list`
do 
last -f /var/log/$i >> $CLUSTRE_LOGIN_DIR/`hostname`_log 
done 

rm -rf name.list
LANG=EN

YEAR=`date +%Y`

MONTH=`date +%b`
LAST_MONTH=`date -d "-1month"  +%b`
cat $CLUSTRE_LOGIN_DIR/`hostname`_log |grep $LAST_MONTH >> $CLUSTRE_LOGIN_DIR/${LAST_MONTH}_`hostname`.log 
rm -rf $CLUSTRE_LOGIN_DIR/`hostname`_log
#DAY=`date +%d`

#DATE=`date +"%Y-%m-%d"
