#/bin/bash
cat - | awk -F';' -vSINGLE=$SINGLE -vNODEFILE=$NODEFILE '
BEGIN {
 total_ncpus = split(exec_host,processornames,"+")                                      
printf("%d",total_ncpus)
}
'
