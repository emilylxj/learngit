#!/bin/bash
module purge

#load compiler
module load $1
#load mpi:because install the mpi fftw by the option --enable-mpi
module load $2

echo "Build Packages use $1"

#MODULE_DIR=/pkg/modulefiles
#CATALOG=develop
BUILD_DIR=/tmp/build/`whoami`
SRC_DIR=/tmp/build/`whoami`/src
LOG_DIR=/tmp/build/`whoami`/log

NAME=fftw
VERSION=3.3.3
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
#./configure --prefix=/pkg/hdf5/1.8.10/$PRG_ENV   --enable-fortran --enable-cxx --with-zlib=/pkg/zlib/ >>$LOG_DIR/$NAME/$VERSION/$PRG_ENV/configure.log 2>&1
echo "install the default double fftw "
./configure --prefix=/pkg/fftw/3.3.3/$PRG_ENV/$MPI_PRG_ENV  --enable-shared --enable-openmp --enable-mpi --enable-threads --with-gnu-ld  --enable-fortran >>$LOG_DIR/$NAME/$VERSION/$PRG_ENV/configure.log 2>&1
make -j 8  >>$LOG_DIR/$NAME/$VERSION/${PRG_ENV}/make.log 2>&1

make check  >>$LOG_DIR/$NAME/$VERSION/${PRG_ENV}/makecheck.log 2>&1
make install >>$LOG_DIR/$NAME/$VERSION/$PRG_ENV/makeinstall.log 2>&1

echo "the install is finished"

echo "install the float fftw in the same directory"
./configure --prefix=/pkg/fftw/3.3.3/$PRG_ENV/$MPI_PRG_ENV  --enable-shared --enable-openmp --enable-mpi --enable-threads --with-gnu-ld --enable-float --enable-fortran >>$LOG_DIR/$NAME/$VERSION/$PRG_ENV/configure.log 2>&1
make -j 8  >>$LOG_DIR/$NAME/$VERSION/${PRG_ENV}/make.log 2>&1

make check  >>$LOG_DIR/$NAME/$VERSION/${PRG_ENV}/makecheck.log 2>&1
make install >>$LOG_DIR/$NAME/$VERSION/$PRG_ENV/makeinstall.log 2>&1

echo "the two install is ok"

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

