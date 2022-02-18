#!/usr/bin/perl
#
# Copy the health monitor images from anne
#
require "/web/reg/configKeys.pl";

@files = (
  'tcb.1h.png',
  'tcb.1h.thumb.png',
  'tcb.24h.png',
  'tcb.24h.thumb.png',
  'tcb.3h.png',
  'tcb.3h.thumb.png'
);
@srvrs = split(/,/, $G_config{'regFEWS'});

$srcDir = $G_config{'cmgmtRoot'} . '/health/img';
$timeStamp = $srcDir . '/timeStamp';

$copy = 0;
if (! -f $timeStamp) {
  $copy = 1;
} else {
  @stat1 = stat("$srcDir/$files[0]");
  @stat2 = stat("$timeStamp");
  if ($stat1[9] > $stat2[9]) {
    $copy = 1;
  }
} 
if ($copy) {
  $destDir = $G_config{'regRoot'} . '/img/health';
  foreach $file (@files) {
    foreach $srvr (@srvrs) {
      if ($G_config{'thisHost'} eq $srvr) {
	`cp $srcDir/$file $destDir/$file.tmp; mv $destDir/$file.tmp $destDir/$file`;
      } else {
	`/bin/rcp $srcDir/$file $srvr:$destDir/$file.tmp;/bin/rsh $srvr "mv $destDir/$file.tmp $destDir/$file"`;
      }
    }
  }
  `touch $timeStamp`;
}
