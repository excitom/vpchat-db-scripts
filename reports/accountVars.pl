#!/usr/bin/perl
# This is a generated file, do not edit.
# Updated: Wed Sep 24 15:18:37 2003

%accountType = (
	0 => 'Complimentary',
	1 => 'Basic',
	2 => 'Family',
	3 => 'Sybil',
	4 => 'Group'
);
$maxAccountType = 4;
%accountStatus = (
	0 => 'OK',
	1 => 'New',
	2 => 'Pending',
	3 => 'Closed',
	4 => 'Suspended',
	5 => 'Expired'
);
$maxAccountStatus = 5;
%paymentStatus = (
	0 => 'OK',
	1 => 'Unconfirmed',
	2 => 'Failed',
	3 => 'Waiting',
	4 => 'Pending eCheck',
	5 => 'Free Trial'
);
$maxPaymentStatus = 5;
%billingCycle = (
	0 => 0,
	1 => 1,
	2 => 3,
	3 => 6,
	4 => 12
);
%revBillingCycle = (
	0 => 0,
	1 => 1,
	3 => 2,
	6 => 3,
	12 => 4
);
$maxBillingCycle = 4;
%enrolledReferrer = (
	0 => 'No',
	1 => 'Yes'
);
%nameLimit = (
	1 => 2,
	2 => 5,
	3 => 10
);
%unitCost = (
	1 => 10.00,
	2 => 12.00,
	3 => 15.00
);
%discount = (
	1 => 0,
	2 => .1,
	3 => .25,
	4 => (1/3)
);
%promo = (
	0 => 0,
	1 => 1,
	2 => 2,
	3 => 3,
	4 => 4
);
%subscrTypes = (
	0 => 'None',
	1 => 'PayPal',
	2 => 'Credit Card',
	3 => 'eCheck'
);
%webPageDefaults = (
	'space' => 10,
	'xfer'  => 2048
);

$guestPeriod = 14;
$clientBuild = 172;
$pmtStat_pending = 0;
$pmtStat_OK = 1;
$pmtStat_rejected = 2;

1;
