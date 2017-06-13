#!/bin/sh
cpnums=`cat ./plist | awk '{print $1}'`
cpnames=`cat ./plist | awk '{print $2}' | sed 's#\..*##'`
echo $cpnums
echo $cpnames
