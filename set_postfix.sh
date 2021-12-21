#!/bin/bash
######################################u#s#t###################################
# variables----
fqdname=`hostname -f`
distro=`hostnamectl | grep -i system | cut -d ":" -f 2 | tr '[:upper:]' '[:lower:]'`
# replace example.domain.com with your local smtp server
relayHost=example.domain.com

ls /etc/postfix/main.cf
if [ $? -ne 1 ]
then
    if [ -z "${distro##*"debian"*}" ] || [ -z "${distro##*"ubuntu"*}" ]
    then
        apt-get install postfix
    elif [ -z "${distro##*"suse"*}" ] 
    then
        sudo zypper --non-interactive install postfix
    else
        sudo yum -y install postfix
    fi
fi
# backup main.cf
cp -vp /etc/postfix/main.cf /etc/postfix/main.cf.bkp
echo "main.cf | backed up as /etc/postfix/main.cf.bkp"

# set relayhost
sed -i "s/^relayhost = .*/relayhost = $relayHost/" /etc/postfix/main.cf
echo "main.cf | relayhost changed"

# set myhostname
sed -i "s/^myhostname = .*/myhostname = $fqdname/" /etc/postfix/main.cf
echo "main.cf | myhostname set as $fqdname"
echo "."
echo ".."
echo "...completed"
########################################u#s#t#################################
