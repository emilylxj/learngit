(1)trsub_batch:
#!/bin/bash
RUNID=$1

date


trqsub $RUNID all 2x8 -q batch

#trqsub $RUNID all -q q2

date

!!!!./trsub_batch 22111A01

!!!!now the $RUNID is 22111A01

(2)look at the scrip:trqsub

its log is send into the termimal ,such as:
------------------------------------------------------
If you look the trqsub ,you will find the trunly use is pbs_mpi_qsub
----------------------------------------------------------
[liuxj@shenma162 22111]$ ../trsub_batch1\*8 22111A06
Wed Sep 18 14:58:59 CST 2013
 runid: 22111A06 
pbsque = batch
 runtr_arg: all 
 jobsize: 2x8 
 jobname: q22111A06_2x8 
 joblog: /scratch/liuxj/transp-complie/transpruns/Runs/EAST/22111/q22111A06_2x8.joblog   !!!!this job.log is important.
 (this is the pbs log, separate from 22111A06tr.log)
 
 %trqsub walltime default, no TRQSUB_TIME_LIMIT, 80:00:00
 %trqsub memory default, no TRQSUB_MEM_LIMIT, 1900mb per cpu

!!!!!#  determine output directory: if /local, replace with /l/<hostname>
    set loc_cwd = `pwd`
    set loc_host = `hostname | sed 's#\..*##'`
    set test_cwd = `echo $loc_cwd | sed 's#^/local/##'`
    if ( $test_cwd != $loc_cwd ) then
        set loc_cwd = "/l/$loc_host/$test_cwd"
    endif

now the loc_cwd is /scratch/liuxj/transp-complie/transpruns/Runs/EAST/22111
that is 'pwd'.
----------------------------------------------------------------------
------------------------------------------------------------------------

-----------------------------------------------------------------------------
THE following outfile is the 'pbs_mpi_qsub'
-----------------------------------------------------------------------------
 PBS template file: /install/build/liuxj/source/transp/codesys/pbs/pppl_trmpi_NxM.tcsh 
 N (#nodes): 2
 M (#processors per node): 8
 
OK:
cwd: /scratch/liuxj/transp-complie/transpruns/Runs/EAST/22111
 
  To use MPI Group Communicator for NUBEAM, enter nbi_nprocs: 8
 
  To use MPI Group Communicator for TORIC, enter toric_nprocs: 8
 
pbs_mpi_qsub: 
qsub -l mem=30400mb -l walltime=80:00:00 -N q22111A06_2x8 -v RUNTR_ARG=all,LOG_LEVEL=1 -o /scratch/liuxj/transp-complie/transpruns/Runs/EAST/22111/q22111A06_2x8.joblog -q batch -l mem=30400mb pppl_trmpi_2x8_21861.tcsh
 
17676.master
 
pbs_mpi_qsub: done, status = 0 
--------------------------------------------------------------------------------
Look the up file ,you will find the 'pppl_trmpi_2x8_21861.tcsh' which is producted by pppl_trmpi_NxM.tcsh.It is the actully important!!!
-------------------------------------------------------------------------------


-----------------------------------------------------------------------------
The follow informantion is found in  'trqsub'
----------------------------------------------------------------------------- 
PPPL MPI TRANSP job requested (to check -- use qstat command).
Wed Sep 18 15:15:11 CST 2013


(3)pbs_mpi_qsub :

According to the up information ,you will find this!

(4) pppl_trmpi_2x8.tcsh

(5)pppl_trmpi_2x8_'get_a_pid'.tcsh
