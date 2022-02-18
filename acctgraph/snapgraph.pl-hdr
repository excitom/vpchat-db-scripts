#!/usr/local/bin/perl -w
# sed 's/[A-Z]://g' /u/vplaces/VPCOM/VPPLACES/snapshot.log.20020206 | snapgraph.pl

# VPlaces snapshot grapher

use Date::Calc qw(:all);
use File::Basename;
use GD::Graph::Data;
use GD::Graph::lines;
use Getopt::Long;

use strict;

use vars qw(
  $CODENAME
  $X_TAIL
  $X_CAT
);

($CODENAME = $0) =~ s#^(.*/)##g;
$X_TAIL = '/bin/tail';
$X_CAT  = '/bin/cat';

my $basedatadir = '/u/vplaces/VPCOM/VPPLACES';

my %fulllegend = (
    'Date' => 'Date',
    'T' => 'Total',
    'C' => 'Chat',
    'B' => 'Buddy',
    'R' => 'Registered',
    'G' => 'Guest',
    'D' => 'Download',
    'J' => 'Java',
    'E' => 'Ephemera',
);

my %option = ();
process_options(\%option);

$option{'output'} ||= '/tmp/snapshot.png';
$option{'minutes'} ||= 61;

# Possible options:
# input file name
## output file name
# start time
# end time
## columns
# legend (implied?)
# x label
# y label
# image height
# image width

my @legend = ();
my %hlegend = ();
my $data = GD::Graph::Data->new();

# Naive, externally-filtered data reader
if (0) {

    # get data
    # (externally filtered with sed)
    $data->read(file => "-", delimiter => "\t");
    @legend = qw(Date T C B R G D J E);
}

# Find snapshot files for today and yesterday
# (so we can show a 24 hour window)

my @today = Today();

my $today_stamp = sprintf("%04d%02d%02d", @today);
my $yest_stamp  = sprintf("%04d%02d%02d", Add_Delta_Days(@today, -1));

my $yfile       = $basedatadir . '/snapshot.log.' . $yest_stamp;
my $tfile       = $basedatadir . '/snapshot.log.' . $today_stamp;

my $ifn = "$X_CAT $yfile $tfile | $X_TAIL -" . int($option{'minutes'}) . " |";

# Less naive, internally-filtered data reader
# Legends are implied from first line, accomodating limited changes to
# file format.
my @nflegend = ();
if (1) {
    @legend = ("Date");
    my $ok = open(IFH, $ifn);
    if ($ok) {
        while (my $card = <IFH>) {
            chomp($card);
            next unless ($card);
            if (scalar(@legend) < 2) {
                my @z = ($card =~ m/\t(\S+):/g);
                push @legend, @z;
            }
            $card =~ s/\t\S+:/\t/og;
            my @pts = split ("\t", $card);

            #		if (date_between($start_time, $pts[0], $end_time)) {
            $data->add_point(@pts);

            #		}
        }
        close IFH;
        foreach my $zz (0 .. $#legend) {
#            print $legend[$zz], " ", $zz, "\n";
            $hlegend{$legend[$zz]} = $zz;
            push @nflegend, $fulllegend{$legend[$zz]};
        }
    } else {
        print "Error: Can't read from $ifn - $!\n";
    }
}

# Take first three columns as default
my @wanted = qw( 1 2 3 );
if (@ARGV) {
#    print join(" ", "Parameters:", @ARGV),"\n";
    my %hwanted = ();
    foreach my $par (@ARGV) {
        my $upar = uc($par);
        if (exists($hlegend{$upar})) {
#            print $upar, "\t", $hlegend{$upar}, "\n";
            $hwanted{$hlegend{$upar}} = 1;
#            $hwanted{$nflegend{$hlegend{$upar}}} = 1;
        }
    }
    @wanted = sort keys (%hwanted);
#    print join(" ", "keys:", @wanted),"\n";
}
# my @wlegend = @legend[@wanted];
my @wlegend = @nflegend[@wanted];
# print join(" ", "wlegend:", @wlegend),"\n";

$data->wanted(@wanted);

# Guesstimate a sane interval
my $interval = 60;
if ($option{'minutes'} < 180) {
    $interval = 10;
} elsif ($option{'minutes'} < 60) {
    $interval = 5;
} elsif ($option{'minutes'} < 30) {
    $interval = 2;
}

# Build chart
my $chart = GD::Graph::lines->new();
$chart->set(
    x_label           => "Time",
    y_label           => "Users",
    x_label_skip      => $interval,
    x_labels_vertical => 1,
);
$chart->set_legend(@wlegend);
# $chart->set_legend(@legend[0 .. $#legend]);

# Save plot
my $ofn = $option{'output'};
my $gd  = $chart->plot($data);
save_plot($ofn, $gd);

if ($option{'thumbnail'}) {
    my ($base, $path, $type) = fileparse($ofn, '\.png');
    my $otfn = join("", $path, $base, '.thumb', $type);
    my $tchart = GD::Graph::lines->new(100, 75);
    # there appears to be no graceful way of turning off
    # labels on axes. I just want the shape of the graph
    # and no $#@%! text. At all. Why is this so hard?
    $tchart->set_text_clr('white');
    $tchart->set(
        zero_axis_only    => 1,
        y_min_value       => 0,
        tick_length       => 0,
        x_ticks           => 0,
        y_ticks           => 0,
        x_label_format    => '',
        y_label_format    => '',
        x_label_skip      => 2882,
        y_label_skip      => 2882,
        x_tick_offset     => 2882,
        y_tick_offset     => 2882,
        y_tick_number     => 0,
    );
    save_plot($otfn, $tchart->plot($data));
}
#        x_tick_number     => 0,

exit(0);

###############
sub save_plot {
###############
    my $ofn = shift;
    my $gd = shift;

    my $err = -1;
    my $ok  = open(IMG, ">$ofn");
    if ($ok) {
        print IMG $gd->png();
        close(IMG);
        $err = 0;
    } else {
        print "Can't write to $ofn - $!\n";
        $err = 1;
    }
    return $err;
}

#####################
sub process_options {
#####################
    my ($Rh_opt) = @_;
    my $diag = '';

    ### set option types and arguments

    my @optlst = (
        'output=s',
        'minutes=i',
        'thumbnail',
        'help',
        'usage',
    );
#        'dead',
#        'verbose',

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

    # check that we have the right options set

    $Rh_opt->{'minutes'} ||= 61;
    if (($Rh_opt->{'minutes'} > 1) && ($Rh_opt->{'minutes'} <= 1441)) {

        # adjust to put labels nicely on x axis
        $Rh_opt->{'minutes'}++ if (($Rh_opt->{'minutes'} % 60) == 0);
    } else {
        my $msg =
          "Please specify 2-1441 minutes (current value = "
          . $Rh_opt->{'minutes'} . ")\n"
          . &show_usage();

        print STDERR $msg;
        exit(1);
    }

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
Usage: $CODENAME [options] [parameters]
    Legal parameters are [TCBRGDJE]. Default: T C B
    --output filename      Name of image file to create;
                           Default: /tmp/snapshot.png
    --minutes nnn          Number of minutes to plot
                           Default: 60
    --thumbnail            Make thumbnail image
                           Default: /tmp/snapshot.thumb.png
    --help                 Displays this message
    --usage                "        "    "
USAGE
#    --dead                 Don't change any files
#    --verbose              Show detailed info

    return $msg;
}

__END__
=pod

=head1 NAME
 
snapgraph.pl - creates images from snapshots logs
 
=head1 SYNOPSIS
 
 snapgraph.pl --output /tmp/snapshot.png
 
=head1 DESCRIPTION
 
C<snapgraph.pl> creates PNG images from VPlaces snapshot logs.
 
=head1 USAGE
 
 Usage: snapgraph.pl [options] [parameters]
     Legal parameters are [TCBRGDJE]. Default: T C B
     --output filename      Name of image file to create;
                            Default: /tmp/snapshot.png
     --minutes nnn          Number of minutes to plot
                            Default: 60
     --thumbnail            Make thumbnail image
                            Default: /tmp/snapshot.thumb.png
     --help                 Displays this message
     --usage                "        "    "
 
=head1 AUTHOR
 
Bob Apthorpe apthorpe@cynistar.net - 512/695-8051
 
=head1 COPYRIGHT
 
Copyright 2002 Halsoft, Inc. - All rights reserved.
 
=cut

