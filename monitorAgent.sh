#!/bin/sh
#
# The ssh-agent should be running so that cron scripts can
# use scp and ssh without prompting for password.
#
# This script checks to make sure the agent is running. It can't
# be automatically restarted, since it requires typing in the 
# authentication key.
#
if [ ! -f /u/vplaces/.ssh/agent ]
then
	date
	h=`hostname`
	echo "No ssh agent file on $h"
	exit
fi
. /u/vplaces/.ssh/agent >/dev/null 2>&1
if [ "$SSH_AGENT_PID" = "" ]
then
	date
	h=`hostname`
	echo "SSH_AGENT_PID not set on $h"
	exit
fi
if [ ! -d /proc/$SSH_AGENT_PID ]
then
	date
	h=`hostname`
	echo "ssh agent not running on $h"
	exit
fi
