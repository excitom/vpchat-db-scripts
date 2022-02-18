#!/usr/bin/perl
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';
$cmd = "/tmp/ageRankings.sql";
open (TMP, ">$cmd");
print TMP "ageRankings\ngo\n";
close TMP;
open (SQL, "/u/vplaces/s/sybase/bin/isql -Uaudset -Paudset1 -SSYBASE -i $cmd |");
while (<SQL>) {
	####print;
}
close SQL;

$cmd = "/tmp/ageRankings.sql";
open (TMP, ">$cmd");
print TMP "updateLadderRankings\ngo\n";
close TMP;
open (SQL, "/u/vplaces/s/sybase/bin/isql -Uaudset -Paudset1 -SSYBASE -i $cmd |");
while (<SQL>) {
	####print;
}
close SQL;
unlink $cmd;
