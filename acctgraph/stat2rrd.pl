#!/bin/perl -w
use strict;
use Date::Calc qw(:all);
use RRDs;

use vars qw(
%option
);
$option{'verbose'} = 0;

my $ifn = '/u/vplaces/VPCOM/VPS/stat';
die "Can't find $ifn\n" unless (-e $ifn);

my $ok = open(IFH, $ifn);
die "Can't read from $ifn - $!\n" unless ($ok);

my $statrrd = '/u/vplaces/healthmon/stats/stat.rrd';
my $lastupdate = RRDs::last($statrrd);

# get legend
my $card = <IFH>;
chomp $card;
my @legend = split(/\t/, $card);
foreach my $lgd (@legend) {
    $lgd =~ s/^\s+//o;
    $lgd =~ s/\s+$//o;
    $lgd =~ s/\s+/_/go;
    $lgd =~ s/>=/ge/o;
}

# print join(" ", @legend), "\n";
# exit(0);

my $ctr = 0;
# get data
readloop:
while (defined($card = <IFH>)) {
    # skip over assumed read records
    $ctr-- if ($ctr);
    next readloop if ($ctr > 0);

    chomp $card;
    my @pieces = split(/\t/, $card);
    # convert timestamp
    my $ts = $pieces[0];
    my @dp = ($ts =~ m#(\d{4})(\d\d)(\d\d)\s+(\d\d):(\d\d):(\d\d)#o);
    $pieces[0] = Mktime(@dp);

    # add pieces if not already in rrd (check against RRDs::last)
    if ($pieces[0] > $lastupdate) {
        # clean spaces out of input
        foreach my $piece (@pieces) {
            $piece = int($piece);
        }
        my $incard = join(':', @pieces);
        print $incard, "\n" if ($option{'verbose'});
        # shove into existing RRD
        RRDs::update($statrrd, $incard);
        my $ERR = RRDs::error;
        print STDERR "ERROR while updating $statrrd with [$incard]: $ERR\n" if $ERR;
    } elsif (($pieces[0] > 0) && ($ctr == 0)) {
        my $fudge = 2; # something >= 1; 2 means check in halfway
        $ctr = int(($lastupdate - $pieces[0]) / ($fudge * 60));
print scalar(localtime($lastupdate)), " ", scalar(localtime($pieces[0])), " ", int(($lastupdate - $pieces[0]) / 60), "\n" if ($option{'verbose'});
#        if ($ctr > 100) {
#            $ctr -=20;
#        } elsif ($ctr < 20) {
#            $ctr = 0;
#        }

        if ($ctr < 5) {
            $ctr = 0;
        }
        print "Skipping $ctr records (from $ts)...\n" if (($ctr) && ($option{'verbose'}));
    }
}
close IFH;

# __END__
