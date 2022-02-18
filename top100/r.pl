#!/usr/bin/perl
#
# Build HTML page with Top 100 chat rooms
#
# Tom Lang 2/2002

use Date::Manip;
use DBI;

sub commaPunc {
  my $n = shift @_;
  1 while ($n =~ s/(\d+)(\d\d\d)/$1,$2/);
  return $n;
}

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

#####################################################
#
# Subroutine: get hidden places
#
sub getHiddenPlaces {
  
  my $sth = $G_dbh->prepare("SELECT URL FROM vpplaces..shadowPlaces");
  die 'Prepare failed' unless (defined($sth));
  $sth->execute;
  my (@row);
  do {
    while (@row = $sth->fetchrow() ) {
      my $url = shift @row;
      $G_hidden{$url} = 1;
    }
  } while($sth->{syb_more_results});
  $sth->finish;
}

##############################
#
# START HERE
#

&getConfigKeys;
die "missing config keys" unless(defined(%G_config));
if ($G_config{'communityName'} =~ /vpadult/) {
  $docRoot = $G_config{'adultRoot'};
  $srvr = $G_config{'VPSTATSadultServer'};
  @frontEndServers = split(/,/,$G_config{'adultFEWS'});
} else {
  $docRoot = $G_config{'chatRoot'};
  $srvr = $G_config{'VPSTATSserver'};
  @frontEndServers = split(/,/,$G_config{'chatFEWS'});
}

$top = 100;

$templateDir = "/u/vplaces/templates";
$template = $templateDir . "/topRooms.htmp";
$outFile  = $docRoot . "/topRooms.php";

#$d = &ParseDate(`date`);
#$today = &UnixDate( $d, '%Y%m%d');
$today = &ParseDate(`date`);
$today =~ s/\d\d:\d\d:\d\d//;

$G_statsFile = "/u/vplaces/VPCOM/VPSTATS/stat.log.$today";
print "$G_statsFile\n";exit;
if (! (-f $G_statsFile) && ($G_config{'testServer'})) {
  $G_statsFile = "/u/vplaces/VPCOM/VPSTATS/stat.log.test";
}

open (TEMP, "<$template") || die "Can't read $template : $!";
open (HTML, ">$outFile") || die "Can't create $outFile : $!";

#
# get list of URLs we don't care to publish
#
&getHiddenPlaces;

if ($srvr eq $G_config{'thisHost'}) {
  open (STATS, "<$G_statsFile")   || die "Can't read $G_statsFile : $!";
} else {
  open (STATS, "/bin/rsh $srvr \"cat $G_statsFile\" |")   || die "Can't read $G_statsFile : $!";
}
$_ = <STATS>;	# skip header lines
$_ = <STATS>;
while(<STATS>) {
	next if (/vpbuddy:/);
	last if (/^Samples/);
	chomp;
	($min, $url, $title) = split(/\t/);
	next if (defined($G_hidden{$url}));
	$usage{$url} = $min;
    	$title =~ s/<\w[^>]*>//g;	# strip HTML tags
	$title{$url} = $title;
}
close STATS;

while (<TEMP>) {
	last if (/###END OF HEADER###/);
	1 while( s/###([^#]+)###/$G_config{$1}/ );
	print HTML;
}

$rank = 1;
foreach $url (sort {$usage{$b} <=> $usage{$a}} keys %usage) {
	last if ($top-- == 0);
	$min = &commaPunc($usage{$url});
	$title = ($title{$url} eq "") ? $url : $title{$url};
	print HTML <<ROW;
        <tr> 
          <th class=forminfo align=right>$rank</th>
          <th class=forminfo align=right>$min</th>
          <td class="forminfo">&nbsp;</td>
          <td class="forminfo"><a href=$url>$title</a></td>
        </tr>
ROW
	$rank++;

}

while (<TEMP>) {
	1 while( s/###([^#]+)###/$G_config{$1}/ );
	print HTML;
}
close TEMP;
close HTML;

foreach $server (@frontEndServers) {
  next if ($server eq $G_config{'thisHost'});
  `/bin/rcp $outFile $server:$docRoot/topRooms.htmp`;
  `/bin/rsh $server "mv $docRoot/topRooms.htmp $docRoot/topRooms.php"`;
}
