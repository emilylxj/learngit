#!/bin/sh

# aim to backup the resorces files and mysql data that used by shenti system
# crontab run at 4:00AM every day
# procedure: first backup all the data, then check if 3 days ago backup files exist, then delete prior
# created by shiqiang at 2009-10-28

BACKDIR="/backup/"
LOGDIR="/backup/project/log/"
MYSQLBIN="/etc/init.d/mysql"

#RESOURCEPATH="/home/"    # add the path var to avoid the 'Removing leading / from member names tips'
RESOURCEDIR="/project"

#MYSQLDATAPATH="/var/lib/mysql/"
#MYSQLDATADIR_1="wys/"
#MYSQLDATADIR_2="wys2/"

# cd $BACKDIR

YEAR=`date +%Y`
MONTH=`date +%m`
DAY=`date +%d`

echo "-----------------------------------" >> $LOGFILE
echo $(date +"%Y-%m-%d %H:%M:%S")" Shenti backup begin" >> $LOGFILE

DIRNAME=$BACKDIR$YEAR-$MONTH-$DAY
FILENAME=$DIRNAME/$YEAR-$MONTH-$DAY-shenti-resorces-backup.tar

# change dir to correspond folder
if [ ! -d $DIRNAME ]
then
    mkdir $DIRNAME
fi

# backup the resources folder
cd $RESOURCEPATH
tar zcvf $FILENAME $RESOURCEDIR >> $LOGFILE 2>&1

# backup the mysql data folder, we should be attion about the data consistency

$MYSQLBIN stop >> $LOGFILE 2>&1

cd $MYSQLDATAPATH
FILENAME=$DIRNAME/$YEAR-$MONTH-$DAY-mysqldata-wys-backup.tar
tar zcvf $FILENAME $MYSQLDATADIR_1 >> $LOGFILE 2>&1

FILENAME=$DIRNAME/$YEAR-$MONTH-$DAY-mysqldata-wys2-backup.tar
tar zcvf $FILENAME $MYSQLDATADIR_2 >> $LOGFILE 2>&1

$MYSQLBIN start >> $LOGFILE 2>&1

echo "Resources and mysql data backup finished at"$(date +"%Y-%m-%d %H:%M:%S") >> $LOGFILE

# check the old backup folder
OLDBACKDIR="$BACKDIR"$(date +%Y-%m-%d --date='3 days ago')

if [ -d $OLDBACKDIR ]
then
         `rm -rf $OLDBACKDIR` >> $LOGFILE 2>&1
    echo " [$OLDBACKDIR] Delete Old Backup Folder Success!" >> $LOGFILE
else
         echo "No Old backup folders $OLDBACKDIR  !" >> $LOGFILE
fi

echo "Shenti Backup finished at "$(date +"%Y-%m-%d %H:%M:%S") >> $LOGFILE

cd $BACKDIR




cat /etc/crontab

1 1 1 */1 * ascenlink /bin/sh /home/ascenlink/logbackup.sh >/dev/null 2 >&1
