
#!/usr/bin/perl


###############
#
# START HERE
#

$nickName = "ABC";
$nickName =~ /[^A-Za-z0-9_.-]/; 
print "$nickName\n";
if ( $nickName =~ /[^A-Za-z0-9_.-]/ ){
print "found illegal char\n";
}
print "$nickName\n";
if ( $nickName !~ /^[A-Za-z0-9_.-]+$/ ){
print "bad nickname\n";
}else{
print "good nickname\n";
}


$line = 'tombo:x:2003:1:Tom Brinson:/u/tombo:/usr/local/bin/bash';
$line =~ /[^:]+:[^:]+:[^:]+:[^:]:([^:]+):/;
print $1; 
