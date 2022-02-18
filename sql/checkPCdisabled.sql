select distinct count(vpplaces..placeCategories.URL),
vpusers..userAccounts.accountID
from vpplaces..placeCategories, vpusers..userAccounts, vpplaces..userPlaces
where vpplaces..placeCategories.URL in (
select vpplaces..placeCategories.URL 
from vpusers..userAccounts,vpplaces..userPlaces
where vpusers..userAccounts.accountID=vpplaces..userPlaces.accountID
and vpusers..userAccounts.accountStatus>0)
and vpusers..userAccounts.accountID=vpplaces..userPlaces.accountID
and vpplaces..userPlaces.URL=vpplaces..placeCategories.URL
group by vpusers..userAccounts.accountID
order by vpusers..userAccounts.accountID
go
