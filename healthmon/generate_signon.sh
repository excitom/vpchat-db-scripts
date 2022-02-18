#!/bin/sh
HTMLDIR=/web/cmgmt/html/health
IMGDIR=/web/cmgmt/html/health/img
#
# BASENAME=/bin/basename
# MOGRIFY=/usr/local/bin/mogrify
RRDTOOL=/usr/local/bin/rrdtool

# Signons
$RRDTOOL graph $IMGDIR/signons.1h.png \
--start 'now-1hours' \
--end 'now' \
--vertical-label 'Users' \
--title 'Signons (1hr)' \
'DEF:C=/u/vplaces/healthmon/stats/stat.rrd:signon:AVERAGE' \
'LINE1:C#0000FF:Signons' 1>&2 >/dev/null

$RRDTOOL graph $IMGDIR/signons.3h.png \
--start 'now-3hours' \
--end 'now' \
--vertical-label 'Users' \
--title 'Signons (3hr)' \
'DEF:C=/u/vplaces/healthmon/stats/stat.rrd:signon:AVERAGE' \
'LINE1:C#0000FF:Signons' 1>&2 >/dev/null

$RRDTOOL graph $IMGDIR/signons.24h.png \
--start 'now-1day' \
--end 'now' \
--vertical-label 'Users' \
--title 'Signons (24hr)' \
'DEF:C=/u/vplaces/healthmon/stats/stat.rrd:signon:AVERAGE' \
'LINE1:C#0000FF:Signons' 1>&2 >/dev/null

$RRDTOOL graph $IMGDIR/signons.7d.png \
--start 'now-7days' \
--end 'now' \
--vertical-label 'Users' \
--title 'Signons (7d)' \
'DEF:C=/u/vplaces/healthmon/stats/stat.rrd:signon:AVERAGE' \
'LINE1:C#0000FF:Signons' 1>&2 >/dev/null

$RRDTOOL graph $IMGDIR/signons.28d.png \
--start 'now-28days' \
--end 'now' \
--vertical-label 'Users' \
--title 'Signons (28d)' \
'DEF:C=/u/vplaces/healthmon/stats/stat.rrd:signon:AVERAGE' \
'LINE1:C#0000FF:Signons' 1>&2 >/dev/null

$RRDTOOL graph $IMGDIR/signons.365d.png \
--start 'now-1year' \
--end 'now' \
--vertical-label 'Users' \
--title 'Signons (365d)' \
'DEF:C=/u/vplaces/healthmon/stats/stat.rrd:signon:AVERAGE' \
'LINE1:C#0000FF:Signons' 1>&2 >/dev/null

# __END__

