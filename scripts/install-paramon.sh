#/bin/bash
xdsh manager[101-102],shenma[101-161,001-058],login[110-113],service[103-106],oss[00-03],mds[00-01],node[64-67],gpu[51-55] 'cp /etc/paratera /etc/paratera_0309'

xdsh service104 /etc/init.d/paramon-mgr stop

xdcp service104 paramon-pro-6.2.0-2046.centos7.x86_64.rpm  /tmp/

xdsh service104 'rpm -qa |grep paramon-pro'

xdsh service104 'rpm -e paramon-pro'

xdsh service104 'rpm -ivh /tmp/paramon-pro-6.2.0-2046.centos7.x86_64.rpm'

xdsh service104 'sed -i 's/PARATERA/C10B9FF/g' psvr* '

xdsh service104 'sed -i 's/PARATERA/C10B9FF/g' pcnt* '

xdsh service104 ' sed -i 's/127.0.0.1/10.10.0.104/g' pcnt* '

xdsh manager[101-102],shenma[101-161,001-058],login[110-113],service[103-106],oss[00-03],mds[00-01],node[64-67],gpu[51-55] ' /etc/init.d/paramon stop'

xdcp manager[101-102],shenma[101-161,001-058],login[110-113],service[103-106],oss[00-03],mds[00-01],node[64-67],gpu[51-55] 'paramon-pro-6.2.0-2046.centos6.x86_64.rpm  /tmp/'

xdsh manager[101-102],shenma[101-161,001-058],login[110-113],service[103-106],oss[00-03],mds[00-01],node[64-67],gpu[51-55] 'rpm -e paramon-pro'

xdsh manager[101-102],shenma[101-161,001-058],login[110-113],service[103-106],oss[00-03],mds[00-01],node[64-67],gpu[51-55] 'rpm -ivh /tmp/paramon-pro-6.2.0-2046.centos6.x86_64.rpm'

xdsh manager101 'sed -i 's/PARATERA/C10B9FF/g' pcnt*'

xdsh manager101 'sed -i 's/127.0.0.1/10.10.0.104/g' pcnt*'

xdsh manager101 'cp /etc/paratera_0309/utils.conf /etc/paratera/'

xdcp manager102,shenma[101-161,001-058],login[110-113],service[103-106],oss[00-03],mds[00-01],node[64-67],gpu[51-55]   /etc/paratera/pcnt* /etc/paratera/

xdcp manager102,shenma[101-161,001-058],login[110-113],service[103-106],oss[00-03],mds[00-01],node[64-67],gpu[51-55]   /etc/paratera/utils.conf  /etc/paratera/

xdsh manager102,shenma[101-161,001-058],login[110-113],service[103-106],oss[00-03],mds[00-01],node[64-67],gpu[51-55]  /etc/init.d/paramon start

xdsh service104 /etc/init.d/paramon-mgr start

##about lic

cd 中科院等离子体物理研究所

for i in `seq 101 161` ;do scp shenma${i}_paramon-cnt.lic  root@shenma${i}:/etc/paratera/lic/ ;done

for i in `seq 101 161`;do xdsh shenma${i} mv  /etc/paratera/lic/shenma${i}_paramon-cnt.lic /etc/paratera/lic/paramon-cnt.lic ;done


