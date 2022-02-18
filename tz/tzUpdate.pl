#!/usr/bin/perl
#
# There ought to be a better way ...
# The database has a 'diffFromGMT' attribute, which is set manually. It
# does not automatically as daylight savings time comes and goes.
#
# This script wakes up once a day to see if the time zone offset differs
# from the database, and corrects if necessary.
#
# Tom Lang 10/2002
#

%tz = (
  0 => -6,	# 6 hrs ahead of GMT when CST
  1 => -5	# 5 hrs ahead of GMT when CDT
);
$saveFile = '/u/vplaces/scripts/tz/currDbTz';

$currDbTz = $tz{1};
if (open (F, "<$saveFile")) {
	$currDbTz = <F>;
	close F;
	chomp $currDbTz;
	$currDbTz += 0;
}
@d = localtime(time);
$isDST = $d[8];

if ($tz{$isDST} != $currDbTz) {

	$direction = ($tz{$isDST} == -6) ? 1 : -1;
	$host = `hostname`;
	chomp $host;
	open (MAIL, "| /usr/bin/mailx -s 'DB Timezone Changed' tlang\@halsoft.com");
	print MAIL <<MSG;
DB timezone changed from $currDbTz to $tz{$isDST}
Hostname: $host
MSG
	$dbName = 'sa';
	$dbPw = 'UBIQUE';
	$G_isql_exe = "/u/vplaces/s/sybase/bin/isql -U$dbName -P$dbPw -SSYBASE";
	$G_statdir = "/tmp/";
	$tempsql = $G_statdir . ".temp.sql.$$";
	$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

	open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
	print SQL_IN <<SQL;
USE vpusers
GO
UPDATE configurationKeys
SET intValue = $tz{$isDST}
WHERE keyName = 'diffFromGMT'
GO
USE audset
GO
UPDATE events SET date = dateadd(hour, $direction, date)
WHERE date >= getdate()
AND currentState = 0
GO
UPDATE notifyEvents SET time = dateadd(hour, $direction, time)
WHERE time >= getdate()
GO
UPDATE tournaments SET startTime = dateadd(hour, $direction, startTime)
WHERE startTime >= getdate()
GO
SQL
	close SQL_IN;

	open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

	while (<SQL_OUT>) {
		print MAIL;
	}
	close SQL_OUT;
	unlink($tempsql);

	open (F, ">$saveFile") || die "Can't write $saveFile : $!";
	print F "$tz{$isDST}\n";
	close F;
	close MAIL
}
