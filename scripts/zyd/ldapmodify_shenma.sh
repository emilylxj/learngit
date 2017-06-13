#!/bin/sh

#This  script is used to add the new account to the group  !
#usage is ./ldapadd.sh liuxj ipp 

#2015/05/29 liuxj
#USERIDNUM=`ldapsearch -x -b "ou=people,dc=shenma,dc=ipp,dc=ac,dc=cn" |grep uidNumber|tail -n 1 |awk '{print $2}' `
#UESRIDNUM=$((USERIDNUM+1))
USERNAME=$1
#USERFULLNAME=$2
GROUPADDNAME=$2
GROUPADDID=`ldapsearch -x -b "ou=groups,dc=shenma,dc=ipp,dc=ac,dc=cn" |grep -A 1 "cn: $GROUPADDNAME" |grep gidNumber |awk '{print $2}' `
#echo $UESRIDNUM
#echo $GROUPID
echo $GROUPADDID
cat > modify.ldif << EOF
dn: cn=$GROUPADDNAME,ou=groups,dc=shenma,dc=ipp,dc=ac,dc=cn
changetype: modify
add:memberuid
memberuid:$USERNAME
EOF
cat  modify.ldif

#ldapadd -x -D cn=admin,dc=shenma,dc=ipp,dc=ac,dc=cn  -W -f ldapgroup.ldif
ldapmodify -M -f modify.ldif -x -D "cn=Manager,dc=shenma,dc=ipp,dc=ac,dc=cn"  -w "=omj0VP8q"
rm -rf modify.ldif
