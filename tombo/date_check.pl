
#!/usr/bin/perl
use Date::Manip;


###############
#
# START HERE
#

if ($#ARGV == -1) {
  $d = &ParseDate('today');
} else {
  $d = &ParseDate($ARGV[0]);
}
($now, $date, $sqlDate, $logDate) = &UnixDate( $d, '%Y%m%d %H:%M:%S', '%b %m, %Y', '%m/%d/%Y 00:00am', '%Y%m%d');

print "d = $d\n";
print "now = $now\n";
print "date = $date\n";
print "sqlDate = $sqlDate\n";
print "logDate = $logDate\n";
$nickName = "AB+C";
if ( $nickName !~ /^[A-Za-z0-9_.-]+/ ){
print "bad nickname";
}


