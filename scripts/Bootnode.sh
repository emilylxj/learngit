reboot

ping 10.10.1.10 

ssh shenma10

df -h


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
  942  ssh shenma1
  943  xdsh shenma[1-10] 'mount -t nfs 10.10.1.1:/local/ /l/shenma1'
  944  xdsh shenma[1-10] 'mount -t nfs 10.10.1.2:/local/ /l/shenma2'
  945  xdsh shenma[1-10] 'mount -t nfs 10.10.1.3:/local/ /l/shenma3'
  946  xdsh shenma[1-10] 'mount -t nfs 10.10.1.4:/local/ /l/shenma4'
  947  xdsh shenma[1-10] 'mount -t nfs 10.10.1.5:/local/ /l/shenma5'
  948  xdsh shenma[1-10] 'mount -t nfs 10.10.1.6:/local/ /l/shenma6'
  949  xdsh shenma[1-10] 'mount -t nfs 10.10.1.7:/local/ /l/shenma7'
  950  xdsh shenma[1-10] 'mount -t nfs 10.10.1.8:/local/ /l/shenma8'
  951  xdsh shenma[1-10] 'mount -t nfs 10.10.1.9:/local/ /l/shenma9'
  952  xdsh shenma[1-10] 'mount -t nfs 10.10.1.10:/local/ /l/shenma10'
  953  xdsh shenma[1-10] 'df -h'

xdsh shenma[1-10,101-161] mount -t nfs -o ro,rsize=8192,wsize=8192,timeo=14,intr 10.10.1.36:/ibfs/pkg /pkg
xdsh shenma[1-10,101-161] mount -t nfs -o ro,rsize=8192,wsize=8192,timeo=14,intr 10.10.1.37:/ibfs/install /install
xdsh shenma[1-10,101-161] mount -t nfs -o ro,rsize=8192,wsize=8192,timeo=14,intr 10.10.1.38:/ibfs/home /home
xdsh shenma[1-10,101-161] mount -t nfs -o ro,rsize=8192,wsize=8192,timeo=14,intr 10.10.1.39:/ibfs/project /project
xdsh shenma[1-10,101-161] mount -t lustre -o flock 12.0.1.64@o2ib0:12.0.1.65@o2ib0:/ParaStor /scratch

