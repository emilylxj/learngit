
(1)config the file /etc/exports

ssh shenma1:vim  /etc/exports

            /local  *(rw,no_root_squash,async)

（2）启动nfs
/etc/init.d/rpcbind start 
/etc/init.d/nfs start
/etc/init.d/nfslock start
chkconfig rpcbind on
chkconfig nfs on
chkconfig nfslock on
启动之后，到/var/log/messages下看看有没有正确启动

还可以看下nfs到底开了哪些端口
netstat -tulnp | grep -E '(rpc|nfs)'


(3)扫描nfs服务器共享的目录有哪些，并了解我们是否可以使用
showmount -ae hostname|IP
-a 显示当前主机和客户端的nfs连接共享的状态

-e 显示某台主机的/etc/exports所共享的目录数据
[root@shenma1 ~]# showmount -e shenma1
   Export list for shenma1:
   /local *

(4)creat the directoy which you want to mount
 
932  xdsh shenma[2-10] 'mkdir -p /l/shenma1'
  933  xdsh shenma[2-10] 'mkdir -p /l/shenma2'
  934  xdsh shenma[2-10] 'mkdir -p /l/shenma3'
  935  xdsh shenma[2-10] 'mkdir -p /l/shenma4'
  936  xdsh shenma[2-10] 'mkdir -p /l/shenma5'
  937  xdsh shenma[2-10] 'mkdir -p /l/shenma6'
  938  xdsh shenma[2-10] 'mkdir -p /l/shenma7'
  939  xdsh shenma[2-10] 'mkdir -p /l/shenma8'
  940  xdsh shenma[2-10] 'mkdir -p /l/shenma9'
  941  xdsh shenma[2-10] 'mkdir -p /l/shenma10'


(5)mount

  943  xdsh shenma[2-10] 'mount -t nfs 10.10.1.1:/local/ /l/shenma1'
  944  xdsh shenma[2-10] 'mount -t nfs 10.10.1.2:/local/ /l/shenma2'
  945  xdsh shenma[2-10] 'mount -t nfs 10.10.1.3:/local/ /l/shenma3'
  946  xdsh shenma[2-10] 'mount -t nfs 10.10.1.4:/local/ /l/shenma4'
  947  xdsh shenma[2-10] 'mount -t nfs 10.10.1.5:/local/ /l/shenma5'
  948  xdsh shenma[2-10] 'mount -t nfs 10.10.1.6:/local/ /l/shenma6'
  949  xdsh shenma[2-10] 'mount -t nfs 10.10.1.7:/local/ /l/shenma7'
  950  xdsh shenma[2-10] 'mount -t nfs 10.10.1.8:/local/ /l/shenma8'
  951  xdsh shenma[2-10] 'mount -t nfs 10.10.1.9:/local/ /l/shenma9'
  952  xdsh shenma[2-10] 'mount -t nfs 10.10.1.10:/local/ /l/shenma10'


 
