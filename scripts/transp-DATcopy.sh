vim /project/transp/public/transp/codesys/csh/finishup

if ( $file == "${runid}TR.DAT" ) then
#       set action = move
        set action = copy
        cp ${runid}TR.DAT q${runid}TR.DAT


vim /project/transp/public/transp/codesys/pbs/pppl_serial.tcsh 
vim /project/transp/public/transp/codesys/pbs/pppl_trmpi_NxM.tcsh
  rm -r $orig_dir/${runid}*
mv $RESULTDIR/*.DAT $orig_dir/

cp q${runid}TR.DAT ${runid}TR.DAT
rm -rf q${runid}TR.DAT
rm -rf *.tcsh
echo " "
echo " TRANSP exit status: $rstat "
echo " "
exit $rstat

The important is 
(1)copy the ${runid}TR.DAT to  q${runid}TR.DAT in the directory $RESULTDIR
(2)rm the date and file in $rig_dir:rm -r $orig_dir/${runid}*
(3)mv $RESULTDIR/*.DAT $orig_dir/
(4)cp q${runid}TR.DAT ${runid}TR.DAT
(5)rm -rf q${runid}TR.DAT

According the up step,the q${runid}TR.DAT is deleted in $orig_dir and remaining the ${runid}TR.DAT in $orig_dir.

It is completly.

wordir xiugai:

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
endif




#  if TRANSP environment has not been set up, $CONFIGDIR will be undefined.
cd ..
set tokid = $cwd:t
cd -
echo " tokid: $tokid"

