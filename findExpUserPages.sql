select vpusers..userAccounts.accountID,vpplaces..persistentPlaces.URL
from vpplaces..persistentPlaces,
vpusers..userAccounts, vpplaces..userPlaces
where accountStatus !=0
and vpusers..userAccounts.accountID=vpplaces..userPlaces.accountID
and vpplaces..userPlaces.URL=vpplaces..persistentPlaces.URL
go
