(1)查看内存设置情况：
cat /etc/security/limits.conf
* soft memlock unlimited
* hard memlock unlimited


$ ulimit -a
core file size          (blocks, -c) 0
data seg size           (kbytes, -d) unlimited
scheduling priority             (-e) 0
file size               (blocks, -f) unlimited
pending signals                 (-i) 515079
max locked memory       (kbytes, -l) unlimited
max memory size         (kbytes, -m) unlimited
open files                      (-n) 1024
pipe size            (512 bytes, -p) 8
POSIX message queues     (bytes, -q) 819200
real-time priority              (-r) 0
stack size              (kbytes, -s) unlimited
cpu time               (seconds, -t) unlimited
max user processes              (-u) 1024
virtual memory          (kbytes, -v) unlimited
file locks                      (-x) unlimited


可见该设置的地方都是unlimited。

(2)

后来我查了openmpi的网站http://www.open-mpi.org/faq/?category=openfabrics#ib-locked-pages-user，以及其他的网站

http://stackoverflow.com/questions/17755433/how-can-i-increase-openfabrics-memory-limit-for-torque-jobs
http://comments.gmane.org/gmane.comp.clustering.open-mpi.user/18027，

说是mellanox里面设置的问题，重要的参数是log_num_mtt 和log_mtts_per_seg，并且It is recommended that you adjust log_num_mtt (or num_mtt) such that your max_reg_mem value is at least twice the amount of physical memory on your machine (setting it to a value higher than the amount of physical memory present allows the internal Mellanox driver tables to handle fragmentation and other overhead).

所以我就在 vim /etc/modprobe.d/mlx4_en.conf中添加设置
options mlx4_core log_num_mtt=24
options mlx4_core log_mtts_per_seg=1

为了使它生效，所以我想重启驱动，或者是这个模块。


/etc/init.d/openibd start/status/stop/restart

modprobe -r mlx4_en
          modprobe  mlx4_en

another ways:

 1011  xdsh shenma[1-10,101-161] 'chmod 644 /sys/module/mlx4_core/parameters/log_num_mtt'
 1012  xdsh shenma[1-10,101-161] 'chmod 644 /sys/module/mlx4_core/parameters/log_mtts_per_seg'
 1013  xdsh shenma[1-10,101-161] 'echo "24" > /sys/module/mlx4_core/parameters/log_num_mtt'
 1014  xdsh shenma[1-10,101-161] 'echo "1" > /sys/module/mlx4_core/parameters/log_mtts_per_seg'
 1015  xdsh shenma[1-10,101-161] 'cat  /sys/module/mlx4_core/parameters/log_mtts_per_seg'

