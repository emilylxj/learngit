#!/bin/bash
module purge

#load compiler
module load $1
#load zlib
module load $2

module load $3

echo "Build Packages use $1"

#MODULE_DIR=/pkg/modulefiles
#CATALOG=develop
BUILD_DIR=/tmp/build/`whoami`
SRC_DIR=/tmp/build/`whoami`/src
LOG_DIR=/tmp/build/`whoami`/log

NAME=hdf5
VERSION=1.8.10
NAME_SRC=$NAME-$VERSION

echo "======================================================================="

echo "build $NAME_SRC"
#NAME=hdf5
#VERSION=1.8.10
#NAME_SRC=$NAME-$VERSION
cd $LOG_DIR
mkdir -p $NAME/$VERSION/$PRG_ENV
cd $BUILD_DIR
tar xzf $SRC_DIR/$NAME_SRC.tar.gz
cd $BUILD_DIR/$NAME_SRC

#./configure  CC=mpiicc FC=mpiifort --enable-parallel --enable-fortran  --prefix=/pkg/hdf5/1.8.13 >& conigure.log &
#make -j 8>& make.log &

#make check  >& maketest.log &
#make  install>& makeinstall.log &
CC=/pkg/intel/composer_xe_2015.0.090/bin/intel64/icc
 CXX=/pkg/intel/composer_xe_2015.0.090/bin/intel64/icpc  
FC=/pkg/intel/composer_xe_2015.0.090/bin/intel64/ifort
./configure --prefix=/pkg/hdf5/1.8.10/$PRG_ENV   --enable-fortran --enable-cxx --with-zlib=$ZLIB_DIR --with-szlib=$SZIP_DIR --enable-hl  >>$LOG_DIR/$NAME/$VERSION/$PRG_ENV/configure.log 2>&1


#./configure --prefix=/pkg/hdf5/1.8.10-parallel/$PRG_ENV  CC=mpicc FC=mpif90 --enable-parallel  --enable-fortran --enable-cxx --with-zlib=/pkg/zlib/ >& conigure.log &
#./configure  --prefix=/pkg/$NAME/$VERSION/${PRG_ENV}/  --with-openib=/usr --enable-openib-connectx-xrc   --with-fca=/opt/mellanox/fca --enable-mpi-thread-multiple --with-threads --with-hwloc --enable-heterogeneous --enable-binaries --with-devel-headers >>$LOG_DIR/$NAME/$VERSION/$PRG_ENV/configure.log 2>&1

make -j 8  >>$LOG_DIR/$NAME/$VERSION/${PRG_ENV}/make.log 2>&1

make check  >>$LOG_DIR/$NAME/$VERSION/${PRG_ENV}/makecheck.log 2>&1
make install >>$LOG_DIR/$NAME/$VERSION/$PRG_ENV/makeinstall.log 2>&1

echo "build $NAME-$VERSION  Done!"

#make distclean
#./configure --prefix=/pkg/openmpi/$OPENMPI_VER/$PRG_ENV --with-openib   --enable-openib-connectx-xrc  --enable-mpi-thread-multiple --with-threads --with-hwloc --enable-heterogeneous --with-fca=/opt/mellanox/fca --with-mxm=/opt/mellanox/mxm


#make
#make install

#echo "build OpenMPI  $OPENMPI_VER Done!"

#cp $MODULE_DIR



#echo "build MVAPICH2 $MVAPICH2_VER Done!"

#tar -xzvf /install/archive/src/openmpi-1.6.3.tar.gz  -C /tmp/liuxj-build/
#module load complier/
#cd $LOG/openmpi
#mkdir $PRG_ENV
#cd  /tmp/liuxj-build/openmpi-1.6.3

#./configure  --prefix=/pkg/openmpi/1.6.3-new/${PRG_ENV}/  --with-openib=/usr --enable-openib-connectx-xrc --enable-mpi-thread-multiple --with-threads --with-hwloc --enable-heterogeneous --enable-binaries --with-devel-headers >&$LOG/openmpi/$PRG_ENV/configure.log &

#make -j 4 all >&$LOG/openmpi/${PRG_ENV}/make.log &

#su

#make install >&$LOG/openmpi/$PRG_ENV/makeinstall.log &

