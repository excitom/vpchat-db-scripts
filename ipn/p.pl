#!/usr/bin/perl
#
use DBI;
use DBD::Sybase;

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
}

##################
#
# Subroutine: Parse an IPN record, which is in URL-encoded
#		query string format.
#
sub parse_rec {

   my $buffer = shift @_;
   my ($name, $value, @pairs, @values);
   undef %contents;	# global variable

   @pairs = split(/&/, $buffer);
    
   foreach $pair (@pairs) {
	($name, $value) = split(/=/, $pair);
	$value =~ tr/+/ /;
	$value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
	if (defined($contents{$name})) {
		$contents{$name} .= ",$value";
	} else {
		$contents{$name} = $value;
	}
   }
}


######################
#
# START HERE
#


$logDir = "/logs/ipn/";


#
# Connect to the database
#
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';
$G_dbh = DBI->connect ( 'dbi:Sybase:', 'vpusr', 'vpusr1' );
&getConfigKeys;

@now = localtime(time);
$now[4]++;
$now[5] += 1900;
$suffix = sprintf(".%4.4d%2.2d%2.2d.%2.2d.%2.2d.%2.2d", $now[5], $now[4], $now[3], $now[2], $now[1], $now[0]);


while ($#ARGV > -1) {
  $processed = shift @ARGV;
  $processed = $logDir . $processed;
  print $processed . "\n";
  #
  # Process incoming IPN records
  #
  open(IPN, "<$processed") || die "Can't read $processed : $!";
  while (<IPN>) {
	($when, $status, $parms) = split(/\t/, $_);

	#
	# Handle only 'verified' records
	#
	if ($status eq "VERIFIED") {
		&parse_rec($parms);
		next unless(defined($contents{'payer_email'}) &&
			    defined($contents{'first_name'}) &&
			    defined($contents{'payer_status'}) &&
			    defined($contents{'last_name'}));
		my $aid = (defined($contents{'custom'})) ? $contents{'custom'} : 'NULL';
		$aid = -1 if ($aid eq '');
		$contents{'payer_email'} =~ tr/[A-Z]/[a-z]/;

  		my $sql =<<SQL;
EXEC addPaypalInfo
  "$contents{'payer_email'}",
  "$contents{'first_name'}",
  "$contents{'last_name'}",
  "$contents{'payer_status'}",
  $aid,
SQL
		if (!defined($contents{'payer_id'}) || ($contents{'payer_id'} eq '')) {
			$sql .= "NULL,\n";
		} else {
			$sql .= qq!"$contents{'payer_id'}",\n!;
		}
		if (!defined($contents{'subscr_id'}) || ($contents{'subscr_id'} eq '')) {
			$sql .= "NULL\n";
		} else {
			$sql .= qq!"$contents{'subscr_id'}"\n!;
		}
		print "$sql\n";
  		my $sth = $G_dbh->prepare($sql);
  		die 'Prepare failed' unless (defined($sth));
  		$sth->execute;
  		my (@row);
  		do {
    		  while (@row = $sth->fetchrow() ) {
		    if ($sth->{syb_result_type} == CS_ROW_RESULT) {
      		      my $rc = shift @row;
      		      print "ccID = $rc\n";
		    }
		    elsif ($sth->{syb_result_type} == CS_STATUS_RESULT) {
      		      my $s = shift @row;
      		      print "status = $s\n";
		    }
		    elsif ($sth->{syb_result_type} == CS_MSG_RESULT) {
      		      my $m = shift @row;
      		      print "msg = $m\n";
		    }
		    else {
      		      my $m = shift @row;
      		      print "other = $m\n";
		    }
    		  }
  		} while($sth->{syb_more_results});
  		$sth->finish;
	}
  }
  close IPN;
}
