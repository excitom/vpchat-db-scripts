#!/usr/bin/perl -w
#
# show demographic information from the registration database
#
# Tom Lang 6/97
#
use Date::Manip;
use Getopt::Long;
use vars qw(
$OPT_date
$G_exportdir
);

(
$OPT_date,
$G_exportdir
) = (''x2);

###################
#
# Subroutine: process command line options
#
sub processOptions {
   my %optctl = ( 'date'=>\$OPT_date, );
   my @optlmt = ('date=s');

   GetOptions( \%optctl, @optlmt);

   if ($OPT_date ne '') {
      $OPT_date = ParseDate($OPT_date);
      if ($OPT_date !~ m!\d{10}:\d{2}:\d{2}!) {
         $OPT_date = ParseDate('today');
      }
   } else {
      $OPT_date = ParseDate('today');
   }
   return;
}

###################
#
# Subroutine: query the database for total registrations
#
sub getPeople {
	my $tempsql = $G_statdir . ".temp.sql.$$";

	$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

	my $sql_cmd =<<"SQLCMD";
use vpusers
go
select count(userID)
from userDetails
go
SQLCMD

	open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
   	print SQL_IN $sql_cmd;
	close(SQL_IN);

	open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

	while (<SQL_OUT>) {
		if (/^\s*\d+\s*$/) {
			chomp;
			s/^\s+//;
			$people = $_;
			last;
		}
	}

	close(SQL_OUT);
 	unlink $tempsql;
}

###################
#
# Subroutine: query the database for a variable, generate a count
#	of occurances.	
#
sub getCount {

	my $tempsql = $G_statdir . ".temp.sql.$$";

	my $sql_cmd =<<"SQLCMD";
use vpusers
go
select gender,age,count(age)
from userDetails
group by gender,age
go
SQLCMD

	open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
   	print SQL_IN $sql_cmd;
	close(SQL_IN);

	open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

	while (<SQL_OUT>) {
		last if (/-----/);
	}
	while (<SQL_OUT>) {
		last if (/^\s*$/);
		chomp;
		($gender,$age,$count) = split;
		$males{$age} = $count if ($gender == 1);
		$females{$age} = $count if ($gender == 0);
	}
	close(SQL_OUT);
 	unlink $tempsql;
}

####################
#
# START HERE
#
$G_isql_exe = '/u/vplaces/s/sybase/bin/isql -Usa -PUBIQUE -SSYBASE';
$G_statdir = '/u/vplaces/scripts/demog/';
$G_exportdir = '/logs/demog/';

chdir $G_statdir;

&processOptions();
&getPeople;
$totalPeople = $people;
1 while $totalPeople =~ s/(\d+)(\d\d\d)/$1,$2/;

&getCount;

$date = UnixDate($OPT_date, '%F');
$out = UnixDate($OPT_date, '%Y%m%d');
$outfn = join('', $G_exportdir, $out, ".demographics.html");

# $date = `date`;
# chomp $date;
# 
# $out = `date "+%Y%m%d"`;
# chomp $out;

$ageRange{1} = "17 or younger";
$ageRange{2} = "18-24";
$ageRange{3} = "25-34";
$ageRange{4} = "35-44";
$ageRange{5} = "45-54";
$ageRange{6} = "55-64";
$ageRange{7} = "65 or older";

# open (OUT, ">$out.demographics.html") || die;
open (OUT, ">$outfn") || die "Can't write to $outfn : $!";

print OUT qq|<html>
<head>
<title>PAL/Chat Registration Demographics</title>
</head>
<body bgcolor="#ffffff">
<h1>
PAL/Chat Registration Demographics
</h1>
<hr size=5>
<center><font size=-1>[ <a href="index.html">Daily Index</a> ] </font></center>
<hr>
<p>These are registrations for which we have details,
which is a smaller number than the grand total registrations.
<p>
<table border=0>
<tr>
 <td align=right>
  <b>Report Date:</b>
 </td>
 <td>
   $date
 </td>
</tr>
<tr>
 <td align=right>
  <b>Total People:</b>
 </td>
 <td>
   $totalPeople
 </td>
</tr>
</table>
<p>
<table border=1>
<tr>
 <th>Age</th>
 <th>Male</th>
 <th>%</th>
 <th>Female</th>
 <th>%</th>
 <th>Total</th>
 <th>%</th>
</tr>
|;
for($i=1; $i<=7; $i++) {
	$males = $males{$i}; 
	$females = $females{$i}; 
	$total = $males + $females; 
	
	$mPct = ($males / $total) * 100;
	$fPct = 100 - $mPct;
	$mPct = sprintf("%5.2f", $mPct) . ' %';
	$fPct = sprintf("%5.2f", $fPct) . ' %';

	$tPct = ($total / $people) * 100;
	$tPct = sprintf("%5.2f", $tPct) . ' %';
	
	1 while $males =~ s/(\d+)(\d\d\d)/$1,$2/;
	1 while $females =~ s/(\d+)(\d\d\d)/$1,$2/;
	1 while $total =~ s/(\d+)(\d\d\d)/$1,$2/;
	print OUT qq|
<tr>
 <td align=center><b>$ageRange{$i}</b></td>
 <td align=right width=90>$males</td>
 <td align=right width=55>$mPct</td>
 <td align=right width=90>$females</td>
 <td align=right width=55>$fPct</td>
 <td align=right width=90>$total</td>
 <td align=right width=55>$tPct</td>
</tr>
|;
}
print OUT qq|
</table>
<hr size=5>
<center><font size=-1>[ <a href="index.html">Daily Index</a> ] </font></center>
<hr>
</body>
</html>
|;
close OUT;
__END__
