#!/bin/perl -w
use strict;

# use GD::Graph::bars;
use GD::Graph::linespoints;
use GD::Graph::Data;

use Date::Calc qw(:all);

my $fn = '/export/home/logs/account_usage.log';

# my $LIM = 20000;
my $LIM = 0;
my $ctr = 0;
my %new_acct = ();
my %passwd = ();
my $ok = open IFH, $fn;
if ($ok) {
	while (chomp(my $card = <IFH>)) {
		next unless ($card =~ /\S/o);
		my @pcs = split("\t", $card);
		if ($pcs[0]) {
			my $yyyymmdd = sprintf("%04d%02d%02d", (Parse_Date($pcs[0])));
			# [0] - date
			# [1] - IP
			# [2] - user
			# [3] - "asked for password"
		# asked for password
			if ($yyyymmdd) {
				logblock:
				{
					$new_acct{$yyyymmdd} = 0 unless (exists($new_acct{$yyyymmdd}));
					if ($pcs[1] eq 'new acct') {
						$new_acct{$yyyymmdd}++;
						last logblock;
					}

					$passwd{$yyyymmdd} = 0 unless (exists($passwd{$yyyymmdd}));
					if (($pcs[3]) && ($pcs[3] =~ /^asked for password/o)) {
						$passwd{$yyyymmdd}++;
						last logblock;
					}

				}
#		print join("->", @dt), "\n";
#		print $pcs[1], "\n";
			} else {
				print "Funky line: $card\n";
			}
			last if (($ctr++ > $LIM) && ($LIM > 0));
		}
	}
	close IFH;
} else {
	die "Can't open $fn for reading - $!\n";
}

my $chart = GD::Graph::linespoints->new();
$chart->set(
x_label           => 'Date',
y_label           => 'Accounts',
title             => 'New Accounts',
x_label_skip      => 7,
x_labels_vertical  => 1,
# shadow_depth      => 3,
);

my $dacct = GD::Graph::Data->new();
 
if (1) {
#	print "\n# new accounts\n";
	foreach my $dt (sort keys %new_acct) {
#		print $dt, " : ", $new_acct{$dt}, "\n";
		$dacct->add_point($dt, $new_acct{$dt});
	}
}

my $gd = $chart->plot($dacct);
open OFH, ">/tmp/test_acct.png" || die "Can't write test file - $!\n";
print OFH $gd->png();
close OFH;

$chart = GD::Graph::linespoints->new();
$chart->set(
x_label           => 'Date',
y_label           => 'Reqs',
title             => 'Password requests',
x_label_skip      => 7,
x_labels_vertical  => 1,
# shadow_depth      => 3,
);

my $dpw = GD::Graph::Data->new();
if (1) {
#	print "\n# password\n";
	foreach my $dt (sort keys %passwd) {
#		print $dt, " : ", $passwd{$dt}, "\n";
		$dpw->add_point($dt, $passwd{$dt});
	}
}

$gd = $chart->plot($dpw);
open OFH, ">/tmp/test_pw.png" || die "Can't write test file - $!\n";
print OFH $gd->png();
close OFH;

__END__

