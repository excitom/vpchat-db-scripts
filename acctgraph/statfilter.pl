#!/bin/perl -w
use strict;
use Data::Dumper;
use RRDs;

my $ifn = '/u/vplaces/VPCOM/VPS/stat';
die "Can't find $ifn\n" unless (-e $ifn);

my $ok = open(IFH, $ifn);
die "Can't read from $ifn - $!\n" unless ($ok);

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

print join(" ", @legend), "\n";
exit(0);

# get data
my $Rh_data = {};
while ($card = <IFH>) {
    chomp $card;
    my @pieces = split(/\t/, $card);
    my $ts = $pieces[0];
    my @dp = ($ts =~ m#(\d{4})(\d\d)(\d\d)\s+(\d\d):(\d\d):(\d\d)#o);
    my $tl = Mktime(@dp);
    foreach my $idx (1 .. $#pieces) {
        push @{$Rh_data->{$legend[$idx]}}, $pieces[$idx];
    }
}

my $dumper = Data::Dumper->new([$Rh_data], [qw(*Rh_data)]);
$dumper->Purity(1)->Terse(1);
print $dumper->Dump;
# __END__
