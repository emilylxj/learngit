
for intel compiler :
CC=/pkg/intel/composer_xe_2015.0.090/bin/intel64/icc  ./configure --prefix=/pkg/zlib/1.2.8/$PRG_ENV

make test

make install 
./configure is only change the prefix or shared and other . the makefile is esited!

and compiler the zlib is just use the cc,and cannot use fortran.so lf95 and gcc is same .cannot chang something.

make

 make install

module load compiler

for intel compiler 

CC=/pkg/intel/composer_xe_2015.0.090/bin/intel64/icc CXX=/pkg/intel/composer_xe_2015.0.090/bin/intel64/icpc  F77=/pkg/intel/composer_xe_2015.0.090/bin/intel64/ifort
./configure  --prefix=/pkg/szip/2.1/$PRG_ENV  --disable-encoding (no license ,you must choose this )

make

make check ((you should get an error message when you try to test since
                 encoding is disabled))

make install
