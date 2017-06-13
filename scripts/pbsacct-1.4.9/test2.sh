
#/bin/bash
cat - | awk -F';' -vSINGLE=$SINGLE -vNODEFILE=$NODEFILE '
BEGIN {
#total_ncpus = 0
total_ncpus = split($1,processornames,"+")
}
'
echo $total_ncpus




