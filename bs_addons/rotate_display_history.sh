#!/bin/sh

XARGS=/usr/local/bin/xargs
RM=/bin/rm
GZIP=/usr/bin/gzip
FIND=/usr/bin/find
BSADM=/u/vplaces/big_sister/bin/bsadmin

HOSTS=localhost

TODAY=`/bin/date +%Y%m%d`
BASEDIR=/u/vplaces/big_sister

for host in $HOSTS
 do
	$BSADM -d $host -b $BASEDIR savelogs $TODAY
	cd $BASEDIR/var
	$GZIP -9 display.history.$TODAY 
	$FINE $BASEDIR/var -name "display.history.*.gz" -mtime +60 -print | $XARGS -r $RM
 done
# __END__
