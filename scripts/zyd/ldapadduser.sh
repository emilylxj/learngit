#!/bin/sh
USERIDNUM=`ldapsearch -x -b "ou=people,dc=hpc,dc=ipp,dc=ac,dc=cn" |grep uidNumber|tail -n 1 |awk '{print $2}' `
UESRIDNUM=$((USERIDNUM+1))
USERNAME=$1
USERFULLNAME=$2
GROUPNAME=$3
GROUPID=`ldapsearch -x -b "ou=groups,dc=hpc,dc=ipp,dc=ac,dc=cn" |grep -A 1 "cn: $GROUPNAME" |grep gidNumber |awk '{print $2}' `

cat > ldapuser.ldif << EOF
dn: uid=$USERNAME,ou=people,dc=hpc,dc=ipp,dc=ac,dc=cn
cn: $USERNAME
gidNumber: 100
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

cat > ldapgroup.ldif << EOF
dn: cn=$GROUPNAME,ou=groups,dc=hpc,dc=ipp,dc=ac,dc=cn
objectClass: posixGroup
cn: $GROUPNAME
gidNumber: $GROUPID
memberUid: $USERNAME
EOF
id $USERNAME 2> /dev/null
if [[ $# -ne 0 ]];then
	ldapadd -x -D cn=admin,dc=hpc,dc=ipp,dc=ac,dc=cn -W -f ldapuser.ldif
else
	echo "User $1 is already exist"
	exit
fi
ldapadd -x -D cn=admin,dc=hpc,dc=ipp,dc=ac,dc=cn  -W -f ldapgroup.ldif
ldapmodify -M -f referral.ldif -x -D "cn=Manager,dc=example,dc=net" -W
