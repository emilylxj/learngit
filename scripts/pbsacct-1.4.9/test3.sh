/bin/bash
awk '
{
total = split($0,processornames,"+")
print total
for (p=1;p<=total;p++)
{print p}
}
'

