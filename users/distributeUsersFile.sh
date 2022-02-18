#!/bin/sh
h=`hostname`
if [ "$h" = "anne" ]
then
  cp /u/vplaces/VPCOM/VPPLACES/users.txt /export/u03/content/php/users.txt.tmp
  mv /export/u03/content/php/users.txt.tmp /export/u03/content/php/users.txt
else
  cp /u/vplaces/VPCOM/VPPLACES/users.txt /web/content/php/users_adult.txt.tmp
  mv /web/content/php/users_adult.txt.tmp /web/content/php/users_adult.txt
fi
