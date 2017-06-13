ftp://ftp.unidata.ucar.edu/pub/netcdf/old
#!/bin/bash

module purge

#load compiler
module load $1
#module load mpi
module load $2
#load hdf5
#module load $3

echo "Build Packages use $1 and $2"

#MODULE_DIR=/pkg/modulefiles
#CATALOG=develop
BUILD_DIR=/tmp/build/`whoami`
SRC_DIR=/tmp/build/`whoami`/src
LOG_DIR=/tmp/build/`whoami`/log

NAME=netcdf
VERSION=4.1.3
NAME_SRC=$NAME-$VERSION

echo "======================================================================="

echo "build $NAME_SRC"
cd $LOG_DIR
mkdir -p $NAME/$VERSION/$PRG_ENV
cd $BUILD_DIR
tar xzf $SRC_DIR/$NAME_SRC.tar.gz
cd $BUILD_DIR/$NAME_SRC
$ export CC=icc
$ export CXX=icpc
$ export CFLAGS='-O3 -xT -ip -no-prec-div -m64'
$ export CXXFLAGS='-O3 -xT -ip -no-prec-div -m64'

$ export F77=ifort
$ export FFLAGS='-O3 -xT -ip -no-prec-div -m64'
CC=/pkg/intel/composer_xe_2015.0.090/bin/intel64/icc
CFLAGS='-O3 -xHost -ip -no-prec-div -m64'
CXXFLAGS='-O3 -xHost -ip -no-prec-div -m64'
FFLAGS='-O3 -xHost -ip -no-prec-div -m64'
CPP='icc -E'
CXXCPP='icpc -E'
 CXX=/pkg/intel/composer_xe_2015.0.090/bin/intel64/icpc
FC=/pkg/intel/composer_xe_2015.0.090/bin/intel64/ifort
F77=/pkg/intel/composer_xe_2015.0.090/bin/intel64/ifort
CPPFLAGS=' -I'${INCLUDE}'   -I'${ZLIB_DIR}'/include -I'${HDF5_DIR}'/include -I'${SZIP_DIR}'/include'  LDFLAGS='-L'${ZLIB_DIR}'/lib -L'${SZIP_DIR}'/lib -L'${LD_LIBRARY_PATH}' -L'${HDF5_DIR}'/lib' ./configure   --prefix=/pkg/netcdf/4.1.3/$PRG_ENV --enable-shared --enable-cxx-4 --enable-fortran --enable-cxx  --enable-static --enable-netcdf-4   --disable-dap >>$LOG_DIR/$NAME/$VERSION/${PRG_ENV}/configure.log 2>&1

make check install >>$LOG_DIR/$NAME/$VERSION/${PRG_ENV}/make.log 2>&1



#make -j 8  >>$LOG_DIR/$NAME/$VERSION/${PRG_ENV}/make.log 2>&1

#make check  >>$LOG_DIR/$NAME/$VERSION/${PRG_ENV}/makecheck.log 2>&1
#make install >>$LOG_DIR/$NAME/$VERSION/$PRG_ENV/makeinstall.log 2>&1

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


export CPPFLAGS='-I'${ZLIB_DIR}'/include -I'${HDF5_DIR}'/include -I'${SZIP_DIR}'/include'
export LDFLAGS='-L'${ZLIB_DIR}'/lib -L'${SZIP_DIR}'/lib  -L'${HDF5_DIR}'/lib'
./configure      --prefix=/pkg/netcdf/4.3.2/$PRG_ENV --enable-shared --enable-static --enable-netcdf-4   --disable-dap




CFLAGS='-O3 -xHost -ip -no-prec-div -m64'
CXXFLAGS='-O3 -xHost -ip -no-prec-div -m64'
FFLAGS='-O3 -xHost -ip -no-prec-div -m64'
CPP='icc -E'
CXXCPP='icpc -E'
CPPFLAGS='-DNDEBUG -DpgiFortran  -I'${INCLUDE}'   -I'${ZLIB_DIR}'/include -I'${HDF5_DIR}'/include -I'${SZIP_DIR}'/include'
LDFLAGS='-L'${ZLIB_DIR}'/lib -L'${SZIP_DIR}'/lib -L'${LD_LIBRARY_PATH}' -L'${HDF5_DIR}'/lib' 

export CPPFLAGS=' -I'${INCLUDE}'   -I'${ZLIB_DIR}'/include -I'${HDF5_DIR}'/include -I'${SZIP_DIR}'/include'
export  LDFLAGS='-L'${ZLIB_DIR}'/lib -L'${SZIP_DIR}'/lib -L'${LD_LIBRARY_PATH}' -L'${HDF5_DIR}'/lib'

CPPFLAGS=' -I'${INCLUDE}'   -I'${ZLIB_DIR}'/include -I'${HDF5_DIR}'/include -I'${SZIP_DIR}'/include'  LDFLAGS='-L'${ZLIB_DIR}'/lib -L'${SZIP_DIR}'/lib -L'${LD_LIBRARY_PATH}' -L'${HDF5_DIR}'/lib' ./configure   --prefix=/pkg/netcdf/4.1.3/$PRG_ENV --enable-shared --enable-static --enable-netcdf-4   --disable-dap



  904  CC=icc CXX=icpc FC=ifort F77=ifort F90=ifort CPPFLAGS=-I$HDF5_DIR/include LDFLAGS=-L$HDF5_DIR/lib ../configure --enable-netcdf4 --enable-cxx-4 --disable-f90 --disable-compiler-recover --disable-dap --prefix=/pkg/netcdf/4.1.3/$PRG_ENV
  905  make -j 32
  906  make check >& makecheck.log & 
  907  tail -f makecheck.log 
  908  vim makecheck.log 
  909  cd ..
  910  vim help.log 
  911  cd build
  912  ls
  913  make install >$makeinstall.log &


CC=icc CXX=icpc FC=ifort F77=ifort F90=ifort CPPFLAGS=' -I'${ZLIB_DIR}'/include -I'${HDF5_DIR}'/include  -I'${SZIP_DIR}'/include' LDFLAGS=' -L'${ZLIB_DIR}'/lib -L'${SZIP_DIR}'/lib -L'${HDF5_DIR}'/lib ' ../configure --enable-netcdf4 --enable-cxx-4  --disable-compiler-recover --disable-dap --enable-f90 --prefix=/pkg/netcdf/4.1.3/$PRG_ENV-f90

