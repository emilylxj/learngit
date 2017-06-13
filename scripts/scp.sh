#!/bin/bash
for i in blacs blaslapack cmake fftw gcc general_libs  GotoBLAS2 hdf5  lf95 libs  mdsplus matlab metis modulefiles mpich MUMPS mvapich2     ncl_ncarg netcdf  openmpi  pgplot pygtk  python python-modules scalapack  software  superlu szip vtk zlib 
do 

scp -r /pkg/${i}  root@211.86.151.151:/pkg/ 

done 
