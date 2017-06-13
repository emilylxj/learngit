#!/bin/bash


#Install OpenLDAP Server
yum install openldap-servers openldap-clients

cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG
chown ldap. /var/lib/ldap/DB_CONFIG
/etc/init.d/slapd start
chkconfig  slapd on

#Set OpenLDAP admin password.

#passwd:=omj0VP8q
#changSSHA:{SSHA}0NZyQiH5wWdlPTEBHgw/Y7D4Jo6Y6iZV

vi chrootpw.ldif
# specify the password generated above for "olcRootPW" section
 dn: olcDatabase={0}config,cn=config
changetype: modify
add: olcRootPW
olcRootPW: {SSHA}0NZyQiH5wWdlPTEBHgw/Y7D4Jo6Y6iZV

ldapadd -Y EXTERNAL -H ldapi:/// -f chrootpw.ldif
#SASL/EXTERNAL authentication started
#SASL username: gidNumber=0+uidNumber=0,cn=peercred,cn=external,cn=auth
#SASL SSF: 0
#modifying entry "olcDatabase={0}config,cn=config"


#Set your domain name on LDAP DB.

# generate directory manager's password
slappasswd 
#New password: Yn6Kq1sz#
#Re-enter new password: Yn6Kq1sz#
#{SSHA}/Az6sRqyMu68rqyUl7wlW4eBJmjgHApm

#cn=Manager,dc=shenma,dc=ipp,dc=ac,dc=cn

vi chdomain.ldif
# replace to your own domain name for "dc=***,dc=***" section
# specify the password generated above for "olcRootPW" section
dn: olcDatabase={1}monitor,cn=config
changetype: modify
replace: olcAccess
olcAccess: {0}to * by dn.base="gidNumber=0+uidNumber=0,cn=peercred,cn=external,cn=auth"
  read by dn.base="cn=Manager,dc=shenma,dc=ipp,dc=ac,dc=cn" read by * none

dn: olcDatabase={2}bdb,cn=config
changetype: modify
replace: olcSuffix
olcSuffix: dc=shenma,dc=ipp,dc=ac,dc=cn

dn: olcDatabase={2}bdb,cn=config
changetype: modify
replace: olcRootDN
olcRootDN: cn=Manager,dc=shenma,dc=ipp,dc=ac,dc=cn

dn: olcDatabase={2}bdb,cn=config
changetype: modify
add: olcRootPW
olcRootPW: {SSHA}0NZyQiH5wWdlPTEBHgw/Y7D4Jo6Y6iZV




ldapmodify -Y EXTERNAL -H ldapi:/// -f chdomain.ldif 


#SASL/EXTERNAL authentication started
#SASL username: gidNumber=0+uidNumber=0,cn=peercred,cn=external,cn=auth
#SASL SSF: 0
#modifying entry "olcDatabase={2}bdb,cn=config"

#modifying entry "olcDatabase={2}bdb,cn=config"

#modifying entry "olcDatabase={2}bdb,cn=config"


vim basedomain.ldif

# replace  to your own domain name for "dc=***,dc=***" section
dn: dc=shenma,dc=ipp,dc=ac,dc=cn
objectClass: top
objectClass: dcObject
objectclass: organization
o: shenma ipp ac cn
dc: shenma   
#this dc must the same as above . I get the error adding new entry "dc=shenma,dc=ipp,dc=ac,dc=cn"
#ldap_add: Naming violation (64)
#	additional info: value of single-valued naming attribute 'dc' conflicts with value present in entry
#because i write the dc =server not shenma.
dn: cn=Manager,dc=shenma,dc=ipp,dc=ac,dc=cn
objectClass: organizationalRole
cn: Manager
description: Directory Manager

dn: ou=People,dc=shenma,dc=ipp,dc=ac,dc=cn
objectClass: organizationalUnit
ou: People

dn: ou=Group,dc=shenma,dc=ipp,dc=ac,dc=cn
objectClass: organizationalUnit
ou: Group
~          

ldapadd -x -D cn=Manager,dc=shenma,dc=ipp,dc=ac,dc=cn  -W -f basedomain.ldif
#Enter LDAP Password: the passwd is the  OpenLDAP admin password:omj0VP8q
#adding new entry "dc=shenma,dc=ipp,dc=ac,dc=cn"

#adding new entry "cn=Manager,dc=shenma,dc=ipp,dc=ac,dc=cn"

#adding new entry "ou=People,dc=shenma,dc=ipp,dc=ac,dc=cn"

#adding new entry "ou=Group,dc=shenma,dc=ipp,dc=ac,dc=cn"


#add user to the openldap

ldapadd -x -D cn=Manager,dc=shenma,dc=ipp,dc=ac,dc=cn -W -f ldapuser.ldif

ldapadd -x -D cn=Manager,dc=shenma,dc=ipp,dc=ac,dc=cn -W -f ldapgroup.ldif

# I use the 
#ldapsearch -x -b "ou=groups,dc=hpc,dc=ipp,dc=ac,dc=cn" >ldapbak-gropu.ldif

#ldapsearch -x -b "ou=people,dc=hpc,dc=ipp,dc=ac,dc=cn" >ldapbak-people.ldif \
to get the use and group information . But I find the password information is \  not include the ldif file .so When I use the following command to insert the use information ,the password is not inserted.I dont know why.So i use the web interface to get information.It is ok.

#If you'd like to delete LDAP User or Group,Do as below

[root@dlp ~]# ldapdelete -x -W -D 'cn=Manager,dc=server,dc=world' "uid=cent,ou=People,dc=server,dc=world" 
Enter LDAP Password:
[root@dlp ~]# ldapdelete -x -W -D 'cn=Manager,dc=server,dc=world' "cn=cent,ou=Group,dc=server,dc=world" 
Enter LDAP Password:=omj0VP8q


#Configure LDAP Client in order to share users' accounts

yum -y install openldap-clients nss-pam-ldapd

vim ldap-client.sh

#!/bin/bash
authconfig --enableldap \
--enableldapauth \
--ldapserver=10.10.0.103 \
--ldapbasedn="dc=shenma,dc=ipp,dc=ac,dc=cn" \
--enablemkhomedir \
--update

Starting nslcd:                                            [  OK  ]

exit

Now I can login the ldap server and client.and the all users information is Synchronous to new ldap server .

But i find i cannot fix my own password ,I get the weeor massage :pam_ldap: ldap_modify_s Insufficient access  

the solve method is add the olcSuffix: dc=shenma,dc=ipp,dc=ac,dc=cn
olcAccess: {0}to attrs=userPassword by dn="cn=Manager,dc=shenma,dc=ipp,dc=ac,dc=cn" write by anonymous auth by self write by * none
olcAccess: {1}to attrs=shadowLastChange by self write by * read
olcAccess: {2}to dn.base="" by * read
olcAccess: {3}to * by dn="cn=Manager,dc=shenma,dc=ipp,dc=ac,dc=cn" write by * read
olcRootDN: cn=Manager,dc=shenma,dc=ipp,dc=ac,dc=cn
 to the /etc/openldap/slapd.d/cn=config
and restart slapd .it is ok.

about the phpldapadmin ,please reference the httpd install.
