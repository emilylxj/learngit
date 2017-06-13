          if (SINGLE == 1) {
                                # For the SINGLE option we must charge for ALL processors in each node.
                                # DEBUG: print "exec_host = ", exec_host
                                for (p=1; p<=total_ncpus; p++) { 
                                        # Extract the nodename
                                        slash = index (processornames[p],"/")
                                        nodename = substr(processornames[p],1,slash-1)
                                        # DEBUG: printf("%s+", nodename)
                                        # Increment the # of processors on this node
                                        nodeproc[nodename] += 1
                                }
                                # DEBUG: for (n in nodeproc) printf("%s:%d(%d)+", n, nodeproc[n], nodetotalprocs[n])

