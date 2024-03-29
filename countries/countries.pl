#!/usr/local/bin/perl -w
# $Id: countries.pl,v 1.3 1997/09/18 18:24:42 vplaces Exp vplaces $
#
# show registered people by country
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

	$ENV{'SYBASE'} ||= '/t/t/s/sybase';

	my $sql_cmd =<<"SQLCMD";
use vpusers
go
select count(country)
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
# unlink would be better
	`/usr/local/bin/rm $tempsql`;
}

###################
#
# Subroutine: query the database for country names and 
#	registration counts
#
sub getCountries {
	my $tempsql = $G_statdir . ".temp.sql.$$";

	$ENV{'SYBASE'} ||= '/t/t/s/sybase';

	my $sql_cmd =<<"SQLCMD";
use vpusers
go
select distinct country, count(country)
from userDetails
group by country
order by count(country) desc
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
		($country, $count) = split;

		# hack: null country name
		if ($country =~ /\s*\d+\s*/) {
			$count = $country;
			$country = "--";
		}

		push(@totals, $count);
		push(@names, $country);
		$countries++;
	}
	close(SQL_OUT);
	unlink $tempsql;
}

####################
#
# START HERE
#
$G_isql_exe = '/t/t/s/sybase/bin/isql -Usa -Ppassword -SSYBASE';
$G_statdir = '/cafe/u/vplaces/VPCOM/VPINVBUD/';
$G_exportdir = '/cafe/u/vplaces/xport_logs/';

#
# build array of country names
#
$countries{"AF"} = "Afghanistan";
$countries{"AL"} = "Albania";
$countries{"DZ"} = "Algeria";
$countries{"AS"} = "American Samoa";
$countries{"AD"} = "Andorra";
$countries{"AO"} = "Angola";
$countries{"AI"} = "Anguilla";
$countries{"AQ"} = "Antarctica";
$countries{"AG"} = "Antigua and Barbuda";
$countries{"AR"} = "Argentina";
$countries{"AM"} = "Armenia";
$countries{"AW"} = "Aruba";
$countries{"AU"} = "Australia";
$countries{"AT"} = "Austria";
$countries{"AZ"} = "Azerbaijan";
$countries{"BS"} = "Bahamas";
$countries{"BH"} = "Bahrain";
$countries{"BD"} = "Bangladesh";
$countries{"BB"} = "Barbados";
$countries{"BY"} = "Belarus";
$countries{"BE"} = "Belgium";
$countries{"BZ"} = "Belize";
$countries{"BJ"} = "Benin";
$countries{"BM"} = "Bermuda";
$countries{"BT"} = "Bhutan";
$countries{"BO"} = "Bolivia";
$countries{"BA"} = "Bosnia and Herzegowina";
$countries{"BW"} = "Botswana";
$countries{"BV"} = "Bouvet Island";
$countries{"BR"} = "Brazil";
$countries{"IO"} = "British Indian Ocean Territory";
$countries{"BN"} = "Brunei Darussalam";
$countries{"BG"} = "Bulgaria";
$countries{"BF"} = "Burkina Faso";
$countries{"BI"} = "Burundi";
$countries{"KH"} = "Cambodia";
$countries{"CM"} = "Cameroon";
$countries{"CA"} = "Canada";
$countries{"CV"} = "Cape Verde";
$countries{"KY"} = "Cayman Islands";
$countries{"CF"} = "Central African Republic";
$countries{"TD"} = "Chad";
$countries{"CL"} = "Chile";
$countries{"CN"} = "China";
$countries{"CX"} = "Christmas Island";
$countries{"CC"} = "Cocos (Keeling) Islands";
$countries{"CO"} = "Colombia";
$countries{"KM"} = "Comoros";
$countries{"CG"} = "Congo";
$countries{"CK"} = "Cook Islands";
$countries{"CR"} = "Costa Rica";
$countries{"CI"} = "Cote D'Ivoire";
$countries{"HR"} = "Croatia (local name: Hrvatska)";
$countries{"CU"} = "Cuba";
$countries{"CY"} = "Cyprus";
$countries{"CZ"} = "Czech Republic";
$countries{"DK"} = "Denmark";
$countries{"DJ"} = "Djibouti";
$countries{"DM"} = "Dominica";
$countries{"DO"} = "Dominican Republic";
$countries{"TP"} = "East Timor";
$countries{"EC"} = "Ecuador";
$countries{"EG"} = "Egypt";
$countries{"SV"} = "El Salvador";
$countries{"GQ"} = "Equatorial Guinea";
$countries{"ER"} = "Eritrea";
$countries{"EE"} = "Estonia";
$countries{"ET"} = "Ethiopia";
$countries{"FK"} = "Falkland Islands (Malvinas)";
$countries{"FO"} = "Faroe Islands";
$countries{"FJ"} = "Fiji";
$countries{"FI"} = "Finland";
$countries{"FR"} = "France";
$countries{"FX"} = "France, Metropolitan";
$countries{"GF"} = "French Guiana";
$countries{"PF"} = "French Polynesia";
$countries{"TF"} = "French Southern Territories";
$countries{"GA"} = "Gabon";
$countries{"GM"} = "Gambia";
$countries{"GE"} = "Georgia";
$countries{"DE"} = "Germany";
$countries{"GH"} = "Ghana";
$countries{"GI"} = "Gibraltar";
$countries{"GR"} = "Greece";
$countries{"GL"} = "Greenland";
$countries{"GD"} = "Grenada";
$countries{"GP"} = "Guadeloupe";
$countries{"GU"} = "Guam";
$countries{"GT"} = "Guatemala";
$countries{"GN"} = "Guinea";
$countries{"GW"} = "Guinea-Bissau";
$countries{"GY"} = "Guyana";
$countries{"HT"} = "Haiti";
$countries{"HM"} = "Heard and Mc Donald Islands";
$countries{"HN"} = "Honduras";
$countries{"HK"} = "Hong Kong";
$countries{"HU"} = "Hungary";
$countries{"IS"} = "Iceland";
$countries{"IN"} = "India";
$countries{"ID"} = "Indonesia";
$countries{"IR"} = "Iran (Islamic Republic of)";
$countries{"IQ"} = "Iraq";
$countries{"IE"} = "Ireland";
$countries{"IL"} = "Israel";
$countries{"IT"} = "Italy";
$countries{"JM"} = "Jamaica";
$countries{"JP"} = "Japan";
$countries{"JO"} = "Jordan";
$countries{"KZ"} = "Kazakhstan";
$countries{"KE"} = "Kenya";
$countries{"KI"} = "Kiribati";
$countries{"KP"} = "Korea (North)";
$countries{"KR"} = "Korea (South)";
$countries{"KW"} = "Kuwait";
$countries{"KG"} = "Kyrgyzstan";
$countries{"LA"} = "Lao People's Democratic Republic";
$countries{"LV"} = "Latvia";
$countries{"LB"} = "Lebanon";
$countries{"LS"} = "Lesotho";
$countries{"LR"} = "Liberia";
$countries{"LY"} = "Libyan Arab Jamahiriya";
$countries{"LI"} = "Liechtenstein";
$countries{"LT"} = "Lithuania";
$countries{"LU"} = "Luxembourg";
$countries{"MO"} = "Macau";
$countries{"MK"} = "Macedonia";
$countries{"MG"} = "Madagascar";
$countries{"MW"} = "Malawi";
$countries{"MY"} = "Malaysia";
$countries{"MV"} = "Maldives";
$countries{"ML"} = "Mali";
$countries{"MT"} = "Malta";
$countries{"MH"} = "Marshall Islands";
$countries{"MQ"} = "Martinique";
$countries{"MR"} = "Mauritania";
$countries{"MU"} = "Mauritius";
$countries{"YT"} = "Mayotte";
$countries{"MX"} = "Mexico";
$countries{"FM"} = "Micronesia";
$countries{"MD"} = "Moldova";
$countries{"MC"} = "Monaco";
$countries{"MN"} = "Mongolia";
$countries{"MS"} = "Montserrat";
$countries{"MA"} = "Morocco";
$countries{"MZ"} = "Mozambique";
$countries{"MM"} = "Myanmar";
$countries{"NA"} = "Namibia";
$countries{"NR"} = "Nauru";
$countries{"NP"} = "Nepal";
$countries{"NL"} = "Netherlands";
$countries{"AN"} = "Netherlands Antilles";
$countries{"NC"} = "New Caledonia";
$countries{"NZ"} = "New Zealand";
$countries{"NI"} = "Nicaragua";
$countries{"NE"} = "Niger";
$countries{"NG"} = "Nigeria";
$countries{"NU"} = "Niue";
$countries{"NF"} = "Norfolk Island";
$countries{"MP"} = "Northern Mariana Islands";
$countries{"NO"} = "Norway";
$countries{"00"} = "other";
$countries{"OM"} = "Oman";
$countries{"PK"} = "Pakistan";
$countries{"PW"} = "Palau";
$countries{"PA"} = "Panama";
$countries{"PG"} = "Papua New Guinea";
$countries{"PY"} = "Paraguay";
$countries{"PE"} = "Peru";
$countries{"PH"} = "Philippines";
$countries{"PN"} = "Pitcairn";
$countries{"PL"} = "Poland";
$countries{"PT"} = "Portugal";
$countries{"PR"} = "Puerto Rico";
$countries{"QA"} = "Qatar";
$countries{"RE"} = "Reunion";
$countries{"RO"} = "Romania";
$countries{"RU"} = "Russian Federation";
$countries{"RW"} = "Rwanda";
$countries{"KN"} = "Saint Kitts and Nevis";
$countries{"LC"} = "Saint Lucia";
$countries{"VC"} = "Saint Vincent and the Grenadines";
$countries{"WS"} = "Samoa";
$countries{"SM"} = "San Marino";
$countries{"ST"} = "Sao Tome and Principe";
$countries{"SA"} = "Saudi Arabia";
$countries{"SN"} = "Senegal";
$countries{"SC"} = "Seychelles";
$countries{"SL"} = "Sierra Leone";
$countries{"SG"} = "Singapore";
$countries{"SK"} = "Slovakia (Slovak Republic)";
$countries{"SI"} = "Slovenia";
$countries{"SB"} = "Solomon Islands";
$countries{"SO"} = "Somalia";
$countries{"ZA"} = "South Africa";
$countries{"ES"} = "Spain";
$countries{"LK"} = "Sri Lanka";
$countries{"SH"} = "St. Helena";
$countries{"PM"} = "St. Pierre and Miquelon";
$countries{"SD"} = "Sudan";
$countries{"SR"} = "Suriname";
$countries{"SJ"} = "Svalbard and Jan Mayen Islands";
$countries{"SZ"} = "Swaziland";
$countries{"SE"} = "Sweden";
$countries{"CH"} = "Switzerland";
$countries{"SY"} = "Syrian Arab Republic";
$countries{"TW"} = "Taiwan";
$countries{"TJ"} = "Tajikistan";
$countries{"TZ"} = "Tanzania, United Republic of";
$countries{"TH"} = "Thailand";
$countries{"TG"} = "Togo";
$countries{"TK"} = "Tokelau";
$countries{"TO"} = "Tonga";
$countries{"TT"} = "Trinidad and Tobago";
$countries{"TN"} = "Tunisia";
$countries{"TR"} = "Turkey";
$countries{"TM"} = "Turkmenistan";
$countries{"TC"} = "Turks and Caicos Islands";
$countries{"TV"} = "Tuvalu";
$countries{"UG"} = "Uganda";
$countries{"UA"} = "Ukraine";
$countries{"AE"} = "United Arab Emirates";
$countries{"UK"} = "United Kingdom";
$countries{"US"} = "United States";
$countries{"UM"} = "U. S. Minor Outlying Islands";
$countries{"UY"} = "Uruguay";
$countries{"UZ"} = "Uzbekistan";
$countries{"VU"} = "Vanuatu";
$countries{"VA"} = "Vatican City State (Holy See)";
$countries{"VE"} = "Venezuela";
$countries{"VN"} = "Viet Nam";
$countries{"VG"} = "Virgin Islands (British)";
$countries{"VI"} = "Virgin Islands (U.S.)";
$countries{"WF"} = "Wallis And Futuna Islands";
$countries{"EH"} = "Western Sahara";
$countries{"YE"} = "Yemen";
$countries{"YU"} = "Yugoslavia";
$countries{"ZR"} = "Zaire";
$countries{"ZM"} = "Zambia";
$countries{"ZW"} = "Zimbabwe";

chdir $G_statdir;

&getCountries;
&getPeople;

#
# account for entries with no info available
#
$unk = 0;
for ($i = 0; $i <= $#names; $i++) {
	$name = (defined($countries{$names[$i]})) ? $countries{$names[$i]} : $names[$i];

	if ($names[$i] =~ /\-/) {
		$unk += $totals[$i];
		next;
	}
}

$totalPeople = $people;
1 while $totalPeople =~ s/(\d+)(\d\d\d)/$1,$2/;

$totalUnk = $unk;
1 while $totalUnk =~ s/(\d+)(\d\d\d)/$1,$2/;

$people -= $unk;
$totalKnownPeople = $people;
1 while $totalKnownPeople =~ s/(\d+)(\d\d\d)/$1,$2/;

&processOptions();

($date, $out) = UnixDate($OPT_date, '%F', '%Q');
$outfn = join('', $G_exportdir, $out, ".countries.html");

# $date = `date`;
# chomp $date;
# 
# $out = `date "+%Y%m%d"`;
# chomp $out;

open (OUT, ">$outfn") || die "Can't write to $outfn : $!";
# open (OUT, ">$out.countries.html") || die;

print OUT qq|<html>
<head>
<title>PAL/Chat Registrations by Country</title>
</head>
<body bgcolor="#ffffff">
<h1>
PAL/Chat Registrations by Country
</h1>
<hr size=5>
<center><font size=-1>[ <a href="index.html">Daily Index</a> ] </font></center>
<hr>
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
  <b>Total countries:</b>
 </td>
 <td>
   $countries
 </td>
</tr>
<tr>
 <td align=right>
  <b>People registered:</b>
 </td>
 <td>
   $totalPeople
 </td>
</tr>
<tr>
 <td align=right>
  <b>No details available (mailexcite) :</b>
 </td>
 <td>
   $totalUnk
 </td>
</tr>
<tr>
 <td align=right>
  <b>People registered, details available:</b>
 </td>
 <td>
   $totalKnownPeople
 </td>
</tr>
</table>
<p>
<table border=0>
<tr>
 <th>People</th>
 <th>Percentage</th>
 <th>&nbsp;</th>
 <th>Country</th>
</tr>
|;
$unk = 0;
for ($i = 0; $i <= $#names; $i++) {
	$name = (defined($countries{$names[$i]})) ? $countries{$names[$i]} : $names[$i];

	next if ($name =~ /\-/);

	$pct = ($totals[$i] / $people) * 100;
	$pct = sprintf("%5.2f", $pct) . ' %';
	print OUT "<tr>
 <td align=right>$totals[$i]</td>
 <td align=right>$pct</td>
 <td>&nbsp;</td>
 <td align=left>$name</td>
</tr>
";
}

print OUT qq!</table>
<hr size=5>
<center><font size=-1>[ <a href="index.html">Daily Index</a> ] </font></center>
<hr>
</body>
</html>
!;
close OUT;
