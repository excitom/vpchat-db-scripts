#!/usr/bin/perl
#
# Send periodic reminders, based on records extracted from the database.
#
# Tom Lang 10/2002
#
$dbName = 'vpusr';
$dbPw = 'vpusr1';
$G_isql_exe = "/u/vplaces/s/sybase/bin/isql -w 300 -U$dbName -P$dbPw -SSYBASE";
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";

print SQL_IN <<SQL;
EXEC getReminders
GO
SQL

close SQL_IN;

open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

$idx = 0;
while (<SQL_OUT>) {
	if (/^\s+Notify/) {
		chomp;
		my ($prefix, $aid, $target, $notifyEmail) = split;
		$accountIDs{$idx} = $aid;
		$targetName{$idx} = $target;
		$notify{$idx} = $notifyEmail;
	}
	if (/^\s+Comment/) {
		chomp;
		s/^\s+Comment\s+//;
		$comment{$idx} = $_;
		$idx++;
	}
}
close SQL_OUT;
unlink($tempsql);

@now = localtime(time);
$now[4]++;
$now[5] += 1900;
$suffix = sprintf(".%4.4d%2.2d%2.2d", $now[5], $now[4], $now[3]);
$logFile = "/logs/billing/reminder.log" . $suffix;
$now = scalar localtime;

foreach $i (keys %accountIDs) {
	open (MAIL, "| /usr/bin/mailx -s \"Reminder for account $accountIDs{$i}\" $notify{$i}") || die "Can't send mail : $!";
	print MAIL <<MSG;
Account ID  : $accountIDs{$i}
Account name: $targetName{$i}
Comment     :
$comment{$i}

MSG
	close MAIL;

	open (LOG, ">>$logFile") || die "Can't append to $logFile : $!";
	print LOG "$now\tNotified $notify{$i} about $accountIDs{$i}\n";
	close LOG;
}
