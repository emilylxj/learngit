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
NAME=pgplot
VERSION=5.2
NAME_SRC=$NAME-$VERSION
cd $LOG_DIR
mkdir -p $NAME/$VERSION/$PRG_ENV
cd $BUILD_DIR
tar xzf $SRC_DIR/$NAME_SRC.tar.gz
#mv ./drivers.list $BUILD_DIR/$NAME/
#cd $BUILD_DIR/$NAME
mkdir -p /pkg/$NAME/$VERSION/${PRG_ENV}
INSTALL_DIR=/pkg/$NAME/$VERSION/${PRG_ENV}
echo  $INSTALL_DIR
cd $INSTALL_DIR
cp $BUILD_DIR/drivers.list  . (chang makefile png.h to /usr/include/png.h)
#sed -ig 's/! PS/PS/' drivers.list
#sed -ig 's/! VPS/VPS/' drivers.list
#sed -ig 's/! CPS/CPS/' drivers.list
#sed -ig 's/! VCPS/VCPS/' drivers.list
#sed -ig 's/! XSERVE/XSERVE/' drivers.list
$BUILD_DIR/$NAME/makemake $BUILD_DIR/$NAME linux g77_gcc (replace the g77_gcc_aout)
sed -ig 's/FCOMPL=g77/FCOMPL=gfortran/' makefile
make  >>$LOG_DIR/$NAME/$VERSION/${PRG_ENV}/make.log 2>&1
make cpg  >>$LOG_DIR/$NAME/$VERSION/${PRG_ENV}/makecpg.log 2>&1
make clean >>$LOG_DIR/$NAME/$VERSION/${PRG_ENV}/makeclean.log 2>&1

#./configure  --prefix=/pkg/$NAME/$VERSION/${PRG_ENV}/  --with-openib=/usr --enable-openib-connectx-xrc   --with-fca=/opt/mellanox/fca --enable-mpi-thread-multiple --with-threads --with-hwloc --enable-heterogeneous --enable-binaries --with-devel-headers >>$LOG_DIR/$NAME/$VERSION/$PRG_ENV/configure.log 2>&1

#make -j 4 all >>$LOG_DIR/$NAME/$VERSION/${PRG_ENV}/make.log 2>&1

#make install >>$LOG_DIR/$NAME/$VERSION/$PRG_ENV/makeinstall.log 2>&1

#echo "build OpenMPI  $OPENMPI_VER Done!"
#cp $BUILD_DIR/$NAME/
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

