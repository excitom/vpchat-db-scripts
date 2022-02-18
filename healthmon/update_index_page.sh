#!/bin/sh

BASEINDEXHEAD=/u/vplaces/scripts/healthmon/health_index.head.html
BASEINDEXFOOT=/u/vplaces/scripts/healthmon/health_index.foot.html
TEMPTARGETPAGE=/u/vplaces/healthmon/temp_target.html
TARGETPAGE=/web/cmgmt/html/health/index.html

CP="/bin/cp";
CAT="/bin/cat";
TAIL="/bin/tail";
PERL="/bin/perl";
SED="/bin/sed";

CATCMD=`$PERL -e '
use Date::Calc qw(:all);
my $basedatadir = "/u/vplaces/VPCOM/VPPLACES";
my @today = Today();
my $today_stamp = sprintf("%04d%02d%02d", @today);
my $yest_stamp  = sprintf("%04d%02d%02d", Add_Delta_Days(@today, -1));
my $yfile       = $basedatadir . "/snapshot.log." . $yest_stamp;
my $tfile       = $basedatadir . "/snapshot.log." . $today_stamp;
print "$yfile $tfile";
'`

# echo $CATCMD;

$CP $BASEINDEXHEAD $TEMPTARGETPAGE ;
#$CAT $CATCMD | $TAIL -60 >> $TEMPTARGETPAGE ;
$CAT $BASEINDEXFOOT >> $TEMPTARGETPAGE ;

TIME=`/bin/date +"%A, %B %e, %Y, %T %Z"`;
$SED "s/#TIME#/$TIME/;" $TEMPTARGETPAGE > $TARGETPAGE ;

# SNAPSHOT=`$CAT $CATCMD | $TAIL -60`;
# echo "$SNAPSHOT";
# echo "$TIME";
# echo "Done.";

