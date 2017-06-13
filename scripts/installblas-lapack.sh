tar xvf blas.tar
make
mv LINUX_blas.a libblas.a

tar vxf lapck-3.4.2
cd lapack-3.4.2
cp ./INSTALL/make.inc.gfortran .

mv make.inc.gfortran make.inc

vim make.inc

BLASLIB      = /tmp/bulid-liuxj/BLAS/libblas.a (where is blas installed)
LAPACKLIB    = liblapack.a
TMGLIB       = libtmglib.a
LAPACKELIB   = liblapacke.a

make

#use the lf95 ,I can use the make.inc.pgf95.and not use the make.inc.gfortran

mv libblas.a liblapack.a libtmglib.a /pkg/blaslapack/3.4.2/lf95-8/lib/
