#!bash/bin
#the usage is ./result.sh <username>
echo "We will creat  the result directoy for the  new transp user "
echo "the user name is $1"
#cd /scratch/transp-new/result
pwd
if [ pwd == /scratch/transp/result ];then
pwd
else cd /scratch/transp/result
pwd
fi
username=$1
#user= 'whoami'; echo $user
#echo $username
#if [ "$user" == "root" ];then
if [ $(id -u) = "0" ];then
echo "Begin to setup the result directoy"
echo "Now set up the dir"
mkdir $username
chown $username:transp -R $username
chmod 750 -R $username
else
echo "you must have the root permision"
fi
#echo
#echo "Now set up the dir"

#mkdir $username
#chown $username:transp -R $username
#chmod 750 -R $username
