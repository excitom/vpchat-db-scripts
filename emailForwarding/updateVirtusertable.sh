#!/bin/sh
#
# This is meant to run from the root crontab
#
if [ -f /tmp/updateVirtusertable ]
then
  cd /etc/mail
  /usr/sbin/makemap hash virtusertable <virtusertable
  rm -f /tmp/updateVirtusertable
fi
