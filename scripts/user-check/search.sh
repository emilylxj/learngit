#!/bin/bash
NAMELIST=`cat name.list`
for i in  $NAMELIST
do
ldapsearch -x -b "cn=$i,ou=people,dc=hpc,dc=ipp,dc=ac,dc=cn" >>$i-users.ldif 2>&1

ldapsearch -x -b "uid=$i,ou=people,dc=hpc,dc=ipp,dc=ac,dc=cn" >>users.ldif 2>&1
done
