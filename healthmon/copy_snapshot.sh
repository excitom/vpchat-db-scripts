#!/bin/bash

# Copy the logfiles from the other VPservers
# The VP servers are: 
# megan for jp chat
# amy for adult chat.
# anne for (unqualified) chat


DATE=`date +%Y%m%d`
JP_DATE=`/bin/rsh megan "/u/vplaces/scripts/healthmon/printToday.pl"`

# assume one can rsh to megan and amy as user:vplaces with no passwd
rcp amy:/u/vplaces/VPCOM/VPPLACES/snapshot.log.$DATE   /u/vplaces/VPCOM/VPPLACES/adult-snapshot.log.$DATE
rcp megan:/u/vplaces/VPCOM/VPPLACES/snapshot.log.$JP_DATE /u/vplaces/VPCOM/VPPLACES/jp-snapshot.log.$JP_DATE
