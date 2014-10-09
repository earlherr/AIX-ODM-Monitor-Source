#!/bin/ksh
# Earl Herr 4/2000
#
# Converted from custom Tivoli TEC interface script
# Earl Herr 11/01/2005
#
# This script sets up the ODM and Syslog
#

export PATH=$PATH:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/Tivoli

odmdelete -q"en_name='syslog1'" -o errnotify
odmdelete -q"en_name='syslog2'" -o errnotify
odmdelete -q"en_name='syslog3'" -o errnotify

odmadd /usr/local/bin/syslog1.add
odmadd /usr/local/bin/syslog2.add
odmadd /usr/local/bin/syslog3.add

cp -p /etc/syslog.conf /etc/syslog.orig

grep /tmp/patrol.out /etc/syslog.conf | grep -v \# > /dev/null

if [[ $? -ne 0 ]] ; then

echo "daemon.crit     /tmp/patrol.out     rotate size 1000k files 10" >> /etc/syslog.conf

	else

sed -e 's/\*.emerg;\*.alert;\*.crit;\*.err;\*.warning;\*.notice;\*.info/daemon.crit/g' /etc/syslog.orig > /etc/syslog.conf
fi

refresh -s syslogd
