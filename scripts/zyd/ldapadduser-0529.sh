#!/bin/sh
#This  script is used to add the new account to the shenmacluster !
#usage is ./ldapadd.sh liuxj liuxiaojuan ipp 
#the default ldap passwd is lazy198938
#2015/05/29 liuxj
if [ $(id -u) = "0" ];then
echo "Begin to setup the newuser"
else
echo "you must have the root permision"
fi

echo "We will add the new user to the cluster"

USERIDNUM=`ldapsearch -x -b "ou=people,dc=hpc,dc=ipp,dc=ac,dc=cn" |grep uidNumber|tail -n 1 |awk '{print $2}' `
#UESRIDNUM=$((USERIDNUM+1))
((USERIDNUM++))
USERNAME=$1
USERFULLNAME=$2
GROUPNAME=$3
GROUPID=`ldapsearch -x -b "ou=groups,dc=hpc,dc=ipp,dc=ac,dc=cn" |grep -A 1 "cn: $GROUPNAME" |grep gidNumber |awk '{print $2}' `
echo $USERIDNUM
echo $GROUPID
cat > ldapuser.ldif << EOF
dn: uid=$USERNAME,ou=people,dc=hpc,dc=ipp,dc=ac,dc=cn
cn: $USERNAME
gidNumber: $GROUPID
givenname: $USERNAME
homedirectory: /home/$USERNAME
loginshell: /bin/bash
objectclass: inetOrgPerson
objectclass: posixAccount
objectclass: top
sn: $USERFULLNAME
uid: $USERNAME
uidNumber: $USERIDNUM
userpassword: {crypt}\$1\$9Va1JgDw\$0OABnHMjWWJMCekP/4enB0
EOF

#id $USERNAME 2> /dev/null
USERDN=`ldapsearch -x -b "ou=people,dc=hpc,dc=ipp,dc=ac,dc=cn" |grep dn |grep $USERNAME`
if [ -z "$USERDN" ];then
	ldapadd -x -D cn=admin,dc=hpc,dc=ipp,dc=ac,dc=cn -w "yx&6fYXg2"  -f ldapuser.ldif
else
	echo "User $1 is already exist"
	exit
fi
USERDNNEW=`ldapsearch -x -b "ou=people,dc=hpc,dc=ipp,dc=ac,dc=cn" |grep dn |grep $USERNAME`
if [ -n "$USERDNNEW" ];then
	echo "$USERNAME is create sucessfully !!!"
	echo "the user name is $USERNAME "
else 
	echo "the scripts is error!!!"
	exit
fi

echo
echo "Now set up the dir"
mkdir /home/$USERNAME
mkdir /scratch/$USERNAME

echo "now cp the bashfile"
cp /etc/skel/.bashrc /home/$USERNAME
cp /etc/skel/.bash_profile /home/$USERNAME

echo "chang the owner"
chown $USERNAME:$GROUPNAME -R /home/$USERNAME
chown $USERNAME:$GROUPNAME -R /scratch/$USERNAME

echo "chang the Passwd"
passwd $USERNAME

echo "NOW you can login the cluster"




