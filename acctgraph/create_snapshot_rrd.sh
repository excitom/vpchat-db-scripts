#!/bin/sh
# head -1 /u/vplaces/VPCOM/VPS/stat | sed 's/ /_/g;s/>=/ge/g;' >> create_stat_rrd.sh
# 20020206 00:00  T:1871  C:1346  B:525   R:1849  G:22    D:1871  J:0     E:1 
# LOGFILE=/u/vplaces/VPCOM/VPPLACES/snapshot.log.20020206

DBDIR=/u/vplaces/healthmon/stats
DB=snapshot.rrd

mkdir -p $DBDIR
cd $DBDIR

# [DS:ds-name:DST:heartbeat:min:max] \
# DS:timestamp:GAUGE:119:0:U \
# RRA:AVERAGE:0.5:1:1200
# [RRA:CF:xff:steps:rows]
/usr/local/bin/rrdtool create $DB \
--start "12/01/2001 12:00am" \
--step 60 \
DS:total:GAUGE:119:0:U \
DS:chat:GAUGE:119:0:U \
DS:buddy:GAUGE:119:0:U \
DS:registered:GAUGE:119:0:U \
DS:guest:GAUGE:119:0:U \
DS:download:GAUGE:119:0:U \
DS:java:GAUGE:119:0:U \
DS:ephemera:GAUGE:119:0:U \
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
RRA:AVERAGE:0.5:360:1460 \
RRA:MIN:0.5:360:1460 \
RRA:MAX:0.5:360:1460

# 1 data point = 60 seconds = 1 minute
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
# RRA:AVERAGE:0.5:360:1460
# RRA:MIN:0.5:360:1460
# RRA:MAX:0.5:360:1460
