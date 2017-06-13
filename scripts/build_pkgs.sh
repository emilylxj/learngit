#!/bin/bash
module purge


module load $1

echo "Build Packages $1"

MODULE_DIR=/pkg/modulefiles
CATALOG=develop
BUILD_DIR=/work/build/`whoami`
SRC_DIR=/install/archive/src/

echo "======================================================================="

PKG_NAME=mvapich2
PKG_VER=1.9a2
PKG_SRC=$PKG_NAME-$PKG_VER

echo "build $PKG_SRC"

cd $BUILD_DIR
tar xzf $SRC_DIR/$PKG_SRC.tgz
cd $BUILD_DIR/$PKG_SRC

make distclean
./configure --prefix=/pkg/$PKG_NAME/$PKG_VER/$PRG_ENV 
make
make install 

cp $MODULE_DIR



echo "build MVAPICH2 $MVAPICH2_VER Done!"



#TORQUE_VER=2.5.12
#TORQUE_SRC=torque-$TORQUE_VER
#cd $BUILD_DIR
#tar xzvf $SRC_DIR/$TORQUE_SRC.tar.gz
#cd $BUILD_DIR/$TORQUE_SRC
#./configure --prefix=/usr/  --enable-nvidia-gpus --with-scp --with-server-home=/var/lib/torque/ --with-pam
#make rpms


echo "======================================================================="
echo "build OpenMPI"

OPENMPI_VER=1.6.3
OPENMPI_SRC=openmpi-$OPENMPI_VER
cd $BUILD_DIR
tar xzf $SRC_DIR/$OPENMPI_SRC.tar.gz
cd $BUILD_DIR/$OPENMPI_SRC

make distclean
./configure --prefix=/pkg/openmpi/$OPENMPI_VER/$PRG_ENV --with-openib   --enable-openib-connectx-xrc  --enable-mpi-thread-multiple --with-threads --with-hwloc --enable-heterogeneous --with-fca=/opt/mellanox/fca --with-mxm=/opt/mellanox/mxm 
make 
make install

echo "build OpenMPI  $OPENMPI_VER Done!"

