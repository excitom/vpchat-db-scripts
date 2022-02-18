#!/usr/bin/perl
#
# Tom Lang 4/2004
#
# Update web stats in the Sybase database on behalf of a 
# web server that does not have access to Sybase directly.
#
# There are two scripts that run on the web server which produce 
# input for this script.
# - Scan for web hits, page views, and bytes transferred
# - Scan for files added/removed/changed
#

$dbName = 'vpplaces';
$dbPw = 'vpplaces';
$G_isql_exe = "/u/vplaces/s/sybase/bin/isql -U$dbName -P$dbPw -SSYBASE";
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

$srvr = 'nike';
open (LS, "/usr/local/bin/ssh $srvr 'ls -1 /logs/cmds/webStats.sql.* /logs/cmds/spaceUsage.sql.*' 2>/dev/null |") || die "Can't get to $srvr";
@files = <LS>;
close LS;

if ($#files > -1) {
  open (LOG, ">>/logs/webStats.log");
  $now = scalar localtime(time);
  print LOG "$now\n";
  $sqlIn = '/tmp/temp.sql';
  open (SQL_IN, ">$sqlIn");
  foreach $file (@files) {
	chomp $file;
	`/usr/local/bin/scp $srvr:$file $file`;
	if (-f $file) {
		open(INPUT, $file);
		while (<INPUT>) {
			print LOG;
			print SQL_IN;
		}
  		close INPUT;
		unlink $file;
		`/usr/local/bin/ssh $srvr 'rm $file'`;
	}
	else {
		print "Problem with $srvr:$file\n";
	}
  }
  close SQL_IN;
    
  open (SQL_OUT, "$G_isql_exe -i $sqlIn |") || die "Can't read from $sqlIn : $!";
  while (<SQL_OUT>) {
    print LOG;
    if (/return status = 20001/) {
	print "problem with updating home page stats\n";
    }
  }
  close SQL_OUT;
  close LOG;
  unlink $sqlIn;
}
