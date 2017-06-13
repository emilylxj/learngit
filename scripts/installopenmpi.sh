#!/bin/bash
module purge


module load $1

echo "Build Packages $1"

#MODULE_DIR=/pkg/modulefiles
#CATALOG=develop
BUILD_DIR=/tmp/build/`whoami`
SRC_DIR=/tmp/build/`whoami`/src
LOG_DIR=/tmp/build/`whoami`/log
echo "======================================================================="

echo "build OpenMPI"
NAME=openmpi
VERSION=1.6.3
NAME_SRC=$NAME-$VERSION
cd $LOG_DIR
mkdir -p $NAME/$VERSION/$PRG_ENV
cd $BUILD_DIR
tar xzf $SRC_DIR/$NAME_SRC.tar.gz
cd $BUILD_DIR/$NAME_SRC

./configure  --prefix=/pkg/$NAME/$VERSION/${PRG_ENV}/  --with-openib=/usr --enable-openib-connectx-xrc   --with-fca=/opt/mellanox/fca --enable-mpi-thread-multiple --with-threads --with-hwloc --enable-heterogeneous --enable-binaries --with-devel-headers >>$LOG_DIR/$NAME/$VERSION/$PRG_ENV/configure.log 2>&1

make -j 4 all >>$LOG_DIR/$NAME/$VERSION/${PRG_ENV}/make.log 2>&1

make install >>$LOG_DIR/$NAME/$VERSION/$PRG_ENV/makeinstall.log 2>&1

echo "build OpenMPI  $OPENMPI_VER Done!"

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

