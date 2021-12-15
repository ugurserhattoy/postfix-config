#!/bin/bash
##############################################################################
######################################u#s#t###################################
# variables
fqdname=`hostname -f`
relayHost=smpt.domain.com

# backup main.cf
cp -vp /etc/postfix/main.cf /etc/postfix/main.cf.bkp
echo "main.cf | backed up"

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
##############################################################################
