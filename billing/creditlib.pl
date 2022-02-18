#!/usr//bin/perl
#
# Common subroutines for credit card processing
#
# Tom Lang 1/97

###############
#
# Subroutine: perform Luhn Check Digit Algorithm to validate a 
#		credit card number
#
sub luhnCheck {
	my $ccnumber = $_[0];
	my (@ccn, $i, $sum);
	$ccnumber =~ s/[\s\-]+//g;	# remove delimiters, if any
	@ccn = split(//,$ccnumber);		# split into digits
	if ((($#ccn + 1) % 2) == 0) {	# even number of digits?

		# loop through odd numbered digits

		for ($i = 0, $sum = 0; $i <= $#ccn; $i += 2) {
			$ccn[$i] *= 2;		# double each odd digit
			$ccn[$i] -= 9 if ($ccn[$i] > 9);	# normalize
			$sum += ($ccn[$i] + $ccn[$i+1]);	# sum
		}
	} else {			# odd number of digits

		# loop through even numbered digits

		for ($i = 1, $sum = 0; $i <= $#ccn; $i += 2) {
			$ccn[$i] *= 2;		# double each even digit
			$ccn[$i] -= 9 if ($ccn[$i] > 9);	# normalize
			$sum += ($ccn[$i] + $ccn[$i-1]);	# sum
		}
		$sum += $ccn[$#ccn];	# add the last digit
	}
	return 0 if ($sum == 0);	# make sure digits were entered

	# return 1 if sum is a multiple of 10, else return 0

	return (($sum % 10) == 0);
}
1;

###############
#
# Subroutine: figure out credit card type based on number
#
sub getcctype {
	my $num = $_[0];
	$num =~ s/[^\d]//g;
	$num = substr($num,0,8);
	if      ($num >= 40000000 && $num <= 49999999) {
		return "Visa";
	} elsif ($num >= 50000000 && $num <= 59999999) {
		return "MasterCard";
	} elsif ($num >= 34000000 && $num <= 34999999) {
		return "AmEx";
	} elsif ($num >= 37000000 && $num <= 37999999) {
		return "AmEx";
	} elsif ($num >= 35280000 && $num <= 35899999) {
		return "JCB";
	} elsif ($num >= 30000000 && $num <= 38999999) {
		return "DinersClub";
	} elsif ($num >= 60110000 && $num <= 60119999) {
		return "Discover";
	} else {
		return "INVALID";
	}
}
1;
