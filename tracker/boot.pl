#!/usr/local/bin/perl
#
# Function: destroy abusers of our beloved PAL program
#
# Tom Lang 10/1999

##################
#
# send notification email
#
sub notify {
	my $to = $_[0];
	die "Yikes, bogus email" if ($to eq "");
	open (MAIL, "| /usr/lib/sendmail $to") || die "Can't send mail : $!";
	print MAIL <<MM;
From: Excite PAL <pal\@excite.com>
Reply-To: pal\@excite.com
Subject: PAL Abuse

Your PAL account, $to,
was deactivated since you used an unacceptable "hacked" PAL program.

If you have questions or comments, you can contact us at:

        http://www.excite.com/feedback/chat/
MM
	close MAIL;
}

##################
#
# Get list of words to use in passwords
#
sub initPasswds {
	my $dictFile = "/usr/share/lib/dict/words";
	my @words;
	open (DICT, "<$dictFile") || die "Can't open $dictFile : $!";
	while (<DICT>) {
		next unless (/^[a-z]+$/);        # skip contractions, numbers
		next unless (length($_) == 5 || length($_) == 6);
		chop;
		push(@words, $_);
	}
	return @words;
}

##################
#
# Change passwords in the database
#
sub changePasswds {
	my @list = @_;
	my ($email, $password, $x, $y);
	my @words = &initPasswds;
	my %passwds;

	$G_isql_exe = '/u/vplaces/s/sybase/bin/isql -Uvpusr -Pvpusr1 -SSYBASE';
	$tempsql = $G_logDir . ".temp.sql.$$";
	$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

	srand(time ^ $$ ^ unpack "%32L*", `ps -aef | /usr/local/bin/gzip`);
	foreach $email (@list) {
		chomp;
		open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
		$x = rand $#words;
		$y = int((rand 99) * 100) % 100;
		$y = "0$y" if ($y < 10);
		$password = $words[$x] . $y;

		$passwds{$email} = $password;	# save for booting later

		print qq|$email	$password\n|;

		die "Yikes, bogus email" if ($email eq "");
		die "Yikes, bogus password" if ($password eq "");

		print SQL_IN qq|update registration set password = "$password" where email = "$email"\n|;
		print SQL_IN qq|select "===",nickName from registration,users where email = "$email" and users.userID=registration.userID\n|;
		print SQL_IN "go\n";
		close SQL_IN;
		open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

		$nickname = "";
		while (<SQL_OUT>) {
			($junk, $nickname) = split if (/===/);
		}
		close SQL_OUT;
		#
		# now apply a penalty so they can't retieve 
		# their password with the PAL Lost Password page
		#
		open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
		print SQL_IN qq|vpusers..getRegisteredUserInfo "$nickname"\ngo\n|;
		print SQL_IN qq|vpusers..penalize "$nickname",2,"Kick",6000,"vpmanager",2,"Caught launching message flood attack."\ngo\n|;
		close SQL_IN;
		open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

		$nickname = "";
		$notify = 1;
		while (<SQL_OUT>) {
			print if (/return status/);
			$notify = 0 if (/Kick/);	# don't send mail again
							# if already kicked
		}
		close SQL_OUT;

		#
		# send notification email
		#
		if ($notify) {
			print "Email sent\n";
			&notify($email);
		}
	}
	
	unlink($tempsql);

	#
	# now boot them
	#
	my $log = "$G_logDir/timestamps";
	open (L, ">>$log") || die "Can't append to $log : $!";
	foreach $email (keys %passwds) {
		my $rc = `/u/vplaces/scripts/pal/robot.exe nag $email $passwds{$email}`;
		my (@result) = split(/\s+/, $rc);
		print L "$result[0] $result[1] Host: $host Ejected: $result[6]\n";
	}
	close L;
}

##################
#
# Get list of names to process
#
sub getVictims {
	my @n;
	my $i;
	return @n if ($#ARGV == -1);
	for ($i = 0; $i <= $#ARGV; $i++) {
		$_ = $ARGV[$i];
		tr/[A-Z]/[a-z]/;
		s/[\x7f-\xff]//g;
		s/\s+//g;
		push(@n, $_);
	}
	return @n;
}

##################
#
# START HERE
#

$G_logDir = "/logs/pal/";

if ($#ARGV > -1 && $ARGV[0] eq '-h') {
	shift @ARGV;
	$host = shift @ARGV;
	print "Host: $host\n";
}

@toDo = &getVictims;

#
# if any un-processed names found, zap them now
#
if ($#toDo >= 0) {
	&changePasswds(@toDo);
} else {
	print "*** no names to process\n";
}
