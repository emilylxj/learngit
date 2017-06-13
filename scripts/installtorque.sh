
http://blog.ajdecon.org/installing-the-maui-scheduler-with-torque-410/

tar xzvf torque-2.5.12.tar.gz 
   51  ls
   52  cd torque-2.5.12
   53  ls
   54  ./configure --prefix=...(chang the install directory,such as bin,include,...) --with-server-home=/var/lib/torque --with-rcp  (chang the pbs_mom directory)
   55  make
   56  make install
   57  cd contrib/init.d/
   58  cp pbs_mom /etc/init.d/
   59  chkconfig --add pbs_mom
   60  cd /var/lib/torque/
   61  ls
   62  vim server_name 
   63  cd mom_priv/
   64  ls
   66  scp root@10.10.1.11:/var/spool/torque/mom_priv/config .
   67  chkconfig pbs_mom on
   68  qstat
   69  /etc/init.d/pbs_mom status
   70  /etc/init.d/pbs_mom restart
/etc/init.d/pbs_mom change the pbshome


install maui:

./configure --prefix--bindir=/usr/local --sbindir=/usr/local --libdir=/usr/local --includedir=/usr/local/--with-spooldir=/var/lib/maui/ --with-pbs=/usr

./configure  --prefix=/usr/local --with-spooldir=/var/lib/maui/ --with-pbs=/usr --with-gold

make

make  install
然后修改配置文件 /usr/local/maui/maui.cfg，主要修改 SERVERHOST 和 ADMIN1 两项，即服务器主机名和管理账户，一般为 root。然后到安装目录下的 contrib/service-scripts 下，修改文件 redhat-maui.d, 主要是 MAUI_PREFIX=/usr/local/maui 并把 daemon --user maui 改为 daemon --user root，然后给该文件加可执行属性，并 mv redhat-maui.d  /etc/init.d/maui。然后 /etc/init.d/maui start 就可以启动 maui 任务调度服务了，为了开机自动启动，可以 chkconfig maui on 。最后把 /usr/local/maui/bin 加到路径中就可以了。

./configure --prefix=/usr --with-server-home=/var/lib/torque --with-rcp --enable-nvidia-gpus --with-gnu-ld

Building components: server=yes mom=yes clients=yes
                     gui=yes drmaa=no pam=no
PBS Machine type    : linux
Remote copy         : /usr/bin/scp -rpB
PBS home            : /var/lib/torque
Default server      : service103

Unix Domain sockets : 
Linux cpusets       : no
Tcl                 : -L/usr/lib64 -Wl,-rpath -Wl,/usr/lib64 -ltcl8.5 -ldl -lieee -lm
Tk                  : -L/usr/lib64 -Wl,-rpath -Wl,/usr/lib64 -ltk8.5 -lX11 -L/usr/lib64 -Wl,-rpath -Wl,/usr/lib64 -ltcl8.5 -ldl -lieee -lm
Authentication      : classic (pbs_iff)
[root]# cp contrib/init.d/suse.trqauthd /etc/init.d/trqauthd

Ready for 'make'.
http://docs.adaptivecomputing.com/suite/8-0/basic/help.htm#topics/torque/1-installConfig/installing.htm
Prerequisites:
Red Hat-based distributions using iptables:
[root]# iptables-save > /tmp/iptables.mod
[root]# vi /tmp/iptables.mod

# Add the following lines immediately *before* the line matching
# "-A INPUT -j REJECT --reject-with icmp-host-prohibited"
										
# Needed on the TORQUE server for client and MOM communication
 -A INPUT -p tcp --dport 15001 -j ACCEPT
										
# Needed on the TORQUE MOM for server and MOM communication
-A INPUT -p tcp --dport 15002 -j ACCEPT
-A INPUT -p tcp --dport 15003 -j ACCEPT

[root]# iptables-restore < /tmp/iptables.mod
[root]# service iptables save

执行总是失败，后来直接
iptables  -A INPUT -p tcp --dport 15001 -j ACCEPT

iptables  -A INPUT -p tcp --dport 15002 -j ACCEPT
iptables  -A INPUT -p tcp --dport 15003 -j ACCEPT
 service iptables save
(1) ./configure --prefix=/usr --with-server-home=/var/lib/torque --with-rcp=scp  --enable-nvidia-gpus --with-gnu-ld --enable-gui --with-pam --enable-drmaa >& configure.log &
(2)make rpm >& rpm.log & (注意，不要修改解压后的文件的名字) 

（3）yum localinstall ~/rpmbuild/RPMS/x86_64/torque-*rpm 或者rpm -ivh *.rpm
（4） The trqauthd daemon must be started to complete the remaining installation steps. For the appropriate distribution, do the following）
* If RHEL distribution, do the following *
[root]# cp contrib/init.d/trqauthd /etc/init.d/(检查一下这个文件已经有了，不需要这个cp命令了)
 
* For all aforementioned distributions, do the following:
 
[root]# chkconfig --add trqauthd
[root]# echo /usr/local/lib > /etc/ld.so.conf.d/torque.conf
[root]# ldconfig
[root]# service trqauthd start
(5)Initialize serverdb by executing the torque.setup script.
./torque.setup root

[root@service103 torque-5.1.0-1_4048f77c]# ./torque.setup root
initializing TORQUE (admin: root@service103)

You have selected to start pbs_server in create mode.
If the server database exists it will be overwritten.
do you wish to continue y/(n)?y
root      46527      1  0 06:46 ?        00:00:00 pbs_server -t create
Max open servers: 9
Max open servers: 9


这时候出错，开启失败，连接不到相应的hostname，后来在/etc/hosts下面添加了
10.10.2.103 service103

(7) install computer nodes 
mv /var/lib/torque /var/lib/torque

rpm -ivh torque-5.1.0-1.adaptive.el6.x86_64.rpm  torque-client-5.1.0-1.adaptive.el6.x86_64.rpm torque-devel-5.1.0-1.adaptive.el6.x86_64.rpm

cat mom_priv/config  
$pbsserver service103
$logevent      225

cat server_name  (xdsh login[151-153]  'sed -i "s/localhost/10.0.0.110/g" /var/lib/torque/server_name')

service103

xdsh login[150-153] 'chkconfig --add pbs_mom'

[root@shenma001 mom_priv]# service pbs_mom start
Starting TORQUE Mom: pbs_mom: LOG_ERROR::pbs_mom, server port = 15002, errno = 98 (Address already in use), already in use
server port = 15002, errno = 98 (Address already in use), already in use
                                                           [FAILED]
开启pbs_mom的时候出错。
原因是端口被占用，也许是因为之前有安装过这样的torque，虽然服务被关掉了，但是进程还在占着15002的端口
[root@shenma001 mom_priv]# ps -e |grep pbs_
 3960 ?        00:00:11 pbs_mom
[root@shenma001 mom_priv]# kill 3960
[root@shenma001 mom_priv]# ps -e |grep pbs_
[root@shenma001 mom_priv]# service pbs_mom start
Starting TORQUE Mom:                                       [  OK  ]

开启正常。



build maui rpm packages :


tar xzvf /install/archive/src/maui-3.3.1.tar.gz  -C . 
cd maui-3.3.1
./configure  --prefix=/usr/local --with-spooldir=/var/lib/maui/ --with-pbs=/usr --with-gold  >& configure.log &
make  >& make.log &
sed -i'.bkp' 's/\$(INST_DIR)/\$(DESTDIR)\/\$(INST_DIR)/g' src/*/Makefile
sed -i'' 's/\$(MSCHED_HOME)/\$(DESTDIR)\/\$(MSCHED_HOME)/g' src/*/Makefile
 DESTDIR=/tmp/maui make install
[ajdecon@tyr-sl maui-3.3.1]$ mkdir /tmp/maui/etc
[ajdecon@tyr-sl maui-3.3.1]$ mkdir /tmp/maui/etc/profile.d
[ajdecon@tyr-sl maui-3.3.1]$ mkdir /tmp/maui/etc/init.d
[ajdecon@tyr-sl maui-3.3.1]$ cp etc/maui.d /tmp/maui/etc/init.d/
[ajdecon@tyr-sl maui-3.3.1]$ cp etc/maui.{csh,sh} /tmp/maui/etc/profile.d/
[ajdecon@tyr-sl maui-3.3.1]$ cat /tmp/maui/post-install.sh 
#!/bin/bash
chkconfig --add maiu.d
chkconfig --level 3456 maui.d on
[ajdecon@tyr-sl maui-3.3.1]$ cat /tmp/maui/pre-uninstall.sh 
#!/bin/bash
chkconfig --del maui.d

[ajdecon@tyr-sl maui-3.3.1]$ fpm -s dir -t rpm -n maui -v 3.3.1 -C /tmp/maui \
-p /tmp/maui-3.3.1-x86_64-fpmbuild.rpm --post-install /tmp/maui/post-install.sh \
--pre-uninstall /tmp/maui/pre-uninstall.sh etc usr var

[ajdecon@tyr-sl maui-3.3.1]$ rpm -q --filesbypkg -p /tmp/maui-3.3.1-x86_64-fpmbuild.rpm 

yum localinstall /tmp/maui-3.3.1-x86_64-fpmbuild.rpm
(rpm -ivh maui-3.3.1-x86_64-fpmbuild.rpm 
chang the server in  maui.cfg )
===============================================================================================================================================================================================================================================================
install gold 

./configure --prefix=/usr/local  --with-PACKAGE --with-db=Pg  --with-perl-libs=local  --with-gold-libs=local --with-cgi-bin=/var/www/cgi-bin/gold --with-PACKAGE



Success. You can now start the database server using:

    postgres -D /var/lib/pgsql/data
or
    pg_ctl -D /var/lib/pgsql/data -l logfile start 
