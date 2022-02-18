#!/usr/bin/perl
#
# Report on daily account creation/cancellation activity
#
# Tom Lang 3/2002
#


SELECT CONVERT(CHAR(20),creationDate, 102), COUNT(accountID)
FROM userAccounts
WHERE accountType >0
AND (accountStatus=0 OR accountStatus=2)
AND paymentStatus=0
GROUP BY CONVERT(CHAR(20),creationDate, 102)
ORDER BY  CONVERT(CHAR(20),creationDate, 102) DESC

SELECT COUNT(accountID) FROM subscriptions WHERE autoRenew=1
