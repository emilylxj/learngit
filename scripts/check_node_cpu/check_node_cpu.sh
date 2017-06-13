#/bin/bash
QUEUE=$1
qstat -r  $QUEUE  |grep .service103  >runjob_${QUEUE}.log
#sed -i '1d' runjob_$QUEUE.log 
awk '{ print $2}' runjob_${QUEUE}.log | uniq >namelist

for i in  `cat namelist`

do 
echo " the jobs of  user $i is :  "
qstat -r $QUEUE |grep  ${i}  | tee   ${i}_job.log

awk  '{print $1 ,$6,$7,$7/$6,$11}' ${i}_job.log > ${i}_id_node_cpu_walltime.log 
sed -i s/.service103/\ /g  ${i}_id_node_cpu_walltime.log
for j in `awk '{ print $1}' ${i}_id_node_cpu_walltime.log`
do 

nodenum= `awk '{ print $3}' ${i}_id_node_cpu_walltime.log`

{
do
 {
 qstat -n $j |grep shenma |cut -d + -f $k  >>shenma_${i}_${j}.log
 k++
}
while (k<$nodenum)
}
done 
done

 





