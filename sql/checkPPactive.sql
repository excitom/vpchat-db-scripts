select distinct count(vpplaces..persistentPlaces.URL),
vpusers..userAccounts.accountID
from vpplaces..persistentPlaces, vpusers..userAccounts, vpplaces..userPlaces
where vpplaces..persistentPlaces.URL in (
select vpplaces..persistentPlaces.URL 
from vpusers..userAccounts,vpplaces..userPlaces
where vpusers..userAccounts.accountID=vpplaces..userPlaces.accountID
and vpusers..userAccounts.accountStatus=0)
and vpusers..userAccounts.accountID=vpplaces..userPlaces.accountID
and vpplaces..userPlaces.URL=vpplaces..persistentPlaces.URL
group by vpusers..userAccounts.accountID
order by vpusers..userAccounts.accountID
go
