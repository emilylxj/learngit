#!/bin/bash

LOG=/backup/scratch/log
#for i in acml        gcc           libs         modulefiles.old  pgi           
#for i in  acml        gcc           libs      modulefiles.old  pgi  szip blacs       general_libs  llvm         mpich            pgplot          vorpal blaslapack  hdf5          lua          MUMPS            python          vtk cmake           matlab       mvapich2         python-modules  zlib   comsol      intel         mdsplus      ncl_ncarg        scalapack eclipse     intel.old     metis        netcdf           software fftw        lf95          modulefiles  openmpi          superlu
for i in EAST38300n  east41545  Nov12  solps_examples  test test_OT EAST38300r  ftransfer  Snowflake  speed_test      test-east

#LOG = /backup/pkg/log
#echo $LOG
do

echo "==========Begin rsync $i: $(date)===========" >>$LOG/xiaty/$i.log 2>&1
rsync -avzrtopglH  /backup02/scratch/xiaty/$i  /backup/scratch/xiaty/  >>$LOG/xiaty/$i.log 2>&1
echo "==========End rsync $i: $(date)===========" >>$LOG/xiaty/$i.log 2>&1

done       
