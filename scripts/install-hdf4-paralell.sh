./configure  CC=mpiicc FC=mpiifort --enable-parallel --enable-fortran  --prefix=/pkg/hdf5/1.8.13 >& conigure.log &
make -j 8>& make.log &

make check  >& maketest.log &
make  install>& makeinstall.log &
./configure --prefix=/pkg/hdf5/1.8.10/$PRG_ENV   --enable-fortran --enable-cxx --with-zlib=/pkg/zlib/ >& conigure.log &


./configure --prefix=/pkg/hdf5/1.8.10-parallel/$PRG_ENV  CC=mpiicc FC=mpif90 --enable-parallel  --enable-fortran --enable-cxx --with-zlib=/pkg/zlib/ >& conigure.log &
