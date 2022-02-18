#!/usr/bin/perl
#
# show demographic information from the credit card and eCheck database
#
# Tom Lang 8/2002
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
# Subroutine: query the database for total registrations by US state
#
sub getByState {

	my $people = 0;
	my $sql_cmd =<<"SQLCMD";
select 'XXXT',count(Ecom_billto_stateprov ), 'X'
from creditCards
where Ecom_billto_countrycode = 'US'
go
select 'XXXT',count(Ecom_billto_stateprov ), 'X'
from echecks
where Ecom_billto_countrycode = 'US'
go
select 'XXX',count(Ecom_billto_stateprov ),Ecom_billto_stateprov
from creditCards
where Ecom_billto_countrycode = 'US'
group by Ecom_billto_stateprov
order by count(Ecom_billto_stateprov ) desc
go
select 'XXX', count(Ecom_billto_stateprov ),Ecom_billto_stateprov
from echecks
where Ecom_billto_countrycode = 'US'
group by Ecom_billto_stateprov
order by count(Ecom_billto_stateprov ) desc
go
SQLCMD

	open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
   	print SQL_IN $sql_cmd;
	close(SQL_IN);

	open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

	while (<SQL_OUT>) {
		next unless (/XXX/);
		my ($tag, $count, $state) = split;
		if ($tag eq 'XXXT') {
			$people += $count;
		}
		else {
			$state{$state} += $count;
		}
	}

	close(SQL_OUT);

	return $people;
}

###################
#
# Subroutine: query the database for total registrations by country
#
sub getByCountry {

	my $people = 0;
	my $sql_cmd =<<"SQLCMD";
select 'XXXT', count(Ecom_billto_countrycode ), 'X'
from creditCards
go
select 'XXXT', count(Ecom_billto_countrycode ), 'X'
from echecks
go
select 'XXX', count(Ecom_billto_countrycode ),Ecom_billto_countrycode
from creditCards
group by Ecom_billto_countrycode
order by count(Ecom_billto_countrycode ) desc
go
select 'XXX', count(Ecom_billto_countrycode ),Ecom_billto_countrycode
from echecks
group by Ecom_billto_countrycode
order by count(Ecom_billto_countrycode ) desc
go
SQLCMD

	open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
   	print SQL_IN $sql_cmd;
	close(SQL_IN);

	open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

	while (<SQL_OUT>) {
		next unless (/XXX/);
		my ($tag, $count, $country) = split;
		if ($tag eq 'XXXT') {
			$people += $count;
		}
		else {
			$country{$country} += $count;
		}
	}

	close(SQL_OUT);

	return $people;
}

####################
#
# START HERE
#
$G_isql_exe = '/u/vplaces/s/sybase/bin/isql -Uvpusr -Pvpusr1 -SSYBASE';
$G_statdir = '/u/vplaces/scripts/demog/';
$G_exportdir = '/web/cmgmt/html/demog/';
$tempsql = $G_statdir . ".temp.sql.$$";

chdir $G_statdir;

&processOptions();
$USpeople = &getByState;

$totalUSpeople = $USpeople;
1 while $totalUSpeople =~ s/(\d+)(\d\d\d)/$1,$2/;

$people = &getByCountry;

$totalPeople = $people;
1 while $totalPeople =~ s/(\d+)(\d\d\d)/$1,$2/;

$date = UnixDate($OPT_date, '%F');
$out = UnixDate($OPT_date, '%Y%m%d');
$outfn = join('', $G_exportdir, $out, ".demographics.html");

open (OUT, ">$outfn") || die "Can't write to $outfn : $!";

print OUT <<HTML;
<html>
<head>
<title>HalSoft VP Chat Registration Demographics</title>
<META http-equiv=Content-Type content="text/html; charset=windows-1252"><LINK 
href=/layout.css type=text/css rel=stylesheet>
</head>
<body bgcolor="#ffffff">
<h1>
HalSoft VP Chat Registration Demographics
</h1>
<p>These are registrations for which we have credit card or eCheck information,
which is a smaller number than the grand total registrations.
<p>
<table border=0>
<tr>
 <th align=right>
  Report Date:
 </th>
 <td align=left>
   $date
 </td>
</tr>
<tr>
 <th align=right>
  Ttoal Sample Size:
 </td>
 <td align=right>
   $totalPeople
 </td>
</tr>
<tr>
 <th align=right>
  US Sample Size:
 </td>
 <td align=right>
   $totalUSpeople
 </td>
</tr>
</table>
<p>
<table border=0 width=100%>
<tr valign=top><td width=50%>
<table border=1>
<tr>
 <th colspan=3>Registrations by US State</th>
</tr>
<tr>
 <th>State</th><th>Count</th><th>Percentage</th>
</tr>
HTML

foreach $state (sort {$state{$b} <=> $state{$a}} keys %state) {
	$ppl = $state{$state};
	$pct = ($ppl / $USpeople) * 100;
	$pct = sprintf("%5.2f", $pct) . ' %';
	
	1 while $ppl =~ s/(\d+)(\d\d\d)/$1,$2/;
	print OUT <<HTML;
<tr>
 <td align=center>$state</td><td align=right>$ppl</td><td align=right>$pct</td>
</tr>
HTML

}

print OUT <<HTML;
</table>
</td>
<td valign=top>
<table border=1>
<tr>
 <th colspan=3>Registrations by Contry</th>
</tr>
<tr>
 <th>Country</th><th>Count</th><th>Percentage</th>
</tr>
HTML

foreach $country (sort {$country{$b} <=> $country{$a}} keys %country) {
	$ppl = $country{$country};
	$pct = ($ppl / $people) * 100;
	$pct = sprintf("%5.2f", $pct) . ' %';
	
	1 while $ppl =~ s/(\d+)(\d\d\d)/$1,$2/;
	print OUT <<HTML;
<tr>
 <td align=center>$country</td><td align=right>$ppl</td><td align=right>$pct</td>
</tr>
HTML

}

print OUT <<HTML;
</table>
</td>
</tr>
</table>
</body>
</html>
HTML

close OUT;
__END__
