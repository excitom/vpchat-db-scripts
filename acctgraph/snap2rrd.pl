#!/usr/local/bin/perl -w
# sed 's/[A-Z]://g' /u/vplaces/VPCOM/VPPLACES/snapshot.log.20020206 | snapgraph.pl

use Date::Calc qw(:all);
use RRDs;
use Getopt::Long;

use strict;

use vars qw(
  $CODENAME
);

($CODENAME = $0) =~ s#^(.*/)##g;
my $basedatadir = '/u/vplaces/VPCOM/VPPLACES';
my $snapshotrrd = '/u/vplaces/healthmon/stats/snapshot.rrd';
my $lastupdate = RRDs::last($snapshotrrd);
$lastupdate += 0;

my %option = ();
process_options(\%option);

my $today_stamp = sprintf("%04d%02d%02d", Today());
my $tfile       = $basedatadir . '/snapshot.log.' . $today_stamp;

# Less naive, internally-filtered data reader
my @flist = ();
if (@ARGV) {
    my %tfn = ();
    foreach my $fn (@ARGV) {
        $tfn{$fn} = 1 if (-e $fn);
    }
    push @flist, sort keys %tfn;
} else {
    push @flist, $tfile if (-e $tfile);
}

foreach my $ifn (@flist) {
    my $ctr = 0;
    my $ok = open(IFH, $ifn);
    if ($ok) {
        readloop:
        while (my $card = <IFH>) {
            # skip over assumed read records
            $ctr-- if ($ctr);
            next readloop if ($ctr > 0);

            chomp($card);
            next readloop unless ($card);
            $card =~ s/\t\S+:/\t/og;
            my @pieces = split ("\t", $card);

            # convert timestamp
            my $ts = $pieces[0];
            my @dp = ($ts =~ m#(\d{4})(\d\d)(\d\d)\s+(\d\d):(\d\d)#o);
            $dp[5] = 0;
            $pieces[0] = Mktime(@dp);

            # clean spaces out of input
            foreach my $piece (@pieces) {
                $piece = int($piece);
            }

            # add pieces if not already in rrd (check against RRDs::last)
            if ($pieces[0] > $lastupdate) {
                my $incard = join(':', @pieces);
                print $incard, "\n" if ($option{'verbose'});
                # shove into existing RRD
                unless ($option{'dead'}) {
                    RRDs::update($snapshotrrd, $incard);
                    my $ERR = RRDs::error;
                    print STDERR "ERROR while updating $snapshotrrd with [$incard]: $ERR\n" if ($ERR && $option{'verbose'});
                }
            } elsif (($pieces[0] > 0) && ($ctr == 0)) {
                my $fudge = 2; # something >= 1; 2 means check in halfway
                $ctr = int(($lastupdate - $pieces[0]) / ($fudge * 60));
                print scalar(localtime($lastupdate)), " ", scalar(localtime($pieces[0])), " ", int(($lastupdate - $pieces[0]) / 60), "\n" if ($option{'verbose'});
#                if ($ctr > 100) {
#                    $ctr -=20;
#                } elsif ($ctr < 20) {
#                    $ctr = 0;
#                }
    
                if ($ctr < 5) {
                    $ctr = 0;
                }
                print "Skipping $ctr records (from $ts)...\n" if (($ctr) && ($option{'verbose'}));
            }
        }
        close IFH;
    } else {
        print "Error: Can't read from $ifn - $!\n";
    }
}

exit(0);

#####################
sub process_options {
#####################
    my ($Rh_opt) = @_;
    my $diag = '';

    ### set option types and arguments

    my @optlst = (
        'verbose',
        'dead',
        'help',
        'usage',
    );

    ### map options to variables

    my $kk;
    foreach $kk (@optlst) {
        my ($nkk, $junk) = split (/[=!]/, $kk, 2);
        if ($nkk) {
            if ($junk && $junk =~ m#@#o) {
                $Rh_opt->{$nkk} = [];
            } else {
                $Rh_opt->{$nkk} = '';
            }
        }

    }

    GetOptions($Rh_opt, @optlst);

    ### print usage, version, or ownership messages.

    if ($Rh_opt->{'help'} || $Rh_opt->{'usage'}) {
        my $msg = '';

        if ($Rh_opt->{'help'} || $Rh_opt->{'usage'}) {
            $msg .= &show_usage();
        }

        print STDERR $msg;
        exit(0);
    }

    return;

}

################
sub show_usage {
################
    my $msg;
    $msg .= <<"USAGE";
Usage: $CODENAME [options] file1, file2, ..., fileN
    --verbose              Show detailed info
    --dead                 Don't change any files
    --help                 Displays this message
    --usage                "        "    "
USAGE

    return $msg;
}

__END__
=pod

=head1 NAME
 
snap2rrd.pl - puts snapshot data into existing RRDTool database
 
=head1 SYNOPSIS
 
 snap2rrd.pl 
 
=head1 DESCRIPTION
 
C<snap2rrd.pl> reads VPlaces snapshot logs, massages the data, and puts
it in an RRDTool database.
 
=head1 USAGE
 
 Usage: snap2rrd.pl [options] file1, file2, ..., fileN
     --verbose              Show detailed info
     --dead                 Don't change any files
     --help                 Displays this message
     --usage                "        "    "
 
=head1 AUTHOR
 
Bob Apthorpe apthorpe@cynistar.net - 512/695-8051
 
=head1 COPYRIGHT
 
Copyright 2002 Halsoft, Inc. - All rights reserved.
 
=cut

