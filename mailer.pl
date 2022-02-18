#!/usr/bin/perl
#
# tom lang 6/94
#

## look for command line switches
## -l <list of names>
## -m <memo file>
## -f <from line>

require "getopts.pl";   # make sure library routine is available
&Getopts('l:m:');
die "Need to specify -m <memo file>\n"          if ($opt_m eq "");
die "Need to specify -l <list of names>\n"      if ($opt_l eq "");
#die "Need to specify -f <From line>\n"          if ($opt_f eq "");

$from = "From: VP Chat<billing\@halsoft.com>\n";
#die "Invalid From: line - $from\n" unless ($from =~ /^From: .*<.+@.+\.com>/);
#$from .= "\n" unless ($from =~ /\n$/);

open(MEMO, "<$opt_m") || die "Can't open memo file $opt_m\n";
@memo = <MEMO>;
close MEMO;
open(USERS, "<$opt_l") || die "Can't open name list file $opt_l\n";
while(<USERS>) {
	next if (substr($_,0,1) eq "#");
	chop;
	#$to = $_;
	(@fields) = split(/\t/);
	$to = $fields[2];
	next if (defined($seen{$to}));
	$seen{$to} = 1;
	#$_ = `/usr/lib/sendmail -bv $to 2>&1`;
	#next unless(/deliverable/);
	print "$to\n";
	open(TMP, "| /usr/lib/sendmail -oi -oem -odq  -f support\@halsoft.com $to") || die "Can't open pipe to sendmail: $! ";
	print TMP $from;
	print TMP "To: $to\n";
	foreach $_ (@memo) {
		print TMP;
	}
	close(TMP);
}
