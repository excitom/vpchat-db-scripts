#!/bin/sh
/usr/local/bin/rrdtool graph /tmp/statshot.png --start "now-1day" --end now \
--logarithmic \
'DEF:A=/u/vplaces/healthmon/stats/stat.rrd:total:AVERAGE' \
'DEF:B=/u/vplaces/healthmon/stats/stat.rrd:stream:AVERAGE' \
'DEF:C=/u/vplaces/healthmon/stats/stat.rrd:signon:AVERAGE' \
'DEF:D=/u/vplaces/healthmon/stats/stat.rrd:check_usr:AVERAGE' \
'DEF:E=/u/vplaces/healthmon/stats/stat.rrd:locate:AVERAGE' \
'DEF:F=/u/vplaces/healthmon/stats/stat.rrd:whisper:AVERAGE' \
'LINE2:A#ff0000:Total' \
'LINE1:B#00ff00:Stream' \
'LINE1:C#0000ff:Sign-On' \
'LINE1:D#ff00ff:Check-User' \
'LINE1:E#00ffff:Locate' \
'LINE1:F#ffcccc:Whisper'
#
/usr/local/bin/rrdtool graph /tmp/statshot.signon.png --start "end-1month" --end now \
'DEF:A=/u/vplaces/healthmon/stats/stat.rrd:signon:AVERAGE' \
'LINE1:A#0000ff:Sign-On'
