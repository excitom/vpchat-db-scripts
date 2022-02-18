#!/usr/local/bin/perl
#
# Batch change host passwords
#
# Input: each line has host name and contact email, separated by tab
#
# Tom Lang 7/2000
#
sub getPasswd {
	my $x = rand $#words;
	my $y = int((rand 99) * 100) % 100;
	$y = "0$y" if ($y < 10);
	return "$words[$x]$y";
}

sub sendMail {
	my ($email, $password, $pal, $host, $hEmail) = @_;

	my $subject = ($pal) ? "Your host and PAL password changed" : "Your host password changed";
	my $msg = ($pal) ? "Your password for $host and $hEmail" : "Your password for $host";

	open (MAIL, "|/usr/lib/sendmail -oi -oem -F 'Excite Community Management' $email") || die "Can't send mail";
	print MAIL <<MAIL;
Subject: $subject
Reply-To: jforza\@excitecorp.com

$msg changed to $password

MAIL
	close MAIL;
}

srand(time ^ $$ ^ unpack "%32L*", `ps -aef | /usr/local/bin/gzip`);
$dictFile = "/usr/share/lib/dict/words";
open (DICT, "<$dictFile") || die "Can't open $dictFile : $!";
while (<DICT>) {
	next unless (/^[a-z]+$/);        # skip contractions, numbers
	next unless (length($_) == 5 || length($_) == 6);
	chop;
	push(@words, $_);
}
$G_isql_exe = '/t/t/s/sybase/bin/isql -Uvpusr -Pvpusr1 -SSYBASE';
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";
$date = `date "+%Y%m%d:%H:%M:%S"`;
chomp $date;
$logFile = "/logs/hostPasswordChange-$date.log";
open (LOG, ">$logFile") || die "Can't write to log file";

$ENV{'SYBASE'} ||= '/t/t/s/sybase';

while (<STDIN>) {
	chomp;
	tr/[A-Z]/[a-z]/;
	($host, $email) = split;
	if ($host !~ /^host-[-_.a-z0-9]+$/) {
		print "Unrecognized host name \"$host\" -- SKIPPING\n";
		print LOG "Unrecognized host name \"$host\" -- SKIPPING\n";
		next;
	}
	if ($email !~ /^[-_.a-z0-9]+@.*\..*$/) {
		print "Unrecognized email \"$email\" -- SKIPPING\n";
		print LOG "Unrecognized email \"$email\" -- SKIPPING\n";
		next;
	}
	
	$sql_cmd = qq|select userID from users where nickName = "$host" and registrationMode=2\ngo\n|;

	open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
	print SQL_IN $sql_cmd;
	close SQL_IN;

	open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

	$userID=0;
	while (<SQL_OUT>) {
		if (/-----/) {
			$userID = <SQL_OUT>;
			$userID += 0;
		}
	}
	close SQL_OUT;
	if ($userID == 0) {
		print "Host \"$host\" not found in database\n";
		print LOG "Host \"$host\" not found in database\n";
		next;
	}
	$sql_cmd = qq|select email from registration where userID = $userID\ngo\n|;

	open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
	print SQL_IN $sql_cmd;
	close SQL_IN;

	open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

	while(<SQL_OUT>) {
		if (/-----/) {
			$hEmail = <SQL_OUT>;
			$hEmail = <SQL_OUT> if ($hEmail =~/^\s*$/);
			close SQL_OUT;
			chomp $hEmail;
			$hEmail =~ s/\s+//g;
			$hEmail =~ tr/[A-Z]/[a-z]/;
			$h = $host;
			$h =~ s/^host-(.*)$/$1\@host/;
			print "Host: $host\n";
			print LOG "Host: $host\n";
			$pal = 0;
			if ($h eq $hEmail) {
				$pal = 1;
				print " Host PAL: $h\n";
				print LOG " Host PAL: $h\n";
			}
			$password = &getPasswd;
			$sql_cmd = qq|update registration set password = "$password" where  userID = $userID\ngo\n|;

			open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
			print SQL_IN $sql_cmd;
			close SQL_IN;

			open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

			$success = 0;
			while(<SQL_OUT>) {
				$success = 1 if(/1\s+row/);
			}
			if ($success) {
				&sendMail($email, $password, $pal, $host, $hEmail);
				print " Password changed to: $password\nEmail sent to: $email\n";
				print LOG " Password changed to: $password\nEmail sent to: $email\n";
			} else {
				print "Problem changing password for $host\n";
				print LOG "Problem changing password for $host\n";
			}
		}
	}
	print "---\n";
	print LOG "---\n";
	close SQL_OUT;
}
close LOG;
unlink "$tempsql";
