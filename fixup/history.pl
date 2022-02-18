#!/usr/bin/perl
$logDir = "/logs/accountIDs";
opendir(DIR, $logDir) || die "Can't open $logDir : $!";
@accounts = grep /[0-9]+/, readdir DIR;
closedir DIR;
$dbName = 'vpusr';
$dbPw = 'vpusr1';

$G_isql_exe = "/u/vplaces/s/sybase/bin/isql -U$dbName -P$dbPw -SSYBASE";
$G_statdir = "/tmp/";
$tempsql = "/tmp/tmp.sql";
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

%as = (
	'OK' => 0,
	'New' => 1,
	'Pending' => 2,
	'Closed' => 3,
	'Suspended' => 4,
	'Overdue' => 5
);
chdir $logDir;
open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
foreach $file (@accounts) {
	open (ACCT, "<$file") || die "Can't read $file : $!";
	while (<ACCT>) {
		chomp;
		($date, $comment) = split(/\t/);
		@d = split(/\s+/, $date);
		$date = join(' ', $d[1], $d[2], $d[4], $d[3]);
		next unless (/accountStatus from /);
		/ to (\w+) by/;
		print "$file $date ";
print "TO $1 ";
		$reason = $as{$1};
		/ from (\w+) to/;
print "FROM $1 ";
		$r2 = $as{$1};
print "$r2 -> $reason\n";
		print SQL_IN "addAcctHistory $file, $reason, $r2, NULL, \"$date\"\ngo\n";
	}
}
close SQL_IN;
#open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";
#while (<SQL_OUT>) {
	#print;
#}
#close SQL_OUT;
