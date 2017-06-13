148  prm -qa |grep openldap
  149  rpm -qa |grep openldap
  150  rpm -qa |grep nss
  151  rpm -qa |grep nss-pam
  152  vim /etc/openldap/ldap.conf 
  153  scp root@10.10.1.14:/etc/openldap/ldap.conf  /etc/openldap/
  154  vim /etc/openldap/ldap.conf 
  155  scp root@10.10.1.14:/etc/nslcd.conf   /etc/
  156  vim /etc/nslcd.conf 
  157  scp root@10.10.1.14:/etc/pam_ldap.conf  /etc/
  158  scp root@10.10.1.14:/etc/pam.d/system-auth /etc/pam.d/
  159  vim /etc/pam.d/system-auth
  160  scp root@10.10.1.14:/etc/nsswitch.conf  /etc/
  161  vim /etc/nsswitch.conf 
  162  scp root@10.10.1.14:/etc/sysconfig/authconfig  /etc/sysconfig/
  163  vim /etc/sysconfig/authconfig 
  164  vim /etc/pam.d/sshd 
  165  scp root@10.10.1.14:/etc/pam.d/sshd  /etc/pam.d/
  166  vim /etc/pam.d/sshd 
  167  chkconfig  nslcd on
  168  reboot 
 ldapsearch  -x -D cn=config -w "=omj0VP8q" -b cn=config 查看cn=config下面的设置
To kill off slapd(8) safely, you should give a command like this
kill -INT `cat /usr/local/var/slapd.pid`

