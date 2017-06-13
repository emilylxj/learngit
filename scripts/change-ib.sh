!#/bin/bash

for i in $(seq 2 20)

cd /etc/sysconfig/network-scripts/

mv ifcfg-eth0 ifcfg-eth0.old

mv ifcfg-eth0.bak ifcfg-eth0
 

do 

sed -i "s/12.0.2.$i/12.0.0.$i/g"  /etc/sysconfig/network-scripts/ifcfg-ib0

done

for i in $(seq 6 10);do ssh 12.0.2.${i} sed -i "s/12.0.2.${i}/12.0.0.${i}/g"  /etc/sysconfig/network-scripts/ifcfg-ib0 ;done

for i in $(seq 2 63 );do ssh  root@12.0.0.${i}  mv /etc/sysconfig/network-scripts/ifcfg-eth0  /etc/sysconfig/network-scripts/ifcfg-eth0.old  ;done

