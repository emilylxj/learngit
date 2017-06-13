
#!/bin/bash
#for i in renql      szhu     liuxj      zhoudeng leexinxia  yalei  huyemin    wubin     gsxu      oujing        sding    xiangn     ligq        panchengkang   yangulei    bgui       shixj      weiland    xiaotao  yelei         gzjia      lxj      wfguo      xiaty     linbinbin  majun
#do
LOG=/scratch/liuxj/test/test.log
DATE="$(date)"
for i in  a b c d e f g h i j k l m n o p q r s t u v w x y z A D F P T
do
#date
 echo "==========Begin rsync: "$DATE" ===========" >>$LOG 2>&1
# du -s $BDIR/* >>$LOG 2>&1
# rsync $OPTS $DIR $BDIR/$BASE  >>$LOG 2>&1
# echo "==========End rsync: date===========" >>$LOG 2>&1 
# cp  -r /scratch/liuxj/$i* /scratch/liuxj/test/
rsync -avz /scratch/liuxj/$i* /scratch/liuxj/test/ >>$LOG 2>&1
DATE="$(date)"
 echo "==========End rsync:"$DATE"  ===========" >>$LOG 2>&1
#  mkdir -p /home/$i
#  cp /etc/skel/.*rc /home/$i
#  cp /etc/skel/.*profile /home/$i
#  chown $i:users /home/$i -R
#date

done
