#!/bin/bash
#sudo ./script.sh users

len=`wc -l < $1`

for (( i=1;i<=$len;i++ ))
do
   name=`awk NR==$i $1`
   dir=$"/home/${name}"
   pass=`openssl passwd $name`
   mkdir $name
   gid=$((8000+$i))
   echo $"${name}:${pass}:${gid}:101:,,,:${dir}:/bin/bash" >> /etc/passwd

done

apt update
apt install openssh-server
systemctl sshd restart

