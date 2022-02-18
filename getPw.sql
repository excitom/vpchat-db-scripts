SELECT vpusers..users.userID, vpusers..users.nickName,
  vpusers..registration.password, vpplaces..homePages.maxSpace
FROM vpusers..users, vpusers..registration, vpplaces..homePages
WHERE vpusers..users.locked=0
AND vpplaces..homePages.deleted=0
AND vpusers..users.userID=vpusers..registration.userID
AND vpusers..users.userID=vpplaces..homePages.userID
GO
