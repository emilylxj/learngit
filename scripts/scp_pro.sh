#!/bin/bash
for i in gacode imd  lsc  OMFIT-source gacode-new  OMFIT  tsc 
do 

scp -r /project/${i}  root@211.86.151.151:/project/ 

done 
