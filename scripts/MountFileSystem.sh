#!/bin/bash
xdsh shenma[1-10,101-161] mount -t nfs -o ro,rsize=8192,wsize=8192,timeo=14,intr 10.10.1.36:/ibfs/pkg /pkg
xdsh shenma[1-10,101-161] mount -t nfs -o ro,rsize=8192,wsize=8192,timeo=14,intr 10.10.1.37:/ibfs/install /install
xdsh shenma[1-10,101-161] mount -t nfs -o ro,rsize=8192,wsize=8192,timeo=14,intr 10.10.1.39:/ibfs/project /project

xdsh shenma[162-163] mount -t nfs -o rw,rsize=8192,wsize=8192,timeo=14,intr 10.10.1.36:/ibfs/pkg /pkg
xdsh shenma[162-163] mount -t nfs -o rw,rsize=8192,wsize=8192,timeo=14,intr 10.10.1.37:/ibfs/install /install
xdsh shenma[162-163] mount -t nfs -o rw,rsize=8192,wsize=8192,timeo=14,intr 10.10.1.39:/ibfs/project /project


xdsh shenma[1-10,101-126] mount -t nfs -o ro,rsize=8192,wsize=8192,timeo=14,intr 10.10.1.36:/ibfs/home /home
xdsh shenma[127-161] mount -t nfs -o ro,rsize=8192,wsize=8192,timeo=14,intr 10.10.1.37:/ibfs/home /home
xdsh shenma[162] mount -t nfs -o rw,rsize=8192,wsize=8192,timeo=14,intr 10.10.1.36:/ibfs/home /home
xdsh shenma[163] mount -t nfs -o rw,rsize=8192,wsize=8192,timeo=14,intr 10.10.1.37:/ibfs/home /home


#xdsh shenma[1-10,101-163] mount -t lustre -o flock 12.0.1.64@o2ib0:12.0.1.65@o2ib0:/ParaStor /scratch

