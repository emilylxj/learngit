#!/bin/bash

LOG=/backup/other/scratch-backup/scratch-back-20150318/log
cd /project
ls >name.list
Rsynclist=/project/name.list
Rsyncname=`cat $Rsynclist`
#for i in acml        gcc           libs         modulefiles.old  pgi           
#for i in  acml        gcc           libs      modulefiles.old  pgi  szip blacs       general_libs  llvm         mpich            pgplot          vorpal blaslapack  hdf5          lua          MUMPS            python          vtk cmake           matlab       mvapich2         python-modules  zlib   comsol      intel         mdsplus      ncl_ncarg        scalapack eclipse     intel.old     metis        netcdf           software fftw        lf95          modulefiles  openmpi          superlu

#LOG = /backup/project/log
#echo $LOG
for i in $Rsyncname
do

echo "==========Begin rsync $i: $(date)===========" >>$LOG/$i.log 2>&1
rsync -avzopg /scratch/project/$i /backup/other/scratch-backup/scratch-back-20150318/project-20150318/ >>$LOG/$i.log 2>&1
#rsync -avzrtopglH  /scratch/project/$i  /backup/project/  >>$LOG/$i.log 2>&1
echo "==========End rsync $i: $(date)===========" >>$LOG/$i.log 2>&1

done       
