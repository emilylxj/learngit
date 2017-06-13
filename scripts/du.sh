#!/bin/bash

DATE=`date +"%Y-%m-%d"` 
du -h --max-depth=1  /scratch/  >& /tmp/du-scratch-$DATE.log &
#du -h --max-depth=1  /home/  >& /tmp/du-home-$DATE.log &

#du -h --max-depth=1 ./scratch/liuxj/  >& ~/du-liuxj.log &  统计该层目录总大小,并将结果保存在log文件中

#du -sh  /scratch/liuxj/*    统计出该目录下每个目录的大小

#du -sh  /scrath/liuxj/*  |sort -n  将统计的结果按照按照大小排序
