#!/bin/sh

#This  script is used to delete the new account from the people  !
#usage is ./ldapdelete.sh liuxj  

#2015/05/29 liuxj


USERNAME=$1
ldapdelete -w "yx&6fYXg2"  -x -D  "cn=admin,dc=hpc,dc=ipp,dc=ac,dc=cn"  "uid=$1,ou=people,dc=hpc,dc=ipp,dc=ac,dc=cn"
rm -rf /home/$USERNAME
rm -rf /scratch/$USERNAME
