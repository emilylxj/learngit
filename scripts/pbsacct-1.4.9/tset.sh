#!/bin/awk -f

BEGIN{FS=","}

{

split($1,name,"+");


for (i in name)

print name[i]

slash = index (name[i],"/")
nodename =substr(name[i],1,slash-1)
echo $nodename
}

