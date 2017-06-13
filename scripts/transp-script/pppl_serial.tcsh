#!/bin/tcsh -f
#
# DMC -- modified for a serial TRANSP job -- PPPL RedHat 4 PBS environment
#
# Assumption: ~/.cshrc sets USER_ENV_RESET_DISABLED to prevent system
# reset of PATH and module loads on shell startup.  Note use of "-f" switch.
#
# Note: if generalized for parallel job use, check whether ~/.login needs
# to be executed.  This is done by seeing of the command "runtr" is defined.
#
#============================================================================
# (comments from the PPPL system PBS script template...)
#
# --- this is a sample script for running a program on the beowulf
#     cluster. You modify this script for your needs, then use the
#     'qsub' command to submit it to the cluster's job scheduler.
#
#     The job scheduler is the Portable Batch System (PBS). It
#     uses directives in this file to determine where to run
#     the job, how many hosts to run it upon, where to put output
#     files, etc.
#
# remarks: a line beginning with # is a comment
#          a line beginning with #PBS is a pbs directive
#          assume (upper/lower) case to be sensitive
#
# ------------------------------------------------------------
# Basic Information
#
# --- the name of your job
#PBS -N testjob
 
# --- Mail options
#     mail on execution("b"), termination ("e"), or interruption ("a")
#PBS -m aeb
 
# ------------------------------------------------------------
# Job execution details
 
# --- run the job on 'n' nodes with 'y' processors per node (ppn)
###PBS -l nodes=1:ppn=1

# --- specify the period of time the job will run in the format
#     hh:mm:ss (ex. 72 hours is 72:00:00)
#     run will gracefully exit after "walltime - 6" hours
#     and automatically restart. 
#     The 6 hours are grace time to be sure a restart file was written. 
#     3 days = 72+6 = 78
#PBS -l walltime=78:00:00

# --- submit this job to a special queue. If you do not specify a
#     special queue, the job will run in the default queue
#     There are three main queues at PPPL:
#     kestrel - the default queue used for multi node jobs
#     kite - a special queue of nodes connected with Infiniband
#     sque - nodes used for single CPU jobs (serial jobs)
#PBS -q sque

# --- do not rerun this job if it fails
#PBS -r n

# ------------------------------------------------------------
# When a batch job starts execution, a number of environment
# variables are predefined, which include:
#
#      Variables defined on the execution host.
#      Variables exported from the submission host with
#                -v (selected variables) and -V (all variables).
#      Variables defined by PBS.
#
# The following reflect the environment where the user ran qsub:
# PBS_O_HOST    The host where you ran the qsub command.
# PBS_O_LOGNAME Your user ID where you ran qsub.
# PBS_O_HOME    Your home directory where you ran qsub.
# PBS_O_WORKDIR The working directory where you ran qsub.
#
# These reflect the environment where the job is executing:
# PBS_ENVIRONMENT is set by PBS to "PBS_BATCH" if the job is a batch job, or
#                 to "PBS_INTERACTIVE" if the job is an interactive job.
# PBS_O_QUEUE   The original queue you submitted to.
# PBS_QUEUE     The queue the job is executing from.
# PBS_JOBID     The job's PBS identifier.
# PBS_JOBNAME   The job's name.

# export all my environment variables to the job
#### no do not ### PBS -V

# --- define standard output and error files for the job
#     default is <jobname>.o<jobid> and <jobname>.e<jobid>
##PBS -o test.out
##PBS -e test.err
# --- or combine both output and error streams into one file with the
#     job name and id as the default file name
#PBS -j oe

# ------------------------------------------------------------
# CHECK ENVIRONMENT

###SWAPGCC source /u/pshare/tshare_gcc_setup.csh

# 03/14/2013 CLF
# If mounted filesystem, do not create/move directories
if ($?SHENMA_HOST) then
   set NO_MOVE = 1
endif


if ($?NERSC_HOST) then
   set NO_MOVE = 1
endif

set runtr_chk = `which runtr`

@ ier = 0
if ( $#runtr_chk != 1 ) then
  @ ier++
else
  if ( ! -f $runtr_chk ) then
    @ ier++
  endif
endif

if ( $ier > 0 ) then
  echo " "
  if ( -f ~/.login ) then
     echo " runtr: not found -- so, source ~/.login "
     source ~/.login
  else
     echo " runtr: not found -- exit "
     exit 1
  endif
endif

echo " "
echo " which runtr: "
which runtr
echo " "

set runtr_chk = `which runtr`
if ( $#runtr_chk != 1 ) then
  echo " runtr: still not found after source ~/.login -- must stop "
  exit 1
endif

# ------------------------------------------------------------
# Log interesting information
#

echo "-------------------"
echo "This is a $PBS_ENVIRONMENT job"
echo "This job was submitted to the queue: $PBS_QUEUE"
echo "The job's id is: $PBS_JOBID"
echo "-------------------"
echo "The master node of this job is: $PBS_O_HOST"

# --- the nodes allocated to this job are listed in the
#     file PBS_NODEFILE

# --- count the number of processors allocated to this run 
# --- $NPROCS is required by mpirun.
set NPROCS=`wc -l < $PBS_NODEFILE`

set NNODES=`uniq $PBS_NODEFILE | wc -l`

echo "This job is using $NPROCS CPU(s) on the following $NNODES node(s):"
echo "-----------------------"
uniq $PBS_NODEFILE | sort
echo "-----------------------"

# ------------------------------------------------------------
# Setup execution variables
#
# Setup working directory & data source directory
#
# --- PBS_O_WORKDIR is the working directory from
#     which this job was submitted using 'qsub'
#
echo "The job origination directory is $PBS_O_WORKDIR"

set tok = `tok_extract $PBS_O_WORKDIR`

if ( "$tok" == "none" ) then

  echo " ?pppl_serial.tcsh:  could not infer TOKAMAK from path:"
  echo "  $PBS_O_WORKDIR from which job was submitted."
  echo "  Execution must stop."
  exit 1

endif

set username = `whoami`

#if (! $?NO_MOVE) then
if (! $?SHENMA_HOST) then
   if ( ! -d /local/$username ) then
     mkdir /local/$username
   endif

   if ( ! -d /local/$username/work ) then
     mkdir /local/$username/work
   endif

   setenv WORKDIR /local/$username/work

   if ( ! -d $WORKDIR/$tok ) then
     mkdir -p $WORKDIR/$tok
   endif

# work here...

   cd $WORKDIR/$tok

# get data from...

   set mroot = `echo $PBS_O_HOST | sed 's#\..*##'`
   echo " mroot: $mroot"

   set orig_dir = `echo $PBS_O_WORKDIR | sed "s#/local/#/l/$mroot/#"`
else
   set orig_dir = $PBS_O_WORKDIR
   cd  $orig_dir
endif   # End NO_MOVE

echo " %pppl_serial.tcsh: looking for input data here: $orig_dir "

# ------------------------------------------------------------
# Run the program
#
# --- print out the current time, then use the 'time' command
#     to start the program and print useful stats
#
echo -n 'Started job at : ' ; date
echo " ====================================== "
echo " "

echo " hostname:"
hostname

echo " pwd:"
pwd

echo " "

#  if TRANSP environment has not been set up, $CONFIGDIR will be undefined.

#set tokid = $cwd:t
cd ..
set tokid = $cwd:t
cd -
echo " tokid: $tokid"
fgrep $tok $CONFIGDIR/TOKAMAK.DAT
if ( $status != 0 ) then
  echo " ?pppl_serial.tcsh -- $tok not found in $CONFIGDIR/TOKAMAK.DAT "
  exit 1 
endif

echo " "
echo " jobname: $PBS_JOBNAME"

#  jobname = q<runid>; strip off leading q
#    jobnames must start with alphabetic character

set runid = `echo $PBS_JOBNAME | sed 's#^q##'`
echo " runid: $runid"

echo " ------------------------------------------------- "
echo " directory of origin files at start: "
ls $orig_dir

if ( ! -f $orig_dir/${runid}TR.DAT ) then
  echo " ?pppl_serial.tcsh -- ${runid}TR.DAT not found in $orig_dir ..."
  exit 1
endif

if (! $?NO_MOVE) then
   cp -r $orig_dir/${runid}* .
endif

echo " ------------------------------------------------- "
echo " local files before start of TRANSP:"
ls

if ( $?RUNTR_ARG != 1 ) then
  echo " "
  echo " RUNTR_ARG environment variable not found; default applied:  all "
  set runtr_arg = all
else
  set runtr_arg = $RUNTR_ARG
endif
if($runtr_arg == "all") then
# if transp argument = "all" clean up *birth* files
 rm -f *birth*
endif


# set log file log_level
if ( $?LOG_LEVEL != 1 ) then
  echo " "
  echo " LOG_LEVEL environment variable not found; default applied:  1 (warn)"
  set logfile_level = 1
else
  set logfile_level = $LOG_LEVEL
endif
echo " LOG_LEVEL environment variable = $logfile_level"


echo " ------------------------------------------------- "
echo " runtr $runid $runtr_arg wait "
echo "       logfile: ${runid}tr.log "

runtr $runid $runtr_arg wait -log $logfile_level

set rstat = $status

echo " runtr exit status (0 = normal): $rstat "
echo " ------------------------------------------------- "

if ( $rstat != 0 ) then
  echo " ------------------------------------------------- "
  if ( -f ${runid}.time_stop ) then
     set timeout=TRUE
     echo " *** Time Out *** "
  else
     echo " *** error exit *** "
  endif

  if (! $?NO_MOVE) then

     echo " copy back local files after TRANSP exit:"
     ls
     cp -r ${runid}* $orig_dir
     echo " ------------------------------------------------- "
     echo " directory of origin files at end: "
     ls $orig_dir
  endif
else if  (! $?NO_MOVE) then
     echo " clean up $runid files on master node directory of origin..."
     rm -r $orig_dir/${runid}*
     mv $RESULTDIR/*.DAT $orig_dir/
endif

if  (! $?NO_MOVE) then
   echo " clean up local disk files "
   rm -r ${runid}*
endif
 
echo " "
echo " ====================================== "
if ( $?timeout ) then
  cd $orig_dir
  mv ${runid}.time_stop ${runid}.time_old
  rm ${runid}.timeleft
  echo -n 'Restart job at  : ' ; date
# PPPL peculiarity: mque = default is not enabled
  if ( "$PBS_QUEUE" == "mque" ) then
    echo "trqsub $runid rs " 
    trqsub $runid rs 
    set rstat = $status
  else
    echo "trqsub $runid rs -q $PBS_QUEUE" 
    trqsub $runid rs -q $PBS_QUEUE
    set rstat = $status
  endif
else
  echo -n 'Ended job at  : ' ; date
endif
cp q${runid}TR.DAT ${runid}TR.DAT
rm -rf q${runid}TR.DAT
rm -rf *.tcsh
echo " " 
echo " TRANSP exit status: $rstat "
echo " " 
exit $rstat
