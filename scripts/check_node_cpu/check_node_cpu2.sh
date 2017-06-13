#/bin/bash
QUEUE=$1
qstat -rn  $QUEUE  >runjob_${QUEUE}.log
sed -i '1,5d' runjob_${QUEUE}.log 
#awk '{if(NR%2==0){printf $0 "\n"}else{printf "%s：",$0}}' runjob_${QUEUE}.log >>runjob_${QUEUE}_host.log
awk '/service103/{T=$0;next;}{print T"\t"$0;}' runjob_${QUEUE}.log >>runjob_${QUEUE}_host.log

awk '{ print $2}' runjob_${QUEUE}_host.log|sort  -n  | uniq  >namelist


for i in  `cat namelist`

do 
echo
echo

echo "====== the jobs of  user $i is ====== "
echo 

echo '|Job ID | nodes | allcpu | per-cpu| walltime| hostname'

echo

cat runjob_${QUEUE}_host.log |grep $i >   ${i}_job.log
#qstat -r $QUEUE |grep  ${i}  | tee   ${i}_job.log

awk  '{print $1" "$6" "$7" "$7/$6" "$11" "$12}' ${i}_job.log 
#|tee ${i}_id_node_cpu_walltime.log 
sed -i s/.service103/\ /g  ${i}_id_node_cpu_walltime.log

#for j in `awk '{ print $1}' ${i}_id_node_cpu_walltime.log`
#do 

#qstat 
#hostname= `qstat -n $j |grep shenma `
#|cut -d + -f 1  >>shenma_${i}_${j}.log
#sed -i 's/${j}*/&,$hostname/' ${i}_id_node_cpu_walltime.log
#done
done

 





