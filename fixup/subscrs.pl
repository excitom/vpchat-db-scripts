#!/usr/bin/perl
#
# add subscription records to the database for paypal customers
#
# Tom Lang 3/2002
$logDir = "/logs/accounts";
opendir(DIR, $logDir) || die "Can't open $logDir : $!";
@accounts = grep /[0-9]+/, readdir DIR;
closedir DIR;
$dbName = 'vpusr';
$dbPw = 'vpusr1';

$G_isql_exe = "/u/vplaces/s/sybase/bin/isql -U$dbName -P$dbPw -SSYBASE";
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

chdir $logDir;
foreach $file (@accounts) {
	open (ACCT, "<$file") || die "Can't read $file : $!";
	while (<ACCT>) {
		next unless (/created/);
		chomp;
		($date, $comment) = split(/\t/);
		@d = split(/\s+/, $date);
		$date = join(' ', $d[1], $d[2], $d[4], $d[3]);
		$comment =~ s/ created//;
		print "$file $date $comment\n";
		open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
		print SQL_IN "registerNewSubscription $file, 1, \"$comment\", \"$date\", 1\ngo\n";
		close SQL_IN;
		open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";
		while (<SQL_OUT>) {
			print;
		}
		close SQL_OUT;
	}
}
