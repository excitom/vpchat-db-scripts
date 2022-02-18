select a.accountID, a.ownerID, n.notifyID, n.userID
from vpusers..userAccounts a, audset..notifyAccessList n
where a.accountID = n.accountID
and a.ownerID != n.userID
go
