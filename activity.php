#!/usr/bin/php
<?php
$fh = fopen('activityLog.sql', 'r');
$ofh = fopen('a.sql', 'w');
$ts = strtotime( '2010-01-01' );
while ($line = fgets($fh)) {
	$cols = explode("\t", $line);
	$time = strtotime($cols[1]);
	if (($time >= $ts) && ($time != 1337490000))
	{
		print $cols[1] . "\n";
		fwrite( $ofh, $line );
	}
}
