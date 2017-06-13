#!bash/bin
echo "We will add the new user to the cluster"
echo "the user name is $1"
username=$1
#user='whoami'
#if [ $user == root ];then
if [ $(id -u) = "0" ];then
echo "Begin to setup the newuser"
else
echo "you must have the root permision"
fi
echo
echo "Now set up the dir"
mkdir /home/$username
mkdir /scratch/$username

echo "now cp the bashfile"
cp /etc/skel/.bashrc /home/$username
cp /etc/skel/.bash_profile /home/$username

echo "chang the owner"
chown $username:$2 -R /home/$username
chown $username:users -R /scratch/$username
echo "chang the Passwd"
passwd $username

echo "login the cluster"

#ssh $username@shenma.ipp.ac.cn

