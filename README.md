# AIX-ODM-Monitor-Source
This is for IBM AIX UNIX Systems. 

Places files in /usr/local/bin or your script directory.

run ./odm.ksh

run from cron every 10 minutes or desired time to generate ODM reports.  ./errorchk.ksh

The script odm.ksh inserts these into the ODM ./syslog1.add PERM ./syslog2.add UNKN ./syslog3.add TEMP
