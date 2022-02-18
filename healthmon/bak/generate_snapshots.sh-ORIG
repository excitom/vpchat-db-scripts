#!/bin/sh
HTMLDIR=/web/cmgmt/html/health
IMGDIR=/web/cmgmt/html/health/img
#
BASENAME=/bin/basename
MOGRIFY=/usr/local/bin/mogrify
RRDTOOL=/usr/local/bin/rrdtool
SNAPGRAPH=/u/vplaces/scripts/acctgraph/snapgraph.pl

# T C B
$SNAPGRAPH --minutes 1440 --output $IMGDIR/tcb.24h.png --thumbnail T C B &
$SNAPGRAPH --minutes 180 --output $IMGDIR/tcb.3h.png --thumbnail T C B &
$SNAPGRAPH --minutes 60 --output $IMGDIR/tcb.1h.png --thumbnail T C B ;

# subsequent graphs disabled to reduce overhead. they're not providing
# much incremental value ...
# R G
#$SNAPGRAPH --minutes 1440 --output $IMGDIR/rg.24h.png --thumbnail R G &
#$SNAPGRAPH --minutes 180 --output $IMGDIR/rg.3h.png --thumbnail R G &
#$SNAPGRAPH --minutes 60 --output $IMGDIR/rg.1h.png --thumbnail R G ;

# J D
#$SNAPGRAPH --minutes 1440 --output $IMGDIR/jd.24h.png --thumbnail J D &
#$SNAPGRAPH --minutes 180 --output $IMGDIR/jd.3h.png --thumbnail J D &
#$SNAPGRAPH --minutes 60 --output $IMGDIR/jd.1h.png --thumbnail J D ;

# T D
#$SNAPGRAPH --minutes 1440 --output $IMGDIR/td.24h.png --thumbnail T D &
#$SNAPGRAPH --minutes 180 --output $IMGDIR/td.3h.png --thumbnail T D &
#$SNAPGRAPH --minutes 60 --output $IMGDIR/td.1h.png --thumbnail T D ;

# # make thumbnails
# # Note that ImageMagick work but the resulting images 
# # are too light to be useful. Oh well.
# cd $IMGDIR
# for fn in *[0-9]h.png; do
#     nn=`basename $fn .png`
#     /bin/cp $fn "$nn.thumb.png"
# done
# $MOGRIFY -geometry 100 +contrast *.thumb.png

# __END__

