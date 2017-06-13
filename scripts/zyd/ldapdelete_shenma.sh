#!/bin/sh

#This  script is used to delete the new account from the people  !
#usage is ./ldapdelete.sh liuxj  

#2015/05/29 liuxj


USERNAME=$1
ldapdelete -w "=omj0VP8q"  -x -D  "cn=Manager,dc=shenma,dc=ipp,dc=ac,dc=cn"  "uid=$1,ou=people,dc=shenma,dc=ipp,dc=ac,dc=cn"
rm -rf /home/users/$USERNAME

rm -rf /scratch/$USERNAME
