#!/usr/bin/perl
#
# show demographic information from the credit card and eCheck database
#
# Tom Lang 8/2002
#
#use Date::Manip;
use DBI;

BEGIN {
  $ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';
  $G_dbh = DBI->connect ( 'dbi:Sybase:', 'sa', 'UBIQUE' );
}

#####################################################
#
# Subroutine: get configuration keys from the database
#
sub getConfigKeys {
  undef %G_config;
  
  my $sth = $G_dbh->prepare("EXEC vpusers..getServerConfig");
  die 'Prepare failed' unless (defined($sth));
  $sth->execute;
  my (@row);
  do {
    while (@row = $sth->fetchrow() ) {
      my $key = shift @row;
      $G_config{$key} = shift @row;
    }
  } while($sth->{syb_more_results});
  $sth->finish;
  die "database error - missing config keys" unless((scalar keys %G_config) > 0);
  my $host = `hostname`;
  chomp $host;
  $G_config{'thisHost'} = $host;

  my @now = localtime(time);
  $G_config{'curYear'} = $now[5]+1900;
}

###################
#
# Subroutine: query the database for total registrations by US state
#
sub getByState {

	my $people = 0;
	my $sth = $G_dbh->prepare("SELECT COUNT(Ecom_billto_stateprov) FROM vpusers..creditCards WHERE Ecom_billto_countrycode = 'US'");
	$sth->execute;
	my (@row);
	do {
	  while (@row = $sth->fetchrow() ) {
	    $people += shift @row;
	  }
	} while($sth->{syb_more_results});
	$sth->finish;

	$sth = $G_dbh->prepare("SELECT COUNT(Ecom_billto_stateprov) FROM vpusers..echecks WHERE Ecom_billto_countrycode = 'US'");
	$sth->execute;
	do {
	  while (@row = $sth->fetchrow() ) {
	    $people += shift @row;
	  }
	} while($sth->{syb_more_results});
	$sth->finish;

	$sth = $G_dbh->prepare("SELECT COUNT(stateprov) FROM vpusers..userInfo WHERE countrycode = 'US'");
	$sth->execute;
	do {
	  while (@row = $sth->fetchrow() ) {
	    $people += shift @row;
	  }
	} while($sth->{syb_more_results});
	$sth->finish;

	$sth = $G_dbh->prepare("SELECT COUNT(Ecom_billto_stateprov), Ecom_billto_stateprov FROM vpusers..creditCards WHERE Ecom_billto_countrycode = 'US' GROUP BY Ecom_billto_stateprov ORDER BY COUNT(Ecom_billto_stateprov) DESC");
	$sth->execute;
	do {
	  while (@row = $sth->fetchrow() ) {
	    my $p = shift @row;
	    my $s = shift @row;
	    if ($s =~ /[a-z]/) {
		print "credit card anomaly, state = $s\n";
		$s =~ tr/[a-z]/[A-Z/;
	    }
	    $state{$s} += $p;
	  }
	} while($sth->{syb_more_results});
	$sth->finish;

	$sth = $G_dbh->prepare("SELECT COUNT(Ecom_billto_stateprov), Ecom_billto_stateprov FROM vpusers..echecks WHERE Ecom_billto_countrycode = 'US' GROUP BY Ecom_billto_stateprov ORDER BY COUNT(Ecom_billto_stateprov) DESC");
	$sth->execute;
	do {
	  while (@row = $sth->fetchrow() ) {
	    my $p = shift @row;
	    my $s = shift @row;
	    if ($s =~ /[a-z]/) {
		print "eCheck anomaly, state = $s\n";
		$s =~ tr/[a-z]/[A-Z/;
	    }
	    $state{$s} += $p;
	  }
	} while($sth->{syb_more_results});
	$sth->finish;

	$sth = $G_dbh->prepare("SELECT COUNT(stateprov), stateprov FROM vpusers..userInfo WHERE countrycode = 'US' GROUP BY stateprov ORDER BY COUNT(stateprov) DESC");
	$sth->execute;
	do {
	  while (@row = $sth->fetchrow() ) {
	    my $p = shift @row;
	    my $s = shift @row;
	    if ($s =~ /[a-z]/) {
		print "user info anomaly, state = $s\n";
		$s =~ tr/[a-z]/[A-Z/;
	    }
	    next if ($s =~ /^\s*$/);
	    unless(defined($st{$s})) {
		print "user info anomaly, state = $s\n";
		next;
	    }
	    $state{$s} += $p;
	  }
	} while($sth->{syb_more_results});
	$sth->finish;

	return $people;
}

###################
#
# Subroutine: query the database for total registrations by country
#
sub getByCountry {

	my $people = 0;

	my $sth = $G_dbh->prepare("SELECT COUNT(Ecom_billto_countrycode) FROM vpusers..creditCards");
	$sth->execute;
	my (@row);
	do {
	  while (@row = $sth->fetchrow() ) {
	    $people += shift @row;
	  }
	} while($sth->{syb_more_results});
	$sth->finish;

	$sth = $G_dbh->prepare("SELECT COUNT(Ecom_billto_countrycode) FROM vpusers..echecks");
	$sth->execute;
	do {
	  while (@row = $sth->fetchrow() ) {
	    $people += shift @row;
	  }
	} while($sth->{syb_more_results});
	$sth->finish;

	$sth = $G_dbh->prepare("SELECT COUNT(countrycode) FROM vpusers..userInfo");
	$sth->execute;
	do {
	  while (@row = $sth->fetchrow() ) {
	    $people += shift @row;
	  }
	} while($sth->{syb_more_results});
	$sth->finish;

	$sth = $G_dbh->prepare("SELECT COUNT(Ecom_billto_countrycode), Ecom_billto_countrycode FROM vpusers..creditCards GROUP BY Ecom_billto_countrycode ORDER BY COUNT(Ecom_billto_countrycode) DESC");
	$sth->execute;
	do {
	  while (@row = $sth->fetchrow() ) {
	    my $p = shift @row;
	    my $c = shift @row;
	    $country{$c} += $p;
	  }
	} while($sth->{syb_more_results});
	$sth->finish;

	$sth = $G_dbh->prepare("SELECT COUNT(Ecom_billto_countrycode), Ecom_billto_countrycode FROM vpusers..echecks GROUP BY Ecom_billto_countrycode ORDER BY COUNT(Ecom_billto_countrycode) DESC");
	$sth->execute;
	do {
	  while (@row = $sth->fetchrow() ) {
	    my $p = shift @row;
	    my $c = shift @row;
	    $country{$c} += $p;
	  }
	} while($sth->{syb_more_results});
	$sth->finish;

	$sth = $G_dbh->prepare("SELECT COUNT(countrycode), countrycode FROM vpusers..userInfo GROUP BY countrycode ORDER BY COUNT(countrycode) DESC");
	$sth->execute;
	do {
	  while (@row = $sth->fetchrow() ) {
	    my $p = shift @row;
	    my $c = shift @row;
	    $country{$c} += $p;
	  }
	} while($sth->{syb_more_results});
	$sth->finish;

	return $people;
}

####################
#
# START HERE
#
&getConfigKeys;
$G_statdir = '/u/vplaces/scripts/demog/';
$G_template = '/u/vplaces/templates/demog.htmp';

$c{'US'} = "United States";
$c{'AD'} = "Andorra";
$c{'AG'} = "Antigua and Barbuda";
$c{'AI'} = "Anguilla";
$c{'AN'} = "Netherlands Antilles";
$c{'AR'} = "Argentina";
$c{'AS'} = "American Samoa";
$c{'AT'} = "Austria";
$c{'AU'} = "Australia";
$c{'AW'} = "Aruba";
$c{'BA'} = "Bosnia and Herzegovina";
$c{'BB'} = "Barbados";
$c{'BE'} = "Belgium";
$c{'BM'} = "Bermuda";
$c{'BO'} = "Bolivia";
$c{'BR'} = "Brazil";
$c{'BS'} = "Bahamas";
$c{'BZ'} = "Belize";
$c{'CA'} = "Canada";
$c{'KY'} = "Cayman Islands";
$c{'CL'} = "Chile";
$c{'CO'} = "Colombia";
$c{'CR'} = "Costa Rica";
$c{'CZ'} = "Czech Republic";
$c{'DK'} = "Denmark";
$c{'DM'} = "Dominica";
$c{'DO'} = "Dominican Republic";
$c{'EC'} = "Ecuador";
$c{'SV'} = "El Salvador";
$c{'FI'} = "Finland";
$c{'FJ'} = "Fiji";
$c{'FM'} = "Micronesia";
$c{'FR'} = "France";
$c{'DE'} = "Germany";
$c{'GB'} = "Great Britain (UK)";
$c{'GD'} = "Grenada";
$c{'GL'} = "Greenland";
$c{'GP'} = "Guadeloupe";
$c{'GR'} = "Greece";
$c{'GT'} = "Guatemala";
$c{'GU'} = "Guam";
$c{'GY'} = "Guyana";
$c{'HK'} = "Hong Kong";
$c{'HN'} = "Honduras";
$c{'HR'} = "Croatia (Hrvatska)";
$c{'HT'} = "Haiti";
$c{'HU'} = "Hungary";
$c{'IE'} = "Ireland";
$c{'IL'} = "Israel";
$c{'IS'} = "Iceland";
$c{'IN'} = "India";
$c{'IT'} = "Italy";
$c{'JM'} = "Jamaica";
$c{'JP'} = "Japan";
$c{'KR'} = "Korea (South)";
$c{'LI'} = "Liechtenstein";
$c{'LT'} = "Lithuania";
$c{'LU'} = "Luxembourg";
$c{'LV'} = "Latvia";
$c{'MC'} = "Monaco";
$c{'MD'} = "Moldova";
$c{'MH'} = "Marshall Islands";
$c{'MP'} = "Northern Mariana Islands";
$c{'MQ'} = "Martinique";
$c{'MT'} = "Malta";
$c{'MV'} = "Maldives";
$c{'MX'} = "Mexico";
$c{'MY'} = "Myanmar";
$c{'NC'} = "New Caledonia";
$c{'NF'} = "Norfolk Island";
$c{'NI'} = "Nicaragua";
$c{'NL'} = "Netherlands";
$c{'NO'} = "Norway";
$c{'NZ'} = "New Zealand (Aotearoa)";
$c{'PA'} = "Panama";
$c{'PE'} = "Peru";
$c{'PF'} = "French Polynesia";
$c{'PG'} = "Papua New Guinea";
$c{'PL'} = "Poland";
$c{'PR'} = "Puerto Rico";
$c{'PT'} = "Portugal";
$c{'PY'} = "Paraguay";
$c{'RO'} = "Romania";
$c{'RU'} = "Russian Federation";
$c{'KN'} = "Saint Kitts and Nevis";
$c{'LC'} = "Saint Lucia";
$c{'VC'} = "Saint Vincent and the Grenadines";
$c{'WS'} = "Samoa";
$c{'SM'} = "San Marino";
$c{'SG'} = "Singapore";
$c{'SI'} = "Slovenia";
$c{'SK'} = "Slovak Republic";
$c{'ZA'} = "South Africa";
$c{'ES'} = "Spain";
$c{'SR'} = "Suriname";
$c{'SE'} = "Sweden";
$c{'CH'} = "Switzerland";
$c{'TW'} = "Taiwan";
$c{'TO'} = "Tonga";
$c{'TT'} = "Trinidad and Tobago";
$c{'TC'} = "Turks and Caicos Islands";
$c{'UA'} = "Ukraine";
$c{'UM'} = "US Minor Outlying Islands";
$c{'US'} = "United States";
$c{'UY'} = "Uruguay";
$c{'VE'} = "Venezuela";
$c{'VG'} = "Virgin Islands (British)";
$c{'VI'} = "Virgin Islands (U.S.)";
$c{'VU'} = "Vanuatu";
$c{'WF'} = "Wallis and Futuna Islands";
$c{'YU'} = "Yugoslavia";

$st{"AS"} = "American Samoa";
$st{"AA"} = "Armed Forces, America";
$st{"AE"} = "Armed Forces, Europe";
$st{"AP"} = "Armed Forces, Pacific";
$st{"PR"} = "Puerto Rico";
$st{"AS"} = "American Samoa";
$st{"AL"} = "Alabama";
$st{"AK"} = "Alaska";
$st{"AZ"} = "Arizona";
$st{"AR"} = "Arkansas";
$st{"CA"} = "California";
$st{"CO"} = "Colorado";
$st{"CT"} = "Connecticut";
$st{"DC"} = "District of Columbia";
$st{"DE"} = "Delaware";
$st{"FL"} = "Florida";
$st{"GA"} = "Georgia";
$st{"HI"} = "Hawaii";
$st{"ID"} = "Idaho";
$st{"IL"} = "Illinois";
$st{"IN"} = "Indiana";
$st{"IA"} = "Iowa";
$st{"KS"} = "Kansas";
$st{"KY"} = "Kentucky";
$st{"LA"} = "Louisiana";
$st{"ME"} = "Maine";
$st{"MD"} = "Maryland";
$st{"MA"} = "Massachusetts";
$st{"MI"} = "Michigan";
$st{"MN"} = "Minnesota";
$st{"MS"} = "Mississippi";
$st{"MO"} = "Missouri";
$st{"MT"} = "Montana";
$st{"NE"} = "Nebraska";
$st{"NV"} = "Nevada";
$st{"NH"} = "New Hampshire";
$st{"NJ"} = "New Jersey";
$st{"NM"} = "New Mexico";
$st{"NY"} = "New York";
$st{"NC"} = "North Carolina";
$st{"ND"} = "North Dakota";
$st{"OH"} = "Ohio";
$st{"OK"} = "Oklahoma";
$st{"OR"} = "Oregon";
$st{"PA"} = "Pennsylvania";
$st{"RI"} = "Rhode Island";
$st{"SC"} = "South Carolina";
$st{"SD"} = "South Dakota";
$st{"TN"} = "Tennessee";
$st{"TX"} = "Texas";
$st{"UT"} = "Utah";
$st{"VT"} = "Vermont";
$st{"VA"} = "Virginia";
$st{"WA"} = "Washington";
$st{"WV"} = "West Virginia";
$st{"WI"} = "Wisconsin";
$st{"WY"} = "Wyoming";

chdir $G_statdir;

$USpeople = &getByState;

$totalUSpeople = $USpeople;
1 while $totalUSpeople =~ s/(\d+)(\d\d\d)/$1,$2/;

$people = &getByCountry;

$totalPeople = $people;
1 while $totalPeople =~ s/(\d+)(\d\d\d)/$1,$2/;

$outfn = $G_config{'chatRoot'} . "/demographics.html";
$outfn2 = $G_config{'regRoot'} . "/demographics.html";

open (OUT, ">$outfn") || die "Can't write to $outfn : $!";

$date = scalar localtime(time);
$date =~ s/\d\d:\d\d:\d\d//;

open (TEMPLATE, "<$G_template") || die "Can't read $G_template : $!";
while (<TEMPLATE>) {
	last if (/###DEMOG###/);
	1 while( s/###([^#]+)###/$G_config{$1}/ );
	print OUT;
}

print OUT <<HTML;
<table width=640 border=0 cellpadding=0 cellspacing=0>
  <TR>
<td width=50>&nbsp;</td>
    <td width="535" valign="top" align=left class="forminfo"><span class="breadcrumbSecondary"> <br>
      VPchat Demographics<br></span>
<span class="Item">&nbsp;Updated $date</span>
      <p> 
      <table border=0 width=100% bgcolor="cccccc">
        <tr valign=top>
          <td width=50% align=center> 
            <table width=100% cellpadding=3 border=0 bgcolor="ffffff">
              <tr> 
                <th colspan=2 class="formheader">Registrations by US State</th>
              </tr>
              <tr> 
                <th class="formsubheader">State</th>
                <th class="formsubheader">Percentage</th>
              </tr>
HTML

foreach $state (sort {$state{$b} <=> $state{$a}} keys %state) {
	$ppl = $state{$state};
	$pct = ($ppl / $USpeople) * 100;
	$pct = ($pct < .25) ? '*' : sprintf("%5.2f", $pct) . ' %';
	
	1 while $ppl =~ s/(\d+)(\d\d\d)/$1,$2/;
	$st = (defined($st{$state})) ? $st{$state} : $state;
	print OUT <<HTML;
              <tr> 
                <td align=center class="forminfo"> 
                  <div align="left">$st</div>
                </td>
                <td align=right class="forminfo"> $pct</td>
              </tr>
HTML

}

print OUT <<HTML;
            </table>
          </td>
          <td valign=top align=center width="50%"> 
            <table width="100%" cellpadding=3 border=0 bgcolor="ffffff">
              <tr> 
                <th colspan=2 class="formheader">Registrations by Country</th>
              </tr>
              <tr> 
                <th class="formsubheader">Country</th>
                <th class="formsubheader">Percentage</th>
              </tr>
HTML

foreach $country (sort {$country{$b} <=> $country{$a}} keys %country) {
	$ppl = $country{$country};
	$pct = ($ppl / $people) * 100;
	$pct = ($pct < .1) ? '*' : sprintf("%5.2f", $pct) . ' %';
	
	1 while $ppl =~ s/(\d+)(\d\d\d)/$1,$2/;
	$cn = (exists($c{$country})) ? $c{$country} : $country;
	print OUT <<HTML;
              <tr> 
                <td align=center class="forminfo"> 
                  <div align="left">$cn</div>
                </td>
                <td align=right class="forminfo">$pct</td>
              </tr>
HTML

}

print OUT <<HTML;
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
HTML

while (<TEMPLATE>) {
	last if (/###DEMOG###/);
	1 while( s/###([^#]+)###/$G_config{$1}/ );
	print OUT;
}

close TEMPLATE;
close OUT;

#
# Copy file to front end servers
#
@frontEndServers = split(/,/,$G_config{'chatFEWS'});
foreach $srvr (@frontEndServers) {
  next if ($srvr eq $G_config{'thisHost'});
  `/bin/rcp $outfn $srvr:$outfn`;
}
undef @frontEndServers;
@frontEndServers = split(/,/,$G_config{'regFEWS'});
foreach $srvr (@frontEndServers) {
  next if ($srvr eq $G_config{'thisHost'});
  `/bin/rcp $outfn $srvr:$outfn2`;
}

$G_dbh->disconnect;

__END__
