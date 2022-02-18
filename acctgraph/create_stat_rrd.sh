#!/bin/sh
# head -1 /u/vplaces/VPCOM/VPS/stat | sed 's/ /_/g;s/>=/ge/g;' >> create_stat_rrd.sh
LOGFILE=/u/vplaces/VPCOM/VPS/stat

DBDIR=/u/vplaces/healthmon/stats
DB=stat.rrd

mkdir -p $DBDIR
cd $DBDIR

# [DS:ds-name:DST:heartbeat:min:max] \
# DS:timestamp:GAUGE:119:0:U \
# RRA:AVERAGE:0.5:1:1200
# [RRA:CF:xff:steps:rows]
/usr/local/bin/rrdtool create $DB \
--start "01/01/2002 12:00am" \
--step 60 \
DS:total:GAUGE:119:0:U \
DS:stream:GAUGE:119:0:U \
DS:signon:GAUGE:119:0:U \
DS:check_usr:GAUGE:119:0:U \
DS:locate:GAUGE:119:0:U \
DS:whisper:GAUGE:119:0:U \
DS:query_place:GAUGE:119:0:U \
DS:page_query_place:GAUGE:119:0:U \
DS:send_to_svc:GAUGE:119:0:U \
DS:send_from_svc:GAUGE:119:0:U \
DS:move:GAUGE:119:0:U \
DS:create_group:GAUGE:119:0:U \
DS:navigate:GAUGE:119:0:U \
DS:navigate_group:GAUGE:119:0:U \
DS:start_talking:GAUGE:119:0:U \
DS:stop_talking:GAUGE:119:0:U \
DS:send:GAUGE:119:0:U \
DS:change_avatar:GAUGE:119:0:U \
DS:retrieve_avatar:GAUGE:119:0:U \
DS:query_member:GAUGE:119:0:U \
DS:process_time:GAUGE:119:0:U \
DS:longest:GAUGE:119:0:U \
DS:ge500ms:GAUGE:119:0:U \
DS:ge100ms:GAUGE:119:0:U \
DS:ge10ms:GAUGE:119:0:U \
RRA:AVERAGE:0.5:1:60 \
RRA:AVERAGE:0.5:1:180 \
RRA:AVERAGE:0.5:12:120 \
RRA:MIN:0.5:12:120 \
RRA:MAX:0.5:12:120 \
RRA:AVERAGE:0.5:12:840 \
RRA:MIN:0.5:12:840 \
RRA:MAX:0.5:12:840 \
RRA:AVERAGE:0.5:24:1680 \
RRA:MIN:0.5:24:1680 \
RRA:MAX:0.5:24:1680 \
RRA:MIN:0.5:360:1460 \
RRA:MAX:0.5:360:1460 \
RRA:AVERAGE:0.5:360:1460

# # 1h (60 buckets averaged over 1 data point)
# RRA:AVERAGE:0.5:1:60
# # 3h (180 buckets averaged over 1 data point)
# RRA:AVERAGE:0.5:1:180
# # 24h (120 buckets averaged over 12 data points)
# RRA:AVERAGE:0.5:12:120
# RRA:MIN:0.5:12:120
# RRA:MAX:0.5:12:120
# # 7d (840 buckets averaged over 12 data points)
# RRA:AVERAGE:0.5:12:840
# RRA:MIN:0.5:12:840
# RRA:MAX:0.5:12:840
# # 28d (1680 buckets averaged over 24 data points)
# RRA:AVERAGE:0.5:24:1680
# RRA:MIN:0.5:24:1680
# RRA:MAX:0.5:24:1680
# # 365d (1460 buckets averaged over 360 data points)
# RRA:MIN:0.5:360:1460
# RRA:MAX:0.5:360:1460
# RRA:AVERAGE:0.5:360:1460
