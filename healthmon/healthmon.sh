#!/bin/bash

BASEDIR=/u/vplaces/scripts/healthmon
# $BASEDIR/generate_signon.sh &
$BASEDIR/copy_snapshot.sh
$BASEDIR/generate_snapshots.sh ;
$BASEDIR/amy-generate_snapshots.sh
$BASEDIR/megan-generate_snapshots.sh

$BASEDIR/update_index_page.sh ;
# __END__

# Added by hdr
# for now These graphs only show up in /web/cmgmt/html/health/mymon.html

