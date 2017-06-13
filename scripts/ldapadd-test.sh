#/bin/bash
line='flexlm:x:594:594:FLEXlm Server:/var/lib/flexlm:/bin/bash'
UID1=`echo $line | cut -d: -f1`
   NAME=`echo $line | cut -d: -f5 | cut -d, -f1`
echo $line
echo $UID1
echo $NAME
