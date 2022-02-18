#!/usr/bin/perl
#
# Process IPN log from PayPal
#
# Tom Lang 12/2001
#
sub parse_input {

   my ($name, $value, @pairs, @values, $buffer);

   $buffer = $_[0];

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

#####################
#
# START HERE
#

while (<STDIN>) {
	($date, $verified, $data) = split(/\t/);
	@date = split(/\s/, $date);
	shift @date;
	$date = join(' ', @date);
	&parse_input($data);
	print :
	
}
