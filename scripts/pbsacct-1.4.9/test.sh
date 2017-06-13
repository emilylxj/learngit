#/bin/bash
cat - | awk -F';' -vSINGLE=$SINGLE -vNODEFILE=$NODEFILE '
BEGIN {
#total_ncpus = 0
 total_ncpus = split(shenma001/0-1+shenma02/5-9,processornames,"+")                                      
print total_ncpus
#print("%d",total_ncpus)
 for (p=1; p<=total_ncpus; p++) {                                      
slash = index (processornames[p],"/")
                                        nodename = substr(processornames[p],1,slash-1)
                                        nodename_proc = substr(processornames[p],slash+1)
                                  #       for (npc=1;npc<=nodename_proc;npc++){
  #                                        result = $(echo $nodename_proc | grep "-")
 #                                          if [[ "$result" = "" ]]
                                        # DEBUG:
 printf("%s+", $nodename)
   
                                     # Increment the # of processors on this node
                                       if (match(nodename_proc,"-")) 
                                           { slash_proc = index(nodename_proc,"-")
                                            nodename_proc_begin = substr(nodename_proc,1,slash-1)
                                            nodename_proc_end = substr(nodename_proc,slash+1)
                                            nodename_proc_num = $nodename_proc_end-$nodename_proc_begin
                                            nodeproc[nodename] += $nodename_proc_num
                                       }
                                           else
                                              nodeproc[nodename] += 1
                                           fi
}
}
'
