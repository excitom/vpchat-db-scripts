#!/usr/bin/perl

close STDIN;
close STDOUT;
$file = "/tmp/sql$$";
open (CMDS, ">$file") || die "Can't create $file : $!";
print CMDS <<SQL;
use vpusers
go
select 'UU',name from sysobjects where type='U'
go
use vpplaces
go
select 'PP',name from sysobjects where type='U'
go
use audset
go
select 'AA',name from sysobjects where type='U'
go
SQL
close CMDS;
open (OUT, "/u/vplaces/s/sybase/bin/isql -Usa -PUBIQUE -i $file |");
open (DBCC, ">/u/vplaces/scripts/sybscripts/dbcc_cmds.sql");
print DBCC <<SQL;
dbcc traceon(3604)
go 
               
use master
go 
                                                              
dbcc checkdb(audset,skip_ncindex)
dbcc checkdb(vpusers,skip_ncindex)
dbcc checkdb(vpplaces,skip_ncindex)
go                         
               
use vpusers
go 
SQL
while (<OUT>) {
  chomp;
  if (/AA/) {
    ($junk, $tbl) = split;
    push(@audset, $tbl);
  }
  elsif (/PP/) {
    ($junk, $tbl) = split;
    push(@vpplaces, $tbl);
  }
  elsif (/UU/) {
    ($junk, $tbl) = split;
    push(@vpusers, $tbl);
  }
}
open(UPD, ">updstats.sql");
print UPD "use vpusers\ngo\n";
foreach $tbl (@vpusers) {
  print DBCC "dbcc checktable($tbl, skip_ncindex)\ngo\n";
  print UPD "update statistics $tbl\ngo\n";
}
print DBCC "use vpplaces\ngo\n\n";
print UPD "use vpplaces\ngo\n";
foreach $tbl (@vpplaces) {
  print DBCC "dbcc checktable($tbl, skip_ncindex)\ngo\n";
  print UPD "update statistics $tbl\ngo\n";
}
print DBCC "use audset\ngo\n\n";
print UPD "use audset\ngo\n";
foreach $tbl (@audset) {
  print DBCC "dbcc checktable($tbl, skip_ncindex)\ngo\n";
  print UPD "update statistics $tbl\ngo\n";
}
close DBCC;
close UPD;

unlink $file;
