cd $$WORKDIR/EAST/
cp 22111 .
cd 22111
vim 22111A0*TR.DAT(how to fix,i dont know)
trdat 22111A05
pretr MPI 22111A05
../trsub_batch 22111A05
