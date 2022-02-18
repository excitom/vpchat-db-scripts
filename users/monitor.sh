#!/bin/sh
cd /u/vplaces/scripts/users
if [ ! -d /proc/`cat updateSignOnDate.pid` ]
then
	echo "updateSignOnDate restarted"
	date
	./updateSignOnDate.pl
fi
