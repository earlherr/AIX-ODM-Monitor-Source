#!/bin/ksh
# Earl Herr 4/2000
#
# Converted from custom Tivoli TEC interface script
# Earl Herr 11/01/2005
#
# Changed FROM: echo "ERRPT" and echo "ERRPT"
# TO: echo "PERM `cat /tmp/PERM.out`" and echo "TEMP `cat /tmp/TEMP.out`"
# Earl Herr 11/18/05
#
# Messages from ERRPT are being feed to the syslogd 
# using daemon.crit /tmp/patrol.out
# daemon.crit     /tmp/patrol.out     rotate size 1000k files 10
# Earl Herr 11/18/05
#
#
export PATH=/usr/bin:/usr/sbin:/usr/local/bin:$PATH
min=`date +%M`
hour=`date +%H`
day=`date +%d`
month=`date +%m`
year=`date +%y`

echo "{print \"patrol - \"\$6\" \"\$7\" \"\$8\" \"\$9\" \"\"with\"\" \"\$5}" > /tmp/awkfile

errpt -T PERM -dH -s $month$day$hour$min$year | grep -v TIMESTAMP | awk -f /tmp/awkfile > /tmp/PERM.out 2>&1

if [[ -s /tmp/PERM.out ]]
	then
echo "PERM `cat /tmp/PERM.out`"
fi

errpt -T TEMP -dH -s $month$day$hour$min$year | grep -v TIMESTAMP | awk -f /tmp/awkfile > /tmp/TEMP.out 2>&1

if [[ -s /tmp/TEMP.out ]]
	then
echo "TEMP `cat /tmp/TEMP.out`"
fi
