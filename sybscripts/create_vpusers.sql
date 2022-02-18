--------------------------------------------------------------------------------
-- DBArtisan Schema Extraction
-- TARGET DB:
-- 	vpusers
--------------------------------------------------------------------------------

--
-- Target Database: vpusers
--

USE vpusers
go

--
-- DROP INDEXES
--
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.configurationKeys') AND name='configurationIdx')
BEGIN
    DROP INDEX configurationKeys.configurationIdx
    IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.configurationKeys') AND name='configurationIdx')
        PRINT '<<< FAILED DROPPING INDEX configurationKeys.configurationIdx >>>'
    ELSE
        PRINT '<<< DROPPED INDEX configurationKeys.configurationIdx >>>'
END
go

IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.penalties') AND name='expiryTimeIdx')
BEGIN
    DROP INDEX penalties.expiryTimeIdx
    IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.penalties') AND name='expiryTimeIdx')
        PRINT '<<< FAILED DROPPING INDEX penalties.expiryTimeIdx >>>'
    ELSE
        PRINT '<<< DROPPED INDEX penalties.expiryTimeIdx >>>'
END
go

IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.penalties') AND name='userIdx')
BEGIN
    DROP INDEX penalties.userIdx
    IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.penalties') AND name='userIdx')
        PRINT '<<< FAILED DROPPING INDEX penalties.userIdx >>>'
    ELSE
        PRINT '<<< DROPPED INDEX penalties.userIdx >>>'
END
go

IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.registration') AND name='registrationByEmailIdx')
BEGIN
    DROP INDEX registration.registrationByEmailIdx
    IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.registration') AND name='registrationByEmailIdx')
        PRINT '<<< FAILED DROPPING INDEX registration.registrationByEmailIdx >>>'
    ELSE
        PRINT '<<< DROPPED INDEX registration.registrationByEmailIdx >>>'
END
go

IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.registration') AND name='registrationByDateIdx')
BEGIN
    DROP INDEX registration.registrationByDateIdx
    IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.registration') AND name='registrationByDateIdx')
        PRINT '<<< FAILED DROPPING INDEX registration.registrationByDateIdx >>>'
    ELSE
        PRINT '<<< DROPPED INDEX registration.registrationByDateIdx >>>'
END
go

IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.userDetails') AND name='userDetailsByNameIdx')
BEGIN
    DROP INDEX userDetails.userDetailsByNameIdx
    IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.userDetails') AND name='userDetailsByNameIdx')
        PRINT '<<< FAILED DROPPING INDEX userDetails.userDetailsByNameIdx >>>'
    ELSE
        PRINT '<<< DROPPED INDEX userDetails.userDetailsByNameIdx >>>'
END
go

IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.userPrivileges') AND name='privilegeByUserIdx')
BEGIN
    DROP INDEX userPrivileges.privilegeByUserIdx
    IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.userPrivileges') AND name='privilegeByUserIdx')
        PRINT '<<< FAILED DROPPING INDEX userPrivileges.privilegeByUserIdx >>>'
    ELSE
        PRINT '<<< DROPPED INDEX userPrivileges.privilegeByUserIdx >>>'
END
go

IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.users') AND name='usersByNickNameIdx')
BEGIN
    DROP INDEX users.usersByNickNameIdx
    IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.users') AND name='usersByNickNameIdx')
        PRINT '<<< FAILED DROPPING INDEX users.usersByNickNameIdx >>>'
    ELSE
        PRINT '<<< DROPPED INDEX users.usersByNickNameIdx >>>'
END
go

IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.warnings') AND name='issueTimeIdx')
BEGIN
    DROP INDEX warnings.issueTimeIdx
    IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.warnings') AND name='issueTimeIdx')
        PRINT '<<< FAILED DROPPING INDEX warnings.issueTimeIdx >>>'
    ELSE
        PRINT '<<< DROPPED INDEX warnings.issueTimeIdx >>>'
END
go

IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.warnings') AND name='userIdx')
BEGIN
    DROP INDEX warnings.userIdx
    IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.warnings') AND name='userIdx')
        PRINT '<<< FAILED DROPPING INDEX warnings.userIdx >>>'
    ELSE
        PRINT '<<< DROPPED INDEX warnings.userIdx >>>'
END
go


--
-- DROP PROCEDURES
--
IF OBJECT_ID('dbo.SetPassword') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.SetPassword
    IF OBJECT_ID('dbo.SetPassword') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.SetPassword >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.SetPassword >>>'
END
go

IF OBJECT_ID('dbo.ShowBannedNames') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.ShowBannedNames
    IF OBJECT_ID('dbo.ShowBannedNames') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.ShowBannedNames >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.ShowBannedNames >>>'
END
go

IF OBJECT_ID('dbo.VpExtGetUserCategory') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.VpExtGetUserCategory
    IF OBJECT_ID('dbo.VpExtGetUserCategory') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.VpExtGetUserCategory >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.VpExtGetUserCategory >>>'
END
go

IF OBJECT_ID('dbo.addBannedName') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.addBannedName
    IF OBJECT_ID('dbo.addBannedName') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.addBannedName >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.addBannedName >>>'
END
go

IF OBJECT_ID('dbo.addBoolConfigKey') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.addBoolConfigKey
    IF OBJECT_ID('dbo.addBoolConfigKey') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.addBoolConfigKey >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.addBoolConfigKey >>>'
END
go

IF OBJECT_ID('dbo.addConfigKey') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.addConfigKey
    IF OBJECT_ID('dbo.addConfigKey') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.addConfigKey >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.addConfigKey >>>'
END
go

IF OBJECT_ID('dbo.addNumConfigKey') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.addNumConfigKey
    IF OBJECT_ID('dbo.addNumConfigKey') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.addNumConfigKey >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.addNumConfigKey >>>'
END
go

IF OBJECT_ID('dbo.addPenaltyToUser') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.addPenaltyToUser
    IF OBJECT_ID('dbo.addPenaltyToUser') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.addPenaltyToUser >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.addPenaltyToUser >>>'
END
go

IF OBJECT_ID('dbo.addPrivilege') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.addPrivilege
    IF OBJECT_ID('dbo.addPrivilege') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.addPrivilege >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.addPrivilege >>>'
END
go

IF OBJECT_ID('dbo.addPrivilegeDomain') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.addPrivilegeDomain
    IF OBJECT_ID('dbo.addPrivilegeDomain') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.addPrivilegeDomain >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.addPrivilegeDomain >>>'
END
go

IF OBJECT_ID('dbo.addStrConfigKey') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.addStrConfigKey
    IF OBJECT_ID('dbo.addStrConfigKey') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.addStrConfigKey >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.addStrConfigKey >>>'
END
go

IF OBJECT_ID('dbo.addWarning') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.addWarning
    IF OBJECT_ID('dbo.addWarning') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.addWarning >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.addWarning >>>'
END
go

IF OBJECT_ID('dbo.archivePenalties') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.archivePenalties
    IF OBJECT_ID('dbo.archivePenalties') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.archivePenalties >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.archivePenalties >>>'
END
go

IF OBJECT_ID('dbo.autobackup') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.autobackup
    IF OBJECT_ID('dbo.autobackup') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.autobackup >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.autobackup >>>'
END
go

IF OBJECT_ID('dbo.changeEmail') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.changeEmail
    IF OBJECT_ID('dbo.changeEmail') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.changeEmail >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.changeEmail >>>'
END
go

IF OBJECT_ID('dbo.changePassword') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.changePassword
    IF OBJECT_ID('dbo.changePassword') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.changePassword >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.changePassword >>>'
END
go

IF OBJECT_ID('dbo.checkAuxUser') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.checkAuxUser
    IF OBJECT_ID('dbo.checkAuxUser') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.checkAuxUser >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.checkAuxUser >>>'
END
go

IF OBJECT_ID('dbo.checkCharactersMatch') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.checkCharactersMatch
    IF OBJECT_ID('dbo.checkCharactersMatch') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.checkCharactersMatch >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.checkCharactersMatch >>>'
END
go

IF OBJECT_ID('dbo.checkUser') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.checkUser
    IF OBJECT_ID('dbo.checkUser') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.checkUser >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.checkUser >>>'
END
go

IF OBJECT_ID('dbo.checkUserRegistration') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.checkUserRegistration
    IF OBJECT_ID('dbo.checkUserRegistration') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.checkUserRegistration >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.checkUserRegistration >>>'
END
go

IF OBJECT_ID('dbo.cleanUsers') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.cleanUsers
    IF OBJECT_ID('dbo.cleanUsers') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.cleanUsers >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.cleanUsers >>>'
END
go

IF OBJECT_ID('dbo.clearPenalties') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.clearPenalties
    IF OBJECT_ID('dbo.clearPenalties') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.clearPenalties >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.clearPenalties >>>'
END
go

IF OBJECT_ID('dbo.clearPrivileges') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.clearPrivileges
    IF OBJECT_ID('dbo.clearPrivileges') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.clearPrivileges >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.clearPrivileges >>>'
END
go

IF OBJECT_ID('dbo.clearRegistration') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.clearRegistration
    IF OBJECT_ID('dbo.clearRegistration') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.clearRegistration >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.clearRegistration >>>'
END
go

IF OBJECT_ID('dbo.delBannedName') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.delBannedName
    IF OBJECT_ID('dbo.delBannedName') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.delBannedName >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.delBannedName >>>'
END
go

IF OBJECT_ID('dbo.delPrivilege') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.delPrivilege
    IF OBJECT_ID('dbo.delPrivilege') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.delPrivilege >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.delPrivilege >>>'
END
go

IF OBJECT_ID('dbo.delPrivilegeDomain') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.delPrivilegeDomain
    IF OBJECT_ID('dbo.delPrivilegeDomain') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.delPrivilegeDomain >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.delPrivilegeDomain >>>'
END
go

IF OBJECT_ID('dbo.delPrivilegeDomainByName') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.delPrivilegeDomainByName
    IF OBJECT_ID('dbo.delPrivilegeDomainByName') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.delPrivilegeDomainByName >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.delPrivilegeDomainByName >>>'
END
go

IF OBJECT_ID('dbo.deleteUser') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.deleteUser
    IF OBJECT_ID('dbo.deleteUser') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.deleteUser >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.deleteUser >>>'
END
go

IF OBJECT_ID('dbo.emailIsRegistered') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.emailIsRegistered
    IF OBJECT_ID('dbo.emailIsRegistered') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.emailIsRegistered >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.emailIsRegistered >>>'
END
go

IF OBJECT_ID('dbo.findPasswordsForEmail') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.findPasswordsForEmail
    IF OBJECT_ID('dbo.findPasswordsForEmail') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.findPasswordsForEmail >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.findPasswordsForEmail >>>'
END
go

IF OBJECT_ID('dbo.findUserPermissions') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.findUserPermissions
    IF OBJECT_ID('dbo.findUserPermissions') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.findUserPermissions >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.findUserPermissions >>>'
END
go

IF OBJECT_ID('dbo.forgivePenalty') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.forgivePenalty
    IF OBJECT_ID('dbo.forgivePenalty') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.forgivePenalty >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.forgivePenalty >>>'
END
go

IF OBJECT_ID('dbo.getConfigKey') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getConfigKey
    IF OBJECT_ID('dbo.getConfigKey') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getConfigKey >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getConfigKey >>>'
END
go

IF OBJECT_ID('dbo.getConfiguration') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getConfiguration
    IF OBJECT_ID('dbo.getConfiguration') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getConfiguration >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getConfiguration >>>'
END
go

IF OBJECT_ID('dbo.getPrivilegeDomains') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getPrivilegeDomains
    IF OBJECT_ID('dbo.getPrivilegeDomains') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getPrivilegeDomains >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getPrivilegeDomains >>>'
END
go

IF OBJECT_ID('dbo.getPrivilegeDomainsByName') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getPrivilegeDomainsByName
    IF OBJECT_ID('dbo.getPrivilegeDomainsByName') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getPrivilegeDomainsByName >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getPrivilegeDomainsByName >>>'
END
go

IF OBJECT_ID('dbo.getRegisteredUserInfo') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getRegisteredUserInfo
    IF OBJECT_ID('dbo.getRegisteredUserInfo') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getRegisteredUserInfo >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getRegisteredUserInfo >>>'
END
go

IF OBJECT_ID('dbo.getUserDetails') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getUserDetails
    IF OBJECT_ID('dbo.getUserDetails') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getUserDetails >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getUserDetails >>>'
END
go

IF OBJECT_ID('dbo.getUserID') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getUserID
    IF OBJECT_ID('dbo.getUserID') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getUserID >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getUserID >>>'
END
go

IF OBJECT_ID('dbo.getUserIdByEmail') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getUserIdByEmail
    IF OBJECT_ID('dbo.getUserIdByEmail') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getUserIdByEmail >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getUserIdByEmail >>>'
END
go

IF OBJECT_ID('dbo.isPrivileged') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.isPrivileged
    IF OBJECT_ID('dbo.isPrivileged') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.isPrivileged >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.isPrivileged >>>'
END
go

IF OBJECT_ID('dbo.isRegistered') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.isRegistered
    IF OBJECT_ID('dbo.isRegistered') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.isRegistered >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.isRegistered >>>'
END
go

IF OBJECT_ID('dbo.penalize') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.penalize
    IF OBJECT_ID('dbo.penalize') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.penalize >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.penalize >>>'
END
go

IF OBJECT_ID('dbo.penaltyDetails') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.penaltyDetails
    IF OBJECT_ID('dbo.penaltyDetails') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.penaltyDetails >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.penaltyDetails >>>'
END
go

IF OBJECT_ID('dbo.periodicCheck') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.periodicCheck
    IF OBJECT_ID('dbo.periodicCheck') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.periodicCheck >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.periodicCheck >>>'
END
go

IF OBJECT_ID('dbo.refreshPasswords') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.refreshPasswords
    IF OBJECT_ID('dbo.refreshPasswords') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.refreshPasswords >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.refreshPasswords >>>'
END
go

IF OBJECT_ID('dbo.refreshPenalties') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.refreshPenalties
    IF OBJECT_ID('dbo.refreshPenalties') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.refreshPenalties >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.refreshPenalties >>>'
END
go

IF OBJECT_ID('dbo.registerNewService') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.registerNewService
    IF OBJECT_ID('dbo.registerNewService') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.registerNewService >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.registerNewService >>>'
END
go

IF OBJECT_ID('dbo.registerNewUser') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.registerNewUser
    IF OBJECT_ID('dbo.registerNewUser') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.registerNewUser >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.registerNewUser >>>'
END
go

IF OBJECT_ID('dbo.removeDeletedUsers') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.removeDeletedUsers
    IF OBJECT_ID('dbo.removeDeletedUsers') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.removeDeletedUsers >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.removeDeletedUsers >>>'
END
go

IF OBJECT_ID('dbo.renameBannedName') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.renameBannedName
    IF OBJECT_ID('dbo.renameBannedName') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.renameBannedName >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.renameBannedName >>>'
END
go

IF OBJECT_ID('dbo.setConfigKey') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.setConfigKey
    IF OBJECT_ID('dbo.setConfigKey') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.setConfigKey >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.setConfigKey >>>'
END
go

IF OBJECT_ID('dbo.setUserDetails') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.setUserDetails
    IF OBJECT_ID('dbo.setUserDetails') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.setUserDetails >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.setUserDetails >>>'
END
go

IF OBJECT_ID('dbo.showAllUsers') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.showAllUsers
    IF OBJECT_ID('dbo.showAllUsers') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.showAllUsers >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.showAllUsers >>>'
END
go

IF OBJECT_ID('dbo.showBannedAndFiltered') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.showBannedAndFiltered
    IF OBJECT_ID('dbo.showBannedAndFiltered') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.showBannedAndFiltered >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.showBannedAndFiltered >>>'
END
go

IF OBJECT_ID('dbo.showFilteredWords') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.showFilteredWords
    IF OBJECT_ID('dbo.showFilteredWords') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.showFilteredWords >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.showFilteredWords >>>'
END
go

IF OBJECT_ID('dbo.showHosts') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.showHosts
    IF OBJECT_ID('dbo.showHosts') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.showHosts >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.showHosts >>>'
END
go

IF OBJECT_ID('dbo.showNicknamesForEmail') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.showNicknamesForEmail
    IF OBJECT_ID('dbo.showNicknamesForEmail') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.showNicknamesForEmail >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.showNicknamesForEmail >>>'
END
go

IF OBJECT_ID('dbo.showPenalties') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.showPenalties
    IF OBJECT_ID('dbo.showPenalties') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.showPenalties >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.showPenalties >>>'
END
go

IF OBJECT_ID('dbo.showPenaltiesOnDate') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.showPenaltiesOnDate
    IF OBJECT_ID('dbo.showPenaltiesOnDate') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.showPenaltiesOnDate >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.showPenaltiesOnDate >>>'
END
go

IF OBJECT_ID('dbo.showPrivileges') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.showPrivileges
    IF OBJECT_ID('dbo.showPrivileges') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.showPrivileges >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.showPrivileges >>>'
END
go

IF OBJECT_ID('dbo.showUsersByMatchingEmail') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.showUsersByMatchingEmail
    IF OBJECT_ID('dbo.showUsersByMatchingEmail') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.showUsersByMatchingEmail >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.showUsersByMatchingEmail >>>'
END
go

IF OBJECT_ID('dbo.showUsersByPrefix') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.showUsersByPrefix
    IF OBJECT_ID('dbo.showUsersByPrefix') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.showUsersByPrefix >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.showUsersByPrefix >>>'
END
go

IF OBJECT_ID('dbo.showUsersByRegexp') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.showUsersByRegexp
    IF OBJECT_ID('dbo.showUsersByRegexp') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.showUsersByRegexp >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.showUsersByRegexp >>>'
END
go

IF OBJECT_ID('dbo.showWarnings') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.showWarnings
    IF OBJECT_ID('dbo.showWarnings') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.showWarnings >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.showWarnings >>>'
END
go

IF OBJECT_ID('dbo.updateBannedName') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.updateBannedName
    IF OBJECT_ID('dbo.updateBannedName') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.updateBannedName >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.updateBannedName >>>'
END
go

IF OBJECT_ID('dbo.updatePrivilegeDomain') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.updatePrivilegeDomain
    IF OBJECT_ID('dbo.updatePrivilegeDomain') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.updatePrivilegeDomain >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.updatePrivilegeDomain >>>'
END
go

IF OBJECT_ID('dbo.updatePrivileges') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.updatePrivileges
    IF OBJECT_ID('dbo.updatePrivileges') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.updatePrivileges >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.updatePrivileges >>>'
END
go

IF OBJECT_ID('dbo.updateUser') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.updateUser
    IF OBJECT_ID('dbo.updateUser') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.updateUser >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.updateUser >>>'
END
go

IF OBJECT_ID('dbo.warningDetails') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.warningDetails
    IF OBJECT_ID('dbo.warningDetails') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.warningDetails >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.warningDetails >>>'
END
go


--
-- DROP TRIGGERS
--
IF OBJECT_ID('delUserData') IS NOT NULL
BEGIN
    DROP TRIGGER delUserData
    IF OBJECT_ID('delUserData') IS NOT NULL
        PRINT '<<< FAILED DROPPING TRIGGER delUserData >>>'
    ELSE
        PRINT '<<< DROPPED TRIGGER delUserData >>>'
END
go


--
-- DROP VIEWS
--
IF OBJECT_ID('dbo.getGMT') IS NOT NULL
BEGIN
    DROP VIEW dbo.getGMT
    IF OBJECT_ID('dbo.getGMT') IS NOT NULL
        PRINT '<<< FAILED DROPPING VIEW dbo.getGMT >>>'
    ELSE
        PRINT '<<< DROPPED VIEW dbo.getGMT >>>'
END
go

IF OBJECT_ID('dbo.historyWithNames') IS NOT NULL
BEGIN
    DROP VIEW dbo.historyWithNames
    IF OBJECT_ID('dbo.historyWithNames') IS NOT NULL
        PRINT '<<< FAILED DROPPING VIEW dbo.historyWithNames >>>'
    ELSE
        PRINT '<<< DROPPED VIEW dbo.historyWithNames >>>'
END
go

IF OBJECT_ID('dbo.hosts') IS NOT NULL
BEGIN
    DROP VIEW dbo.hosts
    IF OBJECT_ID('dbo.hosts') IS NOT NULL
        PRINT '<<< FAILED DROPPING VIEW dbo.hosts >>>'
    ELSE
        PRINT '<<< DROPPED VIEW dbo.hosts >>>'
END
go

IF OBJECT_ID('dbo.penaltiesWithNames') IS NOT NULL
BEGIN
    DROP VIEW dbo.penaltiesWithNames
    IF OBJECT_ID('dbo.penaltiesWithNames') IS NOT NULL
        PRINT '<<< FAILED DROPPING VIEW dbo.penaltiesWithNames >>>'
    ELSE
        PRINT '<<< DROPPED VIEW dbo.penaltiesWithNames >>>'
END
go

IF OBJECT_ID('dbo.privilegesWithNames') IS NOT NULL
BEGIN
    DROP VIEW dbo.privilegesWithNames
    IF OBJECT_ID('dbo.privilegesWithNames') IS NOT NULL
        PRINT '<<< FAILED DROPPING VIEW dbo.privilegesWithNames >>>'
    ELSE
        PRINT '<<< DROPPED VIEW dbo.privilegesWithNames >>>'
END
go

IF OBJECT_ID('dbo.registeredNames') IS NOT NULL
BEGIN
    DROP VIEW dbo.registeredNames
    IF OBJECT_ID('dbo.registeredNames') IS NOT NULL
        PRINT '<<< FAILED DROPPING VIEW dbo.registeredNames >>>'
    ELSE
        PRINT '<<< DROPPED VIEW dbo.registeredNames >>>'
END
go

IF OBJECT_ID('dbo.warningsWithNames') IS NOT NULL
BEGIN
    DROP VIEW dbo.warningsWithNames
    IF OBJECT_ID('dbo.warningsWithNames') IS NOT NULL
        PRINT '<<< FAILED DROPPING VIEW dbo.warningsWithNames >>>'
    ELSE
        PRINT '<<< DROPPED VIEW dbo.warningsWithNames >>>'
END
go


--
-- DROP TABLES
--
DROP TABLE dbo.bannedNames
go

DROP TABLE dbo.configurationKeys
go

DROP TABLE dbo.history
go

DROP TABLE dbo.passwordChanges
go

DROP TABLE dbo.penalties
go

DROP TABLE dbo.penaltyTypes
go

DROP TABLE dbo.privilegeDomains
go

DROP TABLE dbo.privilegeTypes
go

DROP TABLE dbo.registration
go

DROP TABLE dbo.userDetails
go

DROP TABLE dbo.userPrivileges
go

IF OBJECT_ID('userDetailRefToUsers') IS NOT NULL
BEGIN
    ALTER TABLE dbo.userDetails DROP CONSTRAINT userDetailRefToUsers
    IF OBJECT_ID('userDetailRefToUsers') IS NOT NULL
        PRINT '<<< FAILED DROPPING CONSTRAINT userDetailRefToUsers >>>'
    ELSE
        PRINT '<<< DROPPED CONSTRAINT userDetailRefToUsers >>>'
END
go
DROP TABLE dbo.users
go

DROP TABLE dbo.warnings
go


--
-- DROP USER DEFINED DATATYPES
--
IF EXISTS (SELECT * FROM systypes WHERE name='UrlType')
BEGIN
    EXEC sp_droptype 'UrlType'
    IF EXISTS (SELECT * FROM systypes WHERE name='UrlType')
        PRINT '<<< FAILED DROPPING DATATYPE UrlType >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE UrlType >>>'
END
go

IF EXISTS (SELECT * FROM systypes WHERE name='VPPassword')
BEGIN
    EXEC sp_droptype 'VPPassword'
    IF EXISTS (SELECT * FROM systypes WHERE name='VPPassword')
        PRINT '<<< FAILED DROPPING DATATYPE VPPassword >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE VPPassword >>>'
END
go

IF EXISTS (SELECT * FROM systypes WHERE name='VPuserID')
BEGIN
    EXEC sp_droptype 'VPuserID'
    IF EXISTS (SELECT * FROM systypes WHERE name='VPuserID')
        PRINT '<<< FAILED DROPPING DATATYPE VPuserID >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE VPuserID >>>'
END
go

IF EXISTS (SELECT * FROM systypes WHERE name='VpRegMode')
BEGIN
    EXEC sp_droptype 'VpRegMode'
    IF EXISTS (SELECT * FROM systypes WHERE name='VpRegMode')
        PRINT '<<< FAILED DROPPING DATATYPE VpRegMode >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE VpRegMode >>>'
END
go

IF EXISTS (SELECT * FROM systypes WHERE name='VpTime')
BEGIN
    EXEC sp_droptype 'VpTime'
    IF EXISTS (SELECT * FROM systypes WHERE name='VpTime')
        PRINT '<<< FAILED DROPPING DATATYPE VpTime >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE VpTime >>>'
END
go

IF EXISTS (SELECT * FROM systypes WHERE name='auditoriumIdentifier')
BEGIN
    EXEC sp_droptype 'auditoriumIdentifier'
    IF EXISTS (SELECT * FROM systypes WHERE name='auditoriumIdentifier')
        PRINT '<<< FAILED DROPPING DATATYPE auditoriumIdentifier >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE auditoriumIdentifier >>>'
END
go

IF EXISTS (SELECT * FROM systypes WHERE name='categoryIdentifier')
BEGIN
    EXEC sp_droptype 'categoryIdentifier'
    IF EXISTS (SELECT * FROM systypes WHERE name='categoryIdentifier')
        PRINT '<<< FAILED DROPPING DATATYPE categoryIdentifier >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE categoryIdentifier >>>'
END
go

IF EXISTS (SELECT * FROM systypes WHERE name='clubIdentifier')
BEGIN
    EXEC sp_droptype 'clubIdentifier'
    IF EXISTS (SELECT * FROM systypes WHERE name='clubIdentifier')
        PRINT '<<< FAILED DROPPING DATATYPE clubIdentifier >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE clubIdentifier >>>'
END
go

IF EXISTS (SELECT * FROM systypes WHERE name='clubName')
BEGIN
    EXEC sp_droptype 'clubName'
    IF EXISTS (SELECT * FROM systypes WHERE name='clubName')
        PRINT '<<< FAILED DROPPING DATATYPE clubName >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE clubName >>>'
END
go

IF EXISTS (SELECT * FROM systypes WHERE name='domainName')
BEGIN
    EXEC sp_droptype 'domainName'
    IF EXISTS (SELECT * FROM systypes WHERE name='domainName')
        PRINT '<<< FAILED DROPPING DATATYPE domainName >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE domainName >>>'
END
go

IF EXISTS (SELECT * FROM systypes WHERE name='eventIdentifier')
BEGIN
    EXEC sp_droptype 'eventIdentifier'
    IF EXISTS (SELECT * FROM systypes WHERE name='eventIdentifier')
        PRINT '<<< FAILED DROPPING DATATYPE eventIdentifier >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE eventIdentifier >>>'
END
go

IF EXISTS (SELECT * FROM systypes WHERE name='gameIdentifier')
BEGIN
    EXEC sp_droptype 'gameIdentifier'
    IF EXISTS (SELECT * FROM systypes WHERE name='gameIdentifier')
        PRINT '<<< FAILED DROPPING DATATYPE gameIdentifier >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE gameIdentifier >>>'
END
go

IF EXISTS (SELECT * FROM systypes WHERE name='gameTypeIdentifier')
BEGIN
    EXEC sp_droptype 'gameTypeIdentifier'
    IF EXISTS (SELECT * FROM systypes WHERE name='gameTypeIdentifier')
        PRINT '<<< FAILED DROPPING DATATYPE gameTypeIdentifier >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE gameTypeIdentifier >>>'
END
go

IF EXISTS (SELECT * FROM systypes WHERE name='longName')
BEGIN
    EXEC sp_droptype 'longName'
    IF EXISTS (SELECT * FROM systypes WHERE name='longName')
        PRINT '<<< FAILED DROPPING DATATYPE longName >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE longName >>>'
END
go

IF EXISTS (SELECT * FROM systypes WHERE name='penID')
BEGIN
    EXEC sp_droptype 'penID'
    IF EXISTS (SELECT * FROM systypes WHERE name='penID')
        PRINT '<<< FAILED DROPPING DATATYPE penID >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE penID >>>'
END
go

IF EXISTS (SELECT * FROM systypes WHERE name='penType')
BEGIN
    EXEC sp_droptype 'penType'
    IF EXISTS (SELECT * FROM systypes WHERE name='penType')
        PRINT '<<< FAILED DROPPING DATATYPE penType >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE penType >>>'
END
go

IF EXISTS (SELECT * FROM systypes WHERE name='privID')
BEGIN
    EXEC sp_droptype 'privID'
    IF EXISTS (SELECT * FROM systypes WHERE name='privID')
        PRINT '<<< FAILED DROPPING DATATYPE privID >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE privID >>>'
END
go

IF EXISTS (SELECT * FROM systypes WHERE name='privType')
BEGIN
    EXEC sp_droptype 'privType'
    IF EXISTS (SELECT * FROM systypes WHERE name='privType')
        PRINT '<<< FAILED DROPPING DATATYPE privType >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE privType >>>'
END
go

IF EXISTS (SELECT * FROM systypes WHERE name='serviceID')
BEGIN
    EXEC sp_droptype 'serviceID'
    IF EXISTS (SELECT * FROM systypes WHERE name='serviceID')
        PRINT '<<< FAILED DROPPING DATATYPE serviceID >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE serviceID >>>'
END
go

IF EXISTS (SELECT * FROM systypes WHERE name='shortName')
BEGIN
    EXEC sp_droptype 'shortName'
    IF EXISTS (SELECT * FROM systypes WHERE name='shortName')
        PRINT '<<< FAILED DROPPING DATATYPE shortName >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE shortName >>>'
END
go

IF EXISTS (SELECT * FROM systypes WHERE name='stateIdentifier')
BEGIN
    EXEC sp_droptype 'stateIdentifier'
    IF EXISTS (SELECT * FROM systypes WHERE name='stateIdentifier')
        PRINT '<<< FAILED DROPPING DATATYPE stateIdentifier >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE stateIdentifier >>>'
END
go

IF EXISTS (SELECT * FROM systypes WHERE name='userIdentifier')
BEGIN
    EXEC sp_droptype 'userIdentifier'
    IF EXISTS (SELECT * FROM systypes WHERE name='userIdentifier')
        PRINT '<<< FAILED DROPPING DATATYPE userIdentifier >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE userIdentifier >>>'
END
go

IF EXISTS (SELECT * FROM systypes WHERE name='warnID')
BEGIN
    EXEC sp_droptype 'warnID'
    IF EXISTS (SELECT * FROM systypes WHERE name='warnID')
        PRINT '<<< FAILED DROPPING DATATYPE warnID >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE warnID >>>'
END
go


--
-- DROP USERS
--
IF USER_ID('audset') IS NOT NULL
BEGIN
    EXEC sp_dropuser 'audset'
    IF USER_ID('audset') IS NOT NULL
        PRINT '<<< FAILED DROPPING USER audset >>>'
    ELSE
        PRINT '<<< DROPPED USER audset >>>'
END
go

IF USER_ID('vpplaces') IS NOT NULL
BEGIN
    EXEC sp_dropuser 'vpplaces'
    IF USER_ID('vpplaces') IS NOT NULL
        PRINT '<<< FAILED DROPPING USER vpplaces >>>'
    ELSE
        PRINT '<<< DROPPED USER vpplaces >>>'
END
go


--
-- DROP SEGMENTS
--
IF EXISTS (SELECT * FROM syssegments WHERE name='userDetailsSeg')
BEGIN
    EXEC sp_dropsegment 'userDetailsSeg','vpusers',NULL 
    IF EXISTS (SELECT * FROM syssegments WHERE name='userDetailsSeg')
        PRINT '<<< FAILED DROPPING SEGMENT userDetailsSeg >>>'
    ELSE
        PRINT '<<< DROPPED SEGMENT userDetailsSeg >>>'
END
go


--
-- CREATE SEGMENTS
--
EXEC sp_addsegment 'userDetailsSeg','vpusers','VpUserDetails'
go
IF EXISTS (SELECT * FROM syssegments WHERE name='userDetailsSeg')
    PRINT '<<< CREATED SEGMENT userDetailsSeg >>>'
ELSE
    PRINT '<<< FAILED CREATING SEGMENT userDetailsSeg >>>'
go


--
-- CREATE GROUPS
--
GRANT CREATE TABLE TO public
go
GRANT CREATE VIEW TO public
go
GRANT CREATE PROCEDURE TO public
go
GRANT DUMP DATABASE TO public
go
GRANT CREATE DEFAULT TO public
go
GRANT DUMP TRANSACTION TO public
go
GRANT CREATE RULE TO public
go


--
-- CREATE USERS
--
EXEC sp_adduser 'audset','audset','public'
go
IF USER_ID('audset') IS NOT NULL
    PRINT '<<< CREATED USER audset >>>'
ELSE
    PRINT '<<< FAILED CREATING USER audset >>>'
go

EXEC sp_adduser 'vpplaces','vpplaces','public'
go
IF USER_ID('vpplaces') IS NOT NULL
    PRINT '<<< CREATED USER vpplaces >>>'
ELSE
    PRINT '<<< FAILED CREATING USER vpplaces >>>'
go


--
-- CREATE USER DEFINED DATATYPES
--
EXEC sp_addtype 'UrlType','varchar(200)','NOT NULL'
go
IF EXISTS (SELECT * FROM systypes WHERE name='UrlType')
    PRINT '<<< CREATED DATATYPE UrlType >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE UrlType >>>'
go

EXEC sp_addtype 'VPPassword','varchar(20)','NOT NULL'
go
IF EXISTS (SELECT * FROM systypes WHERE name='VPPassword')
    PRINT '<<< CREATED DATATYPE VPPassword >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE VPPassword >>>'
go

EXEC sp_addtype 'VPuserID','varchar(20)','NOT NULL'
go
IF EXISTS (SELECT * FROM systypes WHERE name='VPuserID')
    PRINT '<<< CREATED DATATYPE VPuserID >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE VPuserID >>>'
go

EXEC sp_addtype 'VpRegMode','tinyint','NOT NULL'
go
IF EXISTS (SELECT * FROM systypes WHERE name='VpRegMode')
    PRINT '<<< CREATED DATATYPE VpRegMode >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE VpRegMode >>>'
go

EXEC sp_addtype 'VpTime','smalldatetime','NOT NULL'
go
IF EXISTS (SELECT * FROM systypes WHERE name='VpTime')
    PRINT '<<< CREATED DATATYPE VpTime >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE VpTime >>>'
go

EXEC sp_addtype 'auditoriumIdentifier','numeric(6,0)','NOT NULL'
go
IF EXISTS (SELECT * FROM systypes WHERE name='auditoriumIdentifier')
    PRINT '<<< CREATED DATATYPE auditoriumIdentifier >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE auditoriumIdentifier >>>'
go

EXEC sp_addtype 'categoryIdentifier','numeric(6,0)','NOT NULL'
go
IF EXISTS (SELECT * FROM systypes WHERE name='categoryIdentifier')
    PRINT '<<< CREATED DATATYPE categoryIdentifier >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE categoryIdentifier >>>'
go

EXEC sp_addtype 'clubIdentifier','numeric(6,0)','NOT NULL'
go
IF EXISTS (SELECT * FROM systypes WHERE name='clubIdentifier')
    PRINT '<<< CREATED DATATYPE clubIdentifier >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE clubIdentifier >>>'
go

EXEC sp_addtype 'clubName','varchar(30)','NOT NULL'
go
IF EXISTS (SELECT * FROM systypes WHERE name='clubName')
    PRINT '<<< CREATED DATATYPE clubName >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE clubName >>>'
go

EXEC sp_addtype 'domainName','varchar(100)','NOT NULL'
go
IF EXISTS (SELECT * FROM systypes WHERE name='domainName')
    PRINT '<<< CREATED DATATYPE domainName >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE domainName >>>'
go

EXEC sp_addtype 'eventIdentifier','numeric(10,0)','NOT NULL'
go
IF EXISTS (SELECT * FROM systypes WHERE name='eventIdentifier')
    PRINT '<<< CREATED DATATYPE eventIdentifier >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE eventIdentifier >>>'
go

EXEC sp_addtype 'gameIdentifier','numeric(8,0)','NOT NULL'
go
IF EXISTS (SELECT * FROM systypes WHERE name='gameIdentifier')
    PRINT '<<< CREATED DATATYPE gameIdentifier >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE gameIdentifier >>>'
go

EXEC sp_addtype 'gameTypeIdentifier','numeric(8,0)','NOT NULL'
go
IF EXISTS (SELECT * FROM systypes WHERE name='gameTypeIdentifier')
    PRINT '<<< CREATED DATATYPE gameTypeIdentifier >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE gameTypeIdentifier >>>'
go

EXEC sp_addtype 'longName','varchar(255)','NOT NULL'
go
IF EXISTS (SELECT * FROM systypes WHERE name='longName')
    PRINT '<<< CREATED DATATYPE longName >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE longName >>>'
go

EXEC sp_addtype 'penID','int','NOT NULL'
go
IF EXISTS (SELECT * FROM systypes WHERE name='penID')
    PRINT '<<< CREATED DATATYPE penID >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE penID >>>'
go

EXEC sp_addtype 'penType','smallint','NOT NULL'
go
IF EXISTS (SELECT * FROM systypes WHERE name='penType')
    PRINT '<<< CREATED DATATYPE penType >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE penType >>>'
go

EXEC sp_addtype 'privID','numeric(6,0)','NOT NULL'
go
IF EXISTS (SELECT * FROM systypes WHERE name='privID')
    PRINT '<<< CREATED DATATYPE privID >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE privID >>>'
go

EXEC sp_addtype 'privType','smallint','NOT NULL'
go
IF EXISTS (SELECT * FROM systypes WHERE name='privType')
    PRINT '<<< CREATED DATATYPE privType >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE privType >>>'
go

EXEC sp_addtype 'serviceID','smallint','NOT NULL'
go
IF EXISTS (SELECT * FROM systypes WHERE name='serviceID')
    PRINT '<<< CREATED DATATYPE serviceID >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE serviceID >>>'
go

EXEC sp_addtype 'shortName','varchar(20)','NOT NULL'
go
IF EXISTS (SELECT * FROM systypes WHERE name='shortName')
    PRINT '<<< CREATED DATATYPE shortName >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE shortName >>>'
go

EXEC sp_addtype 'stateIdentifier','numeric(4,0)','NOT NULL'
go
IF EXISTS (SELECT * FROM systypes WHERE name='stateIdentifier')
    PRINT '<<< CREATED DATATYPE stateIdentifier >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE stateIdentifier >>>'
go

EXEC sp_addtype 'userIdentifier','numeric(8,0)','NOT NULL'
go
IF EXISTS (SELECT * FROM systypes WHERE name='userIdentifier')
    PRINT '<<< CREATED DATATYPE userIdentifier >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE userIdentifier >>>'
go

EXEC sp_addtype 'warnID','numeric(8,0)','NOT NULL'
go
IF EXISTS (SELECT * FROM systypes WHERE name='warnID')
    PRINT '<<< CREATED DATATYPE warnID >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE warnID >>>'
go


--
-- CREATE TABLES
--
CREATE TABLE dbo.bannedNames 
(
    nickName   VPuserID NOT NULL,
    isBanned   bit      DEFAULT 1		 NOT NULL,
    isFiltered bit      DEFAULT 1		 NOT NULL,
    CONSTRAINT isPrimary PRIMARY KEY CLUSTERED (nickName)
)
go
IF OBJECT_ID('dbo.bannedNames') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.bannedNames >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.bannedNames >>>'
go

CREATE TABLE dbo.configurationKeys 
(
    keyName   varchar(20)  NOT NULL,
    belongsTo serviceID    DEFAULT 0	 NOT NULL,
    type      smallint     DEFAULT 1	 NOT NULL,
    keyID     smallint     DEFAULT 1	 NOT NULL,
    intValue  int          NULL,
    strValue  varchar(255) NULL,
    CONSTRAINT isPrimary PRIMARY KEY CLUSTERED (keyName)
)
go
IF OBJECT_ID('dbo.configurationKeys') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.configurationKeys >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.configurationKeys >>>'
go

CREATE TABLE dbo.history 
(
    penaltyID   int            NOT NULL,
    userID      userIdentifier NOT NULL,
    penaltyType penType        NOT NULL,
    expiresOn   VpTime         NULL,
    issuedOn    VpTime         NOT NULL,
    issuedBy    userIdentifier NOT NULL,
    forgiven    bit            DEFAULT 0	 NOT NULL,
    comment     longName       NULL,
    CONSTRAINT isPrimary PRIMARY KEY CLUSTERED (penaltyID)
)
go
IF OBJECT_ID('dbo.history') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.history >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.history >>>'
go

CREATE TABLE dbo.passwordChanges 
(
    nickName VPuserID   NOT NULL,
    email    longName   NOT NULL,
    password VPPassword NOT NULL
)
go
IF OBJECT_ID('dbo.passwordChanges') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.passwordChanges >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.passwordChanges >>>'
go

CREATE TABLE dbo.penalties 
(
    penaltyID   penID          NOT NULL,
    userID      userIdentifier NOT NULL,
    penaltyType penType        NOT NULL,
    expiresOn   VpTime         NULL,
    issuedOn    VpTime         NOT NULL,
    issuedBy    userIdentifier NOT NULL,
    forgiven    bit            DEFAULT 0	 NOT NULL,
    comment     longName       NULL,
    CONSTRAINT isPrimary PRIMARY KEY CLUSTERED (penaltyID)
)
go
IF OBJECT_ID('dbo.penalties') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.penalties >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.penalties >>>'
go

CREATE TABLE dbo.penaltyTypes 
(
    penaltyType penType     NOT NULL,
    description varchar(30) NOT NULL,
    CONSTRAINT isPrimary PRIMARY KEY CLUSTERED (penaltyType)
)
go
IF OBJECT_ID('dbo.penaltyTypes') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.penaltyTypes >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.penaltyTypes >>>'
go

CREATE TABLE dbo.privilegeDomains 
(
    userID userIdentifier NOT NULL,
    domain UrlType        NOT NULL,
    CONSTRAINT PrivDomainsIDisPrimary PRIMARY KEY CLUSTERED (userID,domain)
)
go
IF OBJECT_ID('dbo.privilegeDomains') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.privilegeDomains >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.privilegeDomains >>>'
go

CREATE TABLE dbo.privilegeTypes 
(
    privilegeType privType    NOT NULL,
    description   varchar(30) NOT NULL,
    CONSTRAINT isPrimary PRIMARY KEY CLUSTERED (privilegeType)
)
go
IF OBJECT_ID('dbo.privilegeTypes') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.privilegeTypes >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.privilegeTypes >>>'
go

CREATE TABLE dbo.registration 
(
    userID           userIdentifier NOT NULL,
    email            longName       NULL,
    password         VPPassword     NULL,
    registrationDate VpTime         NOT NULL,
    lastSignOnDate   VpTime         NULL,
    deleteDate       VpTime         NULL,
    CONSTRAINT isPrimary PRIMARY KEY NONCLUSTERED (userID)
)
go
IF OBJECT_ID('dbo.registration') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.registration >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.registration >>>'
go

CREATE TABLE dbo.userDetails 
(
    userID           userIdentifier NOT NULL,
    firstName        varchar(30)    NOT NULL,
    lastName         varchar(50)    NOT NULL,
    age              tinyint        NOT NULL,
    gender           bit            NOT NULL,
    city             varchar(30)    NOT NULL,
    state            varchar(30)    NOT NULL,
    country          char(2)        NOT NULL,
    zipcode          varchar(25)    NOT NULL,
    profession       smallint       NOT NULL,
    company          varchar(30)    NOT NULL,
    motto            varchar(50)    NOT NULL,
    homePage         varchar(200)   NOT NULL,
    income           smallint       NOT NULL,
    education        tinyint        NOT NULL,
    maritalStatus    tinyint        NOT NULL,
    children         tinyint        NOT NULL,
    employment       smallint       NOT NULL,
    timeOnline       tinyint        NOT NULL,
    accessFrequency  tinyint        NOT NULL,
    bandwidth        tinyint        NOT NULL,
    accessFromHome   bit            NOT NULL,
    accessFromWork   bit            NOT NULL,
    accessFromSchool bit            NOT NULL,
    beenInTalk       bit            NOT NULL,
    wantsNewsletter  bit            NOT NULL,
    cb_relationships bit            NOT NULL,
    cb_electronics   bit            NOT NULL,
    cd_cars          bit            NOT NULL,
    cb_travel        bit            NOT NULL,
    cb_movies        bit            NOT NULL,
    cb_gardening     bit            NOT NULL,
    cb_business      bit            NOT NULL,
    cb_music         bit            NOT NULL,
    cb_home          bit            NOT NULL,
    cb_investing     bit            NOT NULL,
    cb_tv            bit            NOT NULL,
    cb_current       bit            NOT NULL,
    cb_family        bit            NOT NULL,
    cb_sports        bit            NOT NULL,
    cb_computers     bit            NOT NULL,
    cb_science       bit            NOT NULL,
    cb_literature    bit            NOT NULL,
    cb_arts          bit            NOT NULL,
    showInList       bit            NOT NULL,
    showEmail        bit            NOT NULL,
    showFirstName    bit            NOT NULL,
    showLastName     bit            NOT NULL,
    showAge          bit            NOT NULL,
    showGender       bit            NOT NULL,
    showCity         bit            NOT NULL,
    showState        bit            NOT NULL,
    showCountry      bit            NOT NULL,
    showZipcode      bit            NOT NULL,
    showBio          bit            NOT NULL,
    showProfession   bit            NOT NULL,
    showEducation    bit            NOT NULL,
    showEmployment   bit            NOT NULL,
    showCompany      bit            NOT NULL,
    showMotto        bit            NOT NULL,
    showHomePage     bit            NOT NULL,
    upperFirst       varchar(30)    NOT NULL,
    upperLast        varchar(50)    NOT NULL,
    CONSTRAINT userDetailsIDisPrimary PRIMARY KEY CLUSTERED (userID) 
                                                            ON userDetailsSeg
)
ON userDetailsSeg
go
IF OBJECT_ID('dbo.userDetails') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.userDetails >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.userDetails >>>'
go

CREATE TABLE dbo.userPrivileges 
(
    privilegeID   privID         IDENTITY,
    userID        userIdentifier NOT NULL,
    privilegeType privType       NOT NULL,
    expiresOn     VpTime         NULL,
    CONSTRAINT isPrimary PRIMARY KEY CLUSTERED (privilegeID)
)
go
IF OBJECT_ID('dbo.userPrivileges') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.userPrivileges >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.userPrivileges >>>'
go

CREATE TABLE dbo.users 
(
    userID           userIdentifier IDENTITY,
    nickName         VPuserID       NOT NULL,
    registrationMode VpRegMode      NOT NULL,
    CONSTRAINT isPrimary PRIMARY KEY CLUSTERED (userID),
    CONSTRAINT uniqueNickname UNIQUE NONCLUSTERED (nickName,registrationMode)
)
go
IF OBJECT_ID('dbo.users') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.users >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.users >>>'
go

CREATE TABLE dbo.warnings 
(
    warningID warnID         IDENTITY,
    userID    userIdentifier NOT NULL,
    content   longName       NOT NULL,
    issuedOn  VpTime         NOT NULL,
    issuedBy  userIdentifier NOT NULL,
    comment   longName       NULL,
    CONSTRAINT isPrimary PRIMARY KEY CLUSTERED (warningID)
)
go
IF OBJECT_ID('dbo.warnings') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.warnings >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.warnings >>>'
go


--
-- ADD REFERENTIAL CONSTRAINTS
--
ALTER TABLE dbo.userDetails ADD CONSTRAINT userDetailRefToUsers FOREIGN KEY (userID) REFERENCES dbo.users (userID)
go

--
-- CREATE INDEXES
--
CREATE UNIQUE NONCLUSTERED INDEX configurationIdx
    ON dbo.configurationKeys(belongsTo,type,keyID)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.configurationKeys') AND name='configurationIdx')
    PRINT '<<< CREATED INDEX dbo.configurationKeys.configurationIdx >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.configurationKeys.configurationIdx >>>'
go

CREATE NONCLUSTERED INDEX expiryTimeIdx
    ON dbo.penalties(expiresOn)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.penalties') AND name='expiryTimeIdx')
    PRINT '<<< CREATED INDEX dbo.penalties.expiryTimeIdx >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.penalties.expiryTimeIdx >>>'
go

CREATE NONCLUSTERED INDEX userIdx
    ON dbo.penalties(userID)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.penalties') AND name='userIdx')
    PRINT '<<< CREATED INDEX dbo.penalties.userIdx >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.penalties.userIdx >>>'
go

CREATE NONCLUSTERED INDEX registrationByEmailIdx
    ON dbo.registration(email)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.registration') AND name='registrationByEmailIdx')
    PRINT '<<< CREATED INDEX dbo.registration.registrationByEmailIdx >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.registration.registrationByEmailIdx >>>'
go

CREATE NONCLUSTERED INDEX registrationByDateIdx
    ON dbo.registration(registrationDate)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.registration') AND name='registrationByDateIdx')
    PRINT '<<< CREATED INDEX dbo.registration.registrationByDateIdx >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.registration.registrationByDateIdx >>>'
go

CREATE NONCLUSTERED INDEX userDetailsByNameIdx
    ON dbo.userDetails(upperFirst,upperLast)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.userDetails') AND name='userDetailsByNameIdx')
    PRINT '<<< CREATED INDEX dbo.userDetails.userDetailsByNameIdx >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.userDetails.userDetailsByNameIdx >>>'
go

CREATE UNIQUE NONCLUSTERED INDEX privilegeByUserIdx
    ON dbo.userPrivileges(userID,privilegeType)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.userPrivileges') AND name='privilegeByUserIdx')
    PRINT '<<< CREATED INDEX dbo.userPrivileges.privilegeByUserIdx >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.userPrivileges.privilegeByUserIdx >>>'
go

CREATE NONCLUSTERED INDEX usersByNickNameIdx
    ON dbo.users(nickName,registrationMode)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.users') AND name='usersByNickNameIdx')
    PRINT '<<< CREATED INDEX dbo.users.usersByNickNameIdx >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.users.usersByNickNameIdx >>>'
go

CREATE NONCLUSTERED INDEX issueTimeIdx
    ON dbo.warnings(issuedOn)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.warnings') AND name='issueTimeIdx')
    PRINT '<<< CREATED INDEX dbo.warnings.issueTimeIdx >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.warnings.issueTimeIdx >>>'
go

CREATE NONCLUSTERED INDEX userIdx
    ON dbo.warnings(userID)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.warnings') AND name='userIdx')
    PRINT '<<< CREATED INDEX dbo.warnings.userIdx >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.warnings.userIdx >>>'
go


--
-- CREATE VIEWS
--
CREATE VIEW getGMT
AS
  SELECT intValue AS gmt
    FROM configurationKeys
    WHERE keyName = "diffFromGMT"

go
IF OBJECT_ID('dbo.getGMT') IS NOT NULL
    PRINT '<<< CREATED VIEW dbo.getGMT >>>'
ELSE
    PRINT '<<< FAILED CREATING VIEW dbo.getGMT >>>'
go

CREATE VIEW historyWithNames
AS
  SELECT penaltyID AS Id,
         users.nickName AS Name, users.registrationMode AS Mode,
         description AS Penalty,
         issuedOn,
         u1.nickName AS issuer,
         u1.registrationMode AS issuerMode,
         forgiven,
         expiresOn
  FROM history, penaltyTypes, users, users u1
  WHERE history.penaltyType = penaltyTypes.penaltyType AND
        history.userID = users.userID AND
        history.issuedBy = u1.userID

go
IF OBJECT_ID('dbo.historyWithNames') IS NOT NULL
    PRINT '<<< CREATED VIEW dbo.historyWithNames >>>'
ELSE
    PRINT '<<< FAILED CREATING VIEW dbo.historyWithNames >>>'
go

CREATE VIEW hosts
AS
  SELECT userID
  FROM userPrivileges
  WHERE privilegeType = 273

go
IF OBJECT_ID('dbo.hosts') IS NOT NULL
    PRINT '<<< CREATED VIEW dbo.hosts >>>'
ELSE
    PRINT '<<< FAILED CREATING VIEW dbo.hosts >>>'
go

CREATE VIEW penaltiesWithNames
AS
  SELECT penaltyID AS Id,
         users.nickName AS Name, users.registrationMode AS Mode,
         description AS Penalty,
         issuedOn,
         u1.nickName AS issuer,
         u1.registrationMode AS issuerMode,
         forgiven,
         expiresOn
  FROM penalties, penaltyTypes, users, users u1
  WHERE penalties.penaltyType = penaltyTypes.penaltyType AND
        penalties.userID = users.userID AND
        penalties.issuedBy = u1.userID

go
IF OBJECT_ID('dbo.penaltiesWithNames') IS NOT NULL
    PRINT '<<< CREATED VIEW dbo.penaltiesWithNames >>>'
ELSE
    PRINT '<<< FAILED CREATING VIEW dbo.penaltiesWithNames >>>'
go

CREATE VIEW privilegesWithNames
AS
  SELECT nickName AS Name, registrationMode AS Mode,
         description AS Privilege
    FROM userPrivileges, users, privilegeTypes
    WHERE userPrivileges.privilegeType = privilegeTypes.privilegeType AND
          users.userID = userPrivileges.userID

go
IF OBJECT_ID('dbo.privilegesWithNames') IS NOT NULL
    PRINT '<<< CREATED VIEW dbo.privilegesWithNames >>>'
ELSE
    PRINT '<<< FAILED CREATING VIEW dbo.privilegesWithNames >>>'
go

CREATE VIEW registeredNames
AS
  SELECT users.userID, nickName, email, password
    FROM users, registration
    WHERE users.userID = registration.userID

go
IF OBJECT_ID('dbo.registeredNames') IS NOT NULL
    PRINT '<<< CREATED VIEW dbo.registeredNames >>>'
ELSE
    PRINT '<<< FAILED CREATING VIEW dbo.registeredNames >>>'
go

CREATE VIEW warningsWithNames
AS
  SELECT warningID AS Id, 
         users.nickName AS Name, users.registrationMode AS Mode,
         issuedOn,
         u1.nickName AS issuer,
         u1.registrationMode AS issuerMode
  FROM warnings, users, users u1
  WHERE warnings.userID = users.userID AND
        warnings.issuedBy = u1.userID

go
IF OBJECT_ID('dbo.warningsWithNames') IS NOT NULL
    PRINT '<<< CREATED VIEW dbo.warningsWithNames >>>'
ELSE
    PRINT '<<< FAILED CREATING VIEW dbo.warningsWithNames >>>'
go


--
-- CREATE PROCEDURES
--
/* set the password for an account */
/* input:  nickName, password
   output: None */
CREATE PROC SetPassword
( @nickName VPuserID,
  @password varchar(30)
)
AS
BEGIN
  /* turn all user ID to lower case, to get case insensitive comparisons */
  SELECT @nickName = lower(@nickName)
  DECLARE @lastError int
  DECLARE @diffFromGMT int
  DECLARE @currentTime smalldatetime
  
  BEGIN TRAN
    SELECT @diffFromGMT = gmt
      FROM getGMT
    IF @diffFromGMT IS NULL
      SELECT @diffFromGMT = 0
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END

    SELECT @currentTime = dateadd( hour, (-1) * @diffFromGMT, getdate() )
    
    UPDATE registration
      SET password = @password, registrationDate = @currentTime
      FROM registration, users
      WHERE users.nickName = @nickName AND
            users.registrationMode = 2 AND
            registration.userID = users.userID
            
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END

  COMMIT TRAN
END

go
IF OBJECT_ID('dbo.SetPassword') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.SetPassword >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.SetPassword >>>'
go

/* display all names from the banned names table 
   that are marked as banned names */
/* input:  NONE
   output: list of all entries in the table */
CREATE PROC ShowBannedNames
AS
BEGIN
  SELECT nickName 
    FROM bannedNames
    WHERE ( isBanned = 1 ) AND
          ( nickName != "__" )
    ORDER BY nickName
END

go
IF OBJECT_ID('dbo.ShowBannedNames') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.ShowBannedNames >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.ShowBannedNames >>>'
go

/* check user catgeory
   INPUT  : email address
   OUTPUT : string representing the category of that user by the user's details
*/
CREATE PROC VpExtGetUserCategory ( @email longName )
AS
BEGIN
  SELECT category = "!"
END

go
IF OBJECT_ID('dbo.VpExtGetUserCategory') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.VpExtGetUserCategory >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.VpExtGetUserCategory >>>'
go

/* add a name to the banned names list */
/* input:  nickName, is it banned, is it filtered
   output: return value - 
           0 - success,
           20001 - if name is already in list
           20002 - if name is prefix of "guest" 
                   (to allow automatic naming of guests)
*/
CREATE PROC addBannedName ( @nickName VPuserID, @isBanned bit = 1, @isFiltered bit = 1 )

AS
BEGIN
  DECLARE @lastError int
  DECLARE @oldName VPuserID

  /* turn all user ID to lower case, to get case insensitive comparisons */
  SELECT @nickName = lower(@nickName)
  IF ( ( @nickName = "g" )	OR
       ( @nickName = "gu" )	OR
       ( @nickName = "gue" )	OR
       ( @nickName = "gues" )	OR
       ( substring( @nickName, 1, 5 ) = "guest" ) )
    /* to allow server to issue guest "guest" names */
    RETURN 20002
  BEGIN TRAN addBannedName
    /* try to find this name in the list */
    SELECT @oldName = nickName
      FROM bannedNames
      WHERE ( nickName = @nickName )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN addBannedName
      RETURN @lastError
    END
    
    IF ( @oldName IS NOT NULL )
    BEGIN
      /* name already in list */
      ROLLBACK TRAN addBannedName
      RETURN 20001
    END
    
    INSERT INTO bannedNames 
      ( nickName, isBanned, isFiltered ) 
      VALUES ( @nickName, @isBanned, @isFiltered )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN addBannedName
      RETURN @lastError
    END
    
  COMMIT TRAN addBannedName
END

go
IF OBJECT_ID('dbo.addBannedName') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.addBannedName >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.addBannedName >>>'
go

/* add a new configuration key */
CREATE PROC addBoolConfigKey
(
  @keyName varchar(20),
  @belongsTo serviceID,
  @type smallInt,
  @keyID smallInt,
  @intValue int
)
AS
  INSERT configurationKeys 
    ( keyName, belongsTo, type, keyID, intValue )
    VALUES 
    ( @keyName, @belongsTo, @type, @keyID, @intValue )

go
IF OBJECT_ID('dbo.addBoolConfigKey') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.addBoolConfigKey >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.addBoolConfigKey >>>'
go

/* add a new configuration key */
CREATE PROC addConfigKey
(
  @keyName varchar(20),
  @belongsTo serviceID,
  @type smallInt,
  @keyID smallInt,
  @intValue int = NULL,
  @strValue longName = NULL
)
AS
  IF ( @type = 2 )
    EXEC addStrConfigKey @keyName, @belongsTo, @type, @keyID, @strValue
  ELSE
    EXEC addNumConfigKey @keyName, @belongsTo, @type, @keyID, @intValue

go
IF OBJECT_ID('dbo.addConfigKey') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.addConfigKey >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.addConfigKey >>>'
go

/* add a new configuration key */
CREATE PROC addNumConfigKey
(
  @keyName varchar(20),
  @belongsTo serviceID,
  @type smallInt,
  @keyID smallInt,
  @intValue int
)
AS
  INSERT configurationKeys 
    ( keyName, belongsTo, type, keyID, intValue )
    VALUES 
    ( @keyName, @belongsTo, @type, @keyID, @intValue )

go
IF OBJECT_ID('dbo.addNumConfigKey') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.addNumConfigKey >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.addNumConfigKey >>>'
go

/* --- add a penalty for a user --- */
  /* make sure no user has two different penalty records for the same type of penalty - */
  /* keep only the one that expires the latest. If we have two with the same expiry time, */
  /* keep this last one. */
  /* NOTE the correction assumption that is made here: at any given time, there one record */
  /* at the most with a certain penalty type for a given user. */
/*
  input : penalized user - nick name, reg.mode,
          penalty type, penalty duration (in minutes),
          issued by - nick name, reg.mode,
          comment,
          allow Aux as local (optional - default = FALSE)
  output: return value - 0 - success
                         20001 - tried to add penalty to user in local registration
                             that was not registered
                             (unless @allowAuxAsLocal = TRUE)
                         20002 - tried to add penalty issued by user
                             in local registration mode,
                             that was not registered
                             (unless @allowAuxAsLocal = TRUE)
*/
CREATE PROC addPenaltyToUser
( @userName VPuserID, @regMode VpRegMode, @penaltyType penType, @minutesDuration integer,
  @issuedBy VPuserID, @issuerRegMode VpRegMode, 
  @comment longName,
  @allowAuxAsLocal bit = 0,
  @diffFromGMT int = NULL
)
AS
BEGIN
  DECLARE @penalizedUserID userIdentifier
  DECLARE @issuerID userIdentifier
  DECLARE @expiryTime VpTime
  DECLARE @currentExpiry VpTime
  DECLARE @currentPenaltyID integer
  DECLARE @currentPenaltyIsForgiven bit
  DECLARE @insertNewRecord integer
  DECLARE @archiveOldRecord integer
  DECLARE @lastError int
  DECLARE @retVal int
  DECLARE @issueDate VpTime
  DECLARE @localTransaction bit
  SELECT @localTransaction = 1 - sign( @@trancount )
  
  /* turn all user ID to lower case, to get case insensitive comparisons */
  SELECT @userName = lower(@userName)
  SELECT @issuedBy = lower(@issuedBy)

  IF @localTransaction = 1
    BEGIN TRAN addPenaltyToUser
    
    IF @diffFromGMT IS NULL
    BEGIN
      SELECT @diffFromGMT = gmt
      FROM getGMT
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRAN addPenaltyToUser
        RETURN @lastError
      END
      
      IF @diffFromGMT IS NULL
        SELECT @diffFromGMT = 0
    END
    
    SELECT @issueDate = dateadd( hour, (-1) * @diffFromGMT, getdate() )
    SELECT @expiryTime= dateadd( minute, @minutesDuration, @issueDate )
    
    /* find user records for penalized user and issuer,
       or create them if necessary                      */
    EXEC @retVal = 
      updateUser @penalizedUserID OUTPUT, @userName, @regMode, @allowAuxAsLocal
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      IF @localTransaction = 1
        ROLLBACK TRAN
      RETURN @lastError
    END
    
    IF ( @retVal NOT IN ( 20001, 20002, 0 ) )
    BEGIN
      IF @localTransaction = 1
        ROLLBACK TRAN
      RETURN @retVal
    END
    
    IF ( @retVal = 20002 )
    BEGIN
      IF @localTransaction = 1
        ROLLBACK TRAN
      RETURN 20001
    END
    
    IF @penalizedUserID = 0
    BEGIN
      IF @localTransaction = 1
        ROLLBACK TRAN
      RETURN 20001
    END
    
    EXEC @retVal = 
      updateUser @issuerID OUTPUT, @issuedBy, @issuerRegMode, @allowAuxAsLocal
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      IF @localTransaction = 1
        ROLLBACK TRAN
      RETURN @lastError
    END
    
    IF ( @retVal NOT IN ( 20001, 0 ) )
    BEGIN
      IF @localTransaction = 1
        ROLLBACK TRAN
      RETURN @retVal
    END
    
    IF @issuerID = 0
    BEGIN
      IF @localTransaction = 1
        ROLLBACK TRAN
      RETURN 20002
    END
    
    /* first find current expiry time for this penalty, if user has this penalty */
    /* correctness assumption - user always has one or zero penalty records for
       a given penalty type. Otherwise we'd have to find the MAX of expiry time. */
    SELECT @currentPenaltyIsForgiven = 0
    SELECT 
        @currentExpiry = expiresOn, 
        @currentPenaltyID = penaltyID, 
        @currentPenaltyIsForgiven = forgiven 
      FROM penalties
      WHERE userID = @penalizedUserID AND
            penaltyType = @penaltyType
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      IF @localTransaction = 1
        ROLLBACK TRAN
      RETURN @lastError
    END
    
    SELECT @insertNewRecord = 1
    SELECT @archiveOldRecord = 0
    IF ( @currentExpiry IS NOT NULL ) BEGIN
      IF ( @currentPenaltyIsForgiven = 1 ) OR 
         ( @currentExpiry <= @issueDate )
        /* the current penalty is expired or forgiven */
        SELECT @archiveOldRecord = 1
      ELSE
        IF ( @currentExpiry <= @expiryTime )
          /* current penalty has not expired yet,
             but the new penalty lasts longer,
             so the current penalty will give way
             to the new penalty */
          SELECT @archiveOldRecord = 1
        ELSE
          /* this new penalty is superseded by the
             existing one, which will last longer */
          SELECT @insertNewRecord = 0
    END
    
    /* if there was already a penalty record and we decided to insert the new record into
       the penalties table, then first move that old record into history table. */
    IF ( @archiveOldRecord = 1 )
    BEGIN
      /* put the old penalty record into the history table */
      INSERT INTO history
        SELECT * FROM penalties
          WHERE penaltyID = @currentPenaltyID
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
      IF @localTransaction = 1
        ROLLBACK TRAN
        RETURN @lastError
      END
      
      /* delete the old penalty record from the penalties table */
      DELETE FROM penalties
        WHERE penaltyID = @currentPenaltyID
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        IF @localTransaction = 1
          ROLLBACK TRAN
        RETURN @lastError
      END
      
    END
    
    /* now put new record into penalties table or history table */
    DECLARE @newID integer
    DECLARE @maxPenaltiesID integer
    DECLARE @maxHistoryID integer
    SELECT @maxHistoryID = max(penaltyID) FROM history
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      IF @localTransaction = 1
        ROLLBACK TRAN
      RETURN @lastError
    END

    IF @maxHistoryID IS NULL
      SELECT @maxHistoryID = 0
    SELECT @maxPenaltiesID = max(penaltyID) FROM penalties
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      IF @localTransaction = 1
        ROLLBACK TRAN
      RETURN @lastError
    END

    IF @maxPenaltiesID IS NULL
      SELECT @maxPenaltiesID = 0
    IF @maxHistoryID > @maxPenaltiesID
      SELECT @newID = @maxHistoryID + 1
    ELSE
      SELECT @newID = @maxPenaltiesID + 1
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      IF @localTransaction = 1
        ROLLBACK TRAN
      RETURN @lastError
    END

    IF ( @insertNewRecord = 1 )
      INSERT INTO penalties
        ( penaltyID, userID, penaltyType, expiresOn, issuedOn, issuedBy, forgiven, comment )
        values ( @newID, @penalizedUserID, @penaltyType, @expiryTime, @issueDate, @issuerID, 0, @comment )

    ELSE /* ( @insertNewRecord = 0 ) ==> move new record directly to history */
      INSERT INTO history
        ( penaltyID, userID, penaltyType, expiresOn, issuedOn, issuedBy, forgiven, comment )
        values ( @newID, @penalizedUserID, @penaltyType, @expiryTime, @issueDate, @issuerID, 0, @comment )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      IF @localTransaction = 1
        ROLLBACK TRAN
      RETURN @lastError
    END
    
  IF @localTransaction = 1
    COMMIT TRAN addPenaltyToUser

END

go
IF OBJECT_ID('dbo.addPenaltyToUser') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.addPenaltyToUser >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.addPenaltyToUser >>>'
go

/* --- add a privilege for a user --- */
/*
  input: user nick name, re. mode, privilege type
  output: return value - 0 - success
                         20001 - privlege was already given
                         20002 - privilege type does not exist
                         20003 - tried to add privilege to a user in
                             local registration mode, but this user
                             was not found in the local registration
*/
CREATE PROC addPrivilege
(
@nickName VPuserID,
@regMode VpRegMode,
@privilegeType privType
)
AS
BEGIN
  DECLARE @userID userIdentifier
  DECLARE @lastError int
  DECLARE @retVal int
  
  /* turn all user ID to lower case, to get case insensitive comparisons */
  SELECT @nickName = lower(@nickName)
  
  BEGIN TRAN addPrivilege
    
    /* check if privilege type exists */
    IF EXISTS ( 
      SELECT privilegeType FROM privilegeTypes 
        WHERE privilegeType=@privilegeType )
    BEGIN
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRAN addPrivilege
        RETURN @lastError
      END
      
      /* get user ID, or create an entry
         for this user if none exists yet */
      EXEC @retVal = updateUser @userID OUTPUT, @nickName, @regMode
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRAN addPrivilege
        RETURN @lastError
      END
      
      IF @userID = 0
      BEGIN
        /* tried to add privilege to a user in
           local registration mode, but this user
           was not found in the local registration */
        ROLLBACK TRAN addPrivilege
        RETURN 20003
      END
      
      IF ( @retVal NOT IN ( 20001, 0 ) )
      BEGIN
        ROLLBACK TRAN addPrivilege
        RETURN @retVal
      END
      
      /* check if this privilege was 
         already given for this user */
      IF EXISTS (
        SELECT userID FROM userPrivileges
          WHERE userID = @userID AND
                privilegeType = @privilegeType )
      BEGIN
        /* don't insert same privilege twice */
        ROLLBACK TRAN addPrivilege
        RETURN 20001
      END
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRAN addPrivilege
        RETURN @lastError
      END
      
      INSERT INTO userPrivileges
        ( userID, privilegeType )
        VALUES ( @userID, @privilegeType )
    END
    ELSE BEGIN
      /* privilege type does not exist */
      ROLLBACK TRAN addPrivilege
      RETURN 20002
    END
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN addPrivilege
      RETURN @lastError
    END
    
  COMMIT TRAN addPrivilege
  
END

go
IF OBJECT_ID('dbo.addPrivilege') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.addPrivilege >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.addPrivilege >>>'
go

/* add a privilege domain for a specific user ID

   INPUT  : nickName, domain
   OUTPUT : return value - 0 - successfull
                           20003 - tried to add privilege domain to a user in
                                   local registration mode, but this user
                                   was not found in the local registration
                           20001 - domain name already specified for this user
                           
        
*/
CREATE PROC addPrivilegeDomain
(
  @nickName VPuserID,
  @domain UrlType 
)
AS
BEGIN
  DECLARE @userID userIdentifier
  DECLARE @auxDbAllowed bit
  DECLARE @lastError int
  DECLARE @retVal int
  DECLARE @domainFound int
  SELECT @domainFound = 0
  SELECT @auxDbAllowed = 0
  
  BEGIN TRAN addPrivilegeDomain
    
    SELECT @auxDbAllowed = intValue
      FROM configurationKeys
      WHERE ( keyName = "auxDbAllowed" )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
    
    /* get user ID, or create an entry
       for this user if none exists yet */
    EXEC @retVal = updateUser @userID OUTPUT, @nickName, 2, @auxDbAllowed
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN addPrivilege
      RETURN @lastError
    END
    
    IF @userID = 0
    BEGIN
      /* tried to add privilege domain to a user in
         local registration mode, but this user
         was not found in the local registration */
      ROLLBACK TRAN addPrivilegeDomain
      RETURN 20003
    END
    
    IF ( @retVal NOT IN ( 20001, 0 ) )
    BEGIN
      ROLLBACK TRAN addPrivilegeDomain
      RETURN @retVal
    END
    
    SELECT @domainFound = 1
      FROM privilegeDomains
      WHERE ( userID = @userID ) AND
            ( domain = @domain )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN addPrivilegeDomain
      RETURN @lastError
    END
    
    IF ( @domainFound = 1 )
    BEGIN
      /* this privilege domain was already
         specified for this user */
      ROLLBACK TRAN addPrivilegeDomain
      RETURN 20001
    END
    
    INSERT privilegeDomains ( userID, domain )
      VALUES ( @userID, @domain )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN addPrivilegeDomain
      RETURN @lastError
    END
  COMMIT TRAN addPrivilegeDomain
END

go
IF OBJECT_ID('dbo.addPrivilegeDomain') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.addPrivilegeDomain >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.addPrivilegeDomain >>>'
go

/* add a new configuration key */
CREATE PROC addStrConfigKey
(
  @keyName varchar(20),
  @belongsTo serviceID,
  @type smallInt,
  @keyID smallInt,
  @strValue longName
)
AS
  INSERT configurationKeys 
    ( keyName, belongsTo, type, keyID, strValue )
    VALUES 
    ( @keyName, @belongsTo, @type, @keyID, @strValue )

go
IF OBJECT_ID('dbo.addStrConfigKey') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.addStrConfigKey >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.addStrConfigKey >>>'
go

/* --- add a warning for a user --- */
/*
  input : user nick name, reg.mode, content of warning,
          nick name of person who issued the warning,
          registration mode for that person,
          comment regarding warning
  output: return value - 0 - success
                         20001 - tried to add warning to a user in
                             local registration mode, but this user
                             was not found in the local registration
                         20002 - tried to add warning issued by a user in
                             local registration mode, but that user
                             was not found in the local registration
*/
CREATE PROC addWarning
(
@nickName VPuserID,
@regMode VpRegMode,
@content longName,
@issuedBy VPuserID,
@issuerRegMode VpRegMode,
@comment longName,
@allowAuxAsLocal bit = 0,
@diffFromGMT int = NULL
)
AS
BEGIN
  /* turn all user ID to lower case, to get case insensitive comparisons */
  SELECT @nickName = lower(@nickName)
  SELECT @issuedBy = lower(@issuedBy)
  
  DECLARE @userID userIdentifier
  DECLARE @issuerID userIdentifier
  DECLARE @lastError int
  DECLARE @retVal int
  DECLARE @issueTime smalldatetime
  
  BEGIN TRAN
    
    IF @diffFromGMT IS NULL
    BEGIN
      SELECT @diffFromGMT = gmt
      FROM getGMT
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRAN addPenaltyToUser
        RETURN @lastError
      END
      
      IF @diffFromGMT IS NULL
        SELECT @diffFromGMT = 0
    END
    
    SELECT @issueTime = dateadd( hour, (-1) * @diffFromGMT, getdate() )
    
    EXEC @retVal = updateUser @userID OUTPUT, @nickName, @regMode, @allowAuxAsLocal
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
    
    IF @userID = 0
    BEGIN
      ROLLBACK TRAN
      RETURN 20001
    END
      
    IF ( @retVal NOT IN ( 20001, 0 ) )
    BEGIN
      ROLLBACK TRAN
      RETURN @retVal
    END
    
    EXEC @retVal = updateUser @issuerID OUTPUT, @issuedBy, @issuerRegMode, @allowAuxAsLocal
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
    
    IF @issuerID = 0
    BEGIN
      ROLLBACK TRAN
      RETURN 20002
    END
      
    IF ( @retVal NOT IN ( 20001, 0 ) )
    BEGIN
      ROLLBACK TRAN
      RETURN @retVal
    END
    
    INSERT INTO warnings
        ( userID, content, issuedOn, issuedBy, comment )
        values (
          @userID,
          @content,
          @issueTime,
          @issuerID,
          @comment
   	)
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
    
  COMMIT TRAN
  
END

go
IF OBJECT_ID('dbo.addWarning') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.addWarning >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.addWarning >>>'
go

/* --- archive ALL the penalties that have expired --- */
CREATE PROC archivePenalties
(
@currentTime VpTime
)
AS
BEGIN
 BEGIN TRAN

 INSERT INTO history
   SELECT * FROM penalties
   WHERE expiresOn <= @currentTime OR
         forgiven=1
 DELETE FROM penalties
   WHERE expiresOn <= @currentTime OR
         forgiven=1
 COMMIT TRAN
END

go
IF OBJECT_ID('dbo.archivePenalties') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.archivePenalties >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.archivePenalties >>>'
go

CREATE PROCEDURE autobackup
AS
BEGIN
  DUMP TRAN vpusers WITH TRUNCATE_ONLY
END
go
IF OBJECT_ID('dbo.autobackup') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.autobackup >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.autobackup >>>'
go

/* change user's email */
/* input:  user name, new email 
   output: none */
CREATE PROC changeEmail ( @nickName VPuserID, @newEmail longName )
AS
BEGIN
  /* turn all user ID to lower case, to get case insensitive comparisons */
  SELECT @nickName = lower(@nickName)
  SELECT @newEmail = lower(@newEmail)

  UPDATE registration
    SET email = @newEmail
    FROM registration, users
    WHERE users.nickName = @nickName AND
          users.userID = registration.userID AND
          users.registrationMode = 2
END

go
IF OBJECT_ID('dbo.changeEmail') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.changeEmail >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.changeEmail >>>'
go

/* change user password */
/* input:  user name, new password 
   output: none */
CREATE PROC changePassword ( @nickName VPuserID, @password VPPassword )
AS
BEGIN
  /* turn all user ID to lower case, to get case insensitive comparisons */
  SELECT @nickName = lower(@nickName)
  DECLARE @lastError int
  DECLARE @userID userIdentifier
  DECLARE @email longName
  DECLARE @oldPassword VPPassword
  
  BEGIN TRAN changePassword
    SELECT @userID = userID
      FROM users ( INDEX usersByNickNameIdx )
      WHERE ( nickName = @nickName ) AND
            ( users.registrationMode = 2 )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN changePassword
      RETURN @lastError
    END
    
    IF ( @userID IS NULL )
    BEGIN
      ROLLBACK TRAN changePassword
      RETURN
    END
    
    SELECT @oldPassword = password, @email = email
      FROM registration
      WHERE ( userID = @userID )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN changePassword
      RETURN @lastError
    END
    
    IF ( @oldPassword IS NULL ) OR 
       ( @oldPassword = @password )
    BEGIN
      /* nothing to do - return */
      ROLLBACK TRAN changePassword
      RETURN
    END
    
    /* change the password in the database to the new password */
    UPDATE registration
      SET password = @password
      WHERE ( userID = @userID )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN changePassword
      RETURN @lastError
    END
    
    /* add record for changed password */
    INSERT passwordChanges
      VALUES ( @nickName, @email, @password )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN changePassword
      RETURN @lastError
    END
    
  COMMIT TRAN changePassword  
END

go
IF OBJECT_ID('dbo.changePassword') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.changePassword >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.changePassword >>>'
go

/* check user penalties and privileges
   for a user that is registered in an auxiliary DB
         data is returned in format: 
         0/1 (privilege/penalty), type of priv./pen.

   NOTE: registration mode is saved as 3 (auxiliary) for those users
*/
CREATE PROC checkAuxUser ( @userToCheck VPuserID, @diffFromGMT int )
AS
BEGIN
  /* some constants */
  DECLARE @AUX_REG_MODE int
  DECLARE @GUEST_REG_MODE int
  DECLARE @LOCAL_REG_MODE int
  SELECT @AUX_REG_MODE = 3
  SELECT @GUEST_REG_MODE = 1
  SELECT @LOCAL_REG_MODE = 2
  
  /* turn all user ID to lower case, to get case insensitive comparisons */
  SELECT @userToCheck = lower(@userToCheck)
  DECLARE @thisTime VpTime
  DECLARE @lastError int
  
  DECLARE @userID userIdentifier
  DECLARE @password VPPassword
  
  SELECT @thisTime = dateadd( hour, (-1) * @diffFromGMT, getdate() )
  
  BEGIN TRAN checkAuxUser
    SELECT @userID = users.userID
      FROM users
      WHERE ( users.nickName = @userToCheck ) AND
            ( users.registrationMode = @AUX_REG_MODE )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN checkAuxUser
      RETURN @lastError
    END
    
    IF ( @userID IS NULL )
      /* dummy, just to create an empty result set */
      SELECT 1, penaltyType
        FROM penalties
        WHERE 1=2
    ELSE
    BEGIN
      /* @regMode != @GUEST_REG_MODE - check for privileges and penalties */
      SELECT 1, penaltyType /* 1 to indicate that this is a penalty */
        FROM penalties
        WHERE ( penalties.userID = @userID ) AND
         ( expiresOn > @thisTime )      AND
              ( forgiven = 0 )
      UNION
      SELECT 0, privilegeType /* 0 marks this as privilege */
        FROM userPrivileges
        WHERE ( userPrivileges.userID = @userID )
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRAN checkAuxUser
        RETURN @lastError
      END
    END /* IF @userID IS NOT NULL */
  COMMIT TRAN checkAuxUser
  
END

go
IF OBJECT_ID('dbo.checkAuxUser') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.checkAuxUser >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.checkAuxUser >>>'
go

/*
  check if all characters in given string match those in
  the userNameCharacters configuration key

  INPUT: * string to check
         * (optional) key to check against - default: value of
           the userNameCharacters configuration key
  OUTPUT

         : return value - 0 if all characters in the given string can be found
                           in the key
                         20001 - if a mismatch was found

*/
CREATE PROC checkCharactersMatch
(
  @string longName,
  @key longName = ""
)
AS
BEGIN


  DECLARE @lastError int
  DECLARE @loc int
  DECLARE @length int
  DECLARE @currentChar char(1)

  IF ( @key = "" )
  BEGIN
    /* key not supplied - get key from database */
    BEGIN TRAN checkCharactersMatch
      SELECT @key = strValue
        FROM configurationKeys
        WHERE keyName = "userNameCharacters"

      SELECT @lastError = @@error
      IF ( @lastError != 0 )
      BEGIN
        ROLLBACK TRAN checkCharactersMatch
        RETURN @lastError
      END
    COMMIT TRAN checkCharactersMatch

    /* now compare the strings */
    SELECT @loc = 1
    SELECT @length = char_length( @string )
    WHILE ( @loc <= @length )
    BEGIN
      SELECT @currentChar = substring( @string, @loc, 1 )
      IF ( charindex( @currentChar, @key ) = 0 )
      BEGIN
        /* character not found in key */
        RETURN 20001
      END
      SELECT @loc = @loc + 1
    END
  END
END

go
IF OBJECT_ID('dbo.checkCharactersMatch') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.checkCharactersMatch >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.checkCharactersMatch >>>'
go

/* check user penalties and privileges
   NOTE: first find the user's passowrd
         then check the user's privileges.
         data is returned in format: 
         first result set:
           password (string)
         second result set:
           0/1 (privilege/penalty), type of priv./pen. (number)
*/
CREATE PROC checkUser ( @userToCheck VPuserID, @regMode VpRegMode, @diffFromGMT int = NULL )
AS
BEGIN
  --  set isolation level to 0
  set transaction isolation level 0
  
  /* dummy table to return empty result set */
  /* original definition of type is: 
     sp_addtype VPPassword, "varchar(20)"
     can't use user-defined types in tempdb, so
     varchar(20) is used
  */
  CREATE TABLE #emptyPasswords ( password varchar(20) )
  
  /* some constants */
  DECLARE @AUX_REG_MODE int
  DECLARE @GUEST_REG_MODE int
  DECLARE @LOCAL_REG_MODE int
  SELECT @AUX_REG_MODE = 3
  SELECT @GUEST_REG_MODE = 1
  SELECT @LOCAL_REG_MODE = 2
  DECLARE @bannedName VPuserID
  
  /* turn all user ID to lower case, to get case insensitive comparisons */
  SELECT @userToCheck = lower(@userToCheck)
  DECLARE @thisTime VpTime
  DECLARE @lastError int
  
  DECLARE @userID userIdentifier
  DECLARE @password VPPassword
  
  BEGIN TRAN checkUser
    IF @diffFromGMT IS NULL
    BEGIN
      SELECT @diffFromGMT = gmt
      FROM getGMT
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRAN checkUser
        RETURN @lastError
      END
      
      IF @diffFromGMT IS NULL
        SELECT @diffFromGMT = 0
    END
    
    SELECT @thisTime = dateadd( hour, (-1) * @diffFromGMT, getdate() )
  
    
    IF @regMode = @AUX_REG_MODE
    BEGIN
      /* for methods where checking is done outside */
      SELECT "" /* dummy output on first result set */
    END
    
    IF @regMode = @LOCAL_REG_MODE /* local registration - get password */
    BEGIN
      SELECT @userID = users.userID
        FROM users (INDEX usersByNickNameIdx)
        WHERE ( registrationMode = 2) AND 
              ( nickName = @userToCheck )
  
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRAN checkUser
        RETURN @lastError
      END
      
      IF @userID IS NOT NULL
      BEGIN
        SELECT @password = password
          FROM registration
          WHERE ( userID = @userID )
                /* AND
                deleteDate IS NULL */ /* deleteDate is obsolete */
    
        SELECT @lastError = @@error
        IF @lastError != 0
        BEGIN
          ROLLBACK TRAN checkUser
          RETURN @lastError
        END
      END
      
      IF @password IS NOT NULL
      BEGIN
        SELECT @password /* to send output */
        
        -- UPDATE registration
        --   SET lastSignOnDate = @thisTime
        --   WHERE ( userID = @userID )
        -- 
        -- SELECT @lastError = @@error
        -- IF @lastError != 0
        -- BEGIN
        --   ROLLBACK TRAN checkUser
        --   RETURN @lastError
        -- END
      
      END
      ELSE
        /* need result set here - create dummy output - 
           place holder for password - use bannedNames because it's small */
        SELECT password FROM #emptyPasswords
        
      
    END /* IF @regMode = @LOCAL_REG_MODE */
    ELSE
    BEGIN
      /* @regMode != @LOCAL_REG_MODE */
      IF ( @regMode != @GUEST_REG_MODE )
      BEGIN
        /* try to find the user ID in the database,
           in case there are any penalties/privileges given to him */
        SELECT @userID = userID
          FROM users (INDEX usersByNickNameIdx)
          WHERE ( nickName = @userToCheck ) AND
                ( registrationMode = @regMode )
        
        SELECT @lastError = @@error
        IF @lastError != 0
        BEGIN
          ROLLBACK TRAN checkUser
          RETURN @lastError
        END
      END /* @regMode != @GUEST_REG_MODE */
    END /* @regMode != @LOCAL_REG_MODE */
    
    IF @regMode = @GUEST_REG_MODE /* guest - find if name is banned */
    BEGIN
      SELECT @bannedName = nickName
        FROM bannedNames
        WHERE ( substring( @userToCheck, 1, char_length(nickName) )= nickName ) AND
	      ( isBanned = 1 )
      IF @@rowcount > 0
      BEGIN
        SELECT @bannedName
      END
      ELSE /* @@rowcount = 0 */
      BEGIN
        SELECT @lastError = @@error
        IF @lastError != 0
        BEGIN
          ROLLBACK TRAN checkUser
          RETURN @lastError
        END
        
        SELECT nickName
          FROM users (INDEX usersByNickNameIdx)
          WHERE ( registrationMode = 2 ) AND
                ( nickName = @userToCheck )
        
        SELECT @lastError = @@error
        IF @lastError != 0
        BEGIN
          ROLLBACK TRAN checkUser
          RETURN @lastError
        END
      END
    END /* IF @regMode = @GUEST_REG_MODE */
    ELSE
    BEGIN
      IF ( @userID IS NULL )
      BEGIN
        /* dummy, just to create an empty result set */
        SELECT 1, penaltyType
          FROM penalties
          WHERE 1=2
      END
      ELSE
      BEGIN
        /* @userID IS NOT NULL */
        /* @regMode != @GUEST_REG_MODE - check for privileges and penalties */
        SELECT 1, penaltyType /* 1 to indicate that this is a penalty */
          FROM penalties
          WHERE ( penalties.userID = @userID ) AND
    	        ( expiresOn > @thisTime )      AND
                ( forgiven = 0 )
        UNION
        SELECT 0, privilegeType /* 0 marks this as privilege */
          FROM userPrivileges
          WHERE ( userPrivileges.userID = @userID )
        
        SELECT @lastError = @@error
        IF @lastError != 0
        BEGIN
          ROLLBACK TRAN checkUser
          RETURN @lastError
        END
      END /* @userID IS NOT NULL */
    END /* @regMode != @GUEST_REG_MODE */
  COMMIT TRAN checkUser
  
END

go
IF OBJECT_ID('dbo.checkUser') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.checkUser >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.checkUser >>>'
go

/* check user password */
/* input:  user name, time (GMT)
   output: password of user if it exists */
CREATE PROC checkUserRegistration 
( 
  @nickName VPuserID
)
AS
BEGIN
  --  set isolation level to 0
  set transaction isolation level 0
  
  /* dummy table to return empty result set */
  /* original definition of type is: 
     sp_addtype VPPassword, "varchar(20)"
     can't use user-defined types in tempdb, so
     varchar(20) is used
  */
  CREATE TABLE #emptyPasswords ( password varchar(20) )
  
  /* turn all user ID to lower case, to get case insensitive comparisons */
  SELECT @nickName = lower(@nickName)

  DECLARE @lastError int
  DECLARE @localTransaction bit
  DECLARE @diffFromGMT int
  DECLARE @currentTime smalldatetime
  DECLARE @userID userIdentifier
  DECLARE @password VPPassword
  SELECT @localTransaction = 1 - sign(@@trancount)
  
  IF @localTransaction = 1
    BEGIN TRAN checkUserRegistration
  
    SELECT @diffFromGMT = gmt
      FROM getGMT
    IF @diffFromGMT IS NULL
      SELECT @diffFromGMT = 0
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END

    SELECT @currentTime = dateadd( hour, (-1) * @diffFromGMT, getdate() )

    SELECT @userID = userID
      FROM users ( INDEX usersByNickNameIdx )
      WHERE nickName = @nickName AND
            users.registrationMode = 2
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      IF @localTransaction = 1
        ROLLBACK TRAN checkUserRegistration
      RETURN @lastError
    END
    
    IF ( @userID IS NULL )
    BEGIN
      SELECT password
      FROM #emptyPasswords
    END
    BEGIN
      SELECT password 
        FROM registration
        WHERE userID = @userID
              /* AND
              deleteDate IS NULL */ /* deleteDate is obsolete */
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        IF @localTransaction = 1
          ROLLBACK TRAN checkUserRegistration
        RETURN @lastError
      END
    END
  IF @localTransaction = 1
    COMMIT TRAN checkUserRegistration
  
END

go
IF OBJECT_ID('dbo.checkUserRegistration') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.checkUserRegistration >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.checkUserRegistration >>>'
go

/* Clear from database all records for users that either
   1) registered but did not sign on at all 
   2) have not signed on for a very long time
      (for these we only mark a delete date, not 
       do a physical deletion)
   3) had their account deleted and a certain amount of time has passed since then */
/* input:  
     number of days allowed with no sign on after registration
     number of days a deleted account stays "frozen" before its entry is removed from the database
   output: None */
CREATE PROC cleanUsers
(
  @notEnteredDeleteAfterDays smallint,
  @nonActiveDeleteAfterDays  smallint,
  @deletionGracePeriodDays   smallint
)
AS
BEGIN
  DECLARE @freezeBorderTime VpTime
  
  DECLARE @unsignedBorderTime VpTime
  DECLARE @nonactiveBorderTime VpTime
  DECLARE @lastError int
  DECLARE @diffFromGMT int
  DECLARE @currentDate VpTime
  
  BEGIN TRAN cleanUsers
    SELECT @diffFromGMT = gmt
      FROM getGMT
    IF @diffFromGMT IS NULL
      SELECT @diffFromGMT = 0
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN cleanUsers
      RETURN @lastError
    END

    SELECT @currentDate = dateadd( hour, (-1) * @diffFromGMT, getdate() )
    
    SELECT @unsignedBorderTime = dateadd( day, @notEnteredDeleteAfterDays * -1, @currentDate )
    SELECT @nonactiveBorderTime = dateadd( day, @nonActiveDeleteAfterDays * -1, @currentDate )
    SELECT @freezeBorderTime = dateadd( day, @deletionGracePeriodDays * -1, @currentDate )
    
    /* delete users that have been inactive 
       for a very long time */
    DELETE users
      FROM users, registration
      WHERE ( users.userID = registration.userID ) AND
            ( ( lastSignOnDate IS NOT NULL ) AND
              /* ( deleteDate IS NULL )         AND -- delete date is obsolete */ 
              ( lastSignOnDate < @nonactiveBorderTime ) ) AND
            ( users.userID NOT IN 
                ( SELECT DISTINCT userID
                    FROM userPrivileges  ) )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN cleanUsers
      RETURN @lastError
    END
    
    /* delete users that were registered
       but haven't entered the community at all */
    DELETE users
      FROM users, registration
      WHERE ( users.userID = registration.userID ) AND
            ( ( lastSignOnDate IS NULL ) AND
              ( registrationDate < @unsignedBorderTime ) ) AND
            ( users.userID NOT IN 
                ( SELECT DISTINCT userID
                    FROM userPrivileges  ) )
        
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN cleanUsers
      RETURN @lastError
    END
    
    /* delete date is obsolete */
    -- /* physically remove records for deleted users
    --    for which the grace period is over */
    -- DELETE users
    --   FROM registration, users
    --   WHERE ( deleteDate < @freezeBorderTime ) AND
    --         ( registration.userID = users.userID )
    -- 
    -- SELECT @lastError = @@error
    -- IF @lastError != 0
    -- BEGIN
    --   ROLLBACK TRAN cleanUsers
    --   RETURN @lastError
    -- END

  COMMIT TRAN cleanUsers
END

go
IF OBJECT_ID('dbo.cleanUsers') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.cleanUsers >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.cleanUsers >>>'
go

/* Clear from database all active penalties, historical 
   penalties and warnings records for all users, 
   either registered or others                           */
CREATE PROC clearPenalties
AS
BEGIN
  DECLARE @lastError int
  
  BEGIN TRAN
    DELETE penalties
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
    
    DELETE history
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
    
    DELETE warnings
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
  COMMIT TRAN
END

go
IF OBJECT_ID('dbo.clearPenalties') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.clearPenalties >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.clearPenalties >>>'
go

/* Clear from database all privilege records for all users, 
   either registered or others, with the excpetion
   of the Services and the vpmanager                */
CREATE PROC clearPrivileges
AS
  DELETE userPrivileges
    FROM userPrivileges, users
    WHERE ( userPrivileges.userID = users.userID )  AND
          ( ( registrationMode != 2 ) OR
            ( ( substring(nickName,1,2) != "__" ) AND
              ( nickName != "vpmanager" ) ) )

go
IF OBJECT_ID('dbo.clearPrivileges') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.clearPrivileges >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.clearPrivileges >>>'
go

/* Clear from database all records for all users, 
   either registered or others. with the excpetion
   of the Services and the vpmanager                */
CREATE PROC clearRegistration
AS
BEGIN
  DECLARE @lastError int
  
  BEGIN TRAN
    DELETE bannedNames
      WHERE nickName != "__"
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
    
    DELETE users
      WHERE ( registrationMode != 2 ) OR
            ( ( substring(nickName,1,2) != "__" ) AND
              ( nickName != "vpmanager" ) )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
    
  COMMIT TRAN
END

go
IF OBJECT_ID('dbo.clearRegistration') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.clearRegistration >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.clearRegistration >>>'
go

/* add a name to the banned names list */
/* 
  input:  nickName
  output: return value - 0 - success
                         20002 - fixed banned name can't be deleted
*/
CREATE PROC delBannedName ( @nickName VPuserID )

AS
BEGIN
  DECLARE @lastError int

  /* turn all user ID to lower case, to get case insensitive comparisons */
  SELECT @nickName = lower(@nickName)
  IF ( @nickName = "__" )
    /* can't delete service name prefix from banned names */
    RETURN 20002
  DELETE bannedNames 
      WHERE nickName = @nickName
END

go
IF OBJECT_ID('dbo.delBannedName') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.delBannedName >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.delBannedName >>>'
go

/* --- delete a privilege for a user --- */
CREATE PROC delPrivilege
(
  @nickName VPuserID,
  @regMode VpRegMode,
  @privilegeType integer
)
AS
BEGIN
 /* turn all user ID to lower case, to get case insensitive comparisons */
 SELECT @nickName = lower(@nickName)

 DELETE userPrivileges
   FROM userPrivileges, users
   WHERE userPrivileges.userID = users.userID	AND
         users.nickName = @nickName		AND
         users.registrationMode = @regMode	AND
         privilegeType = @privilegeType
END

go
IF OBJECT_ID('dbo.delPrivilege') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.delPrivilege >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.delPrivilege >>>'
go

/* delete a privilege domain for a specific user ID

   INPUT  : user ID, domain
   OUTPUT : return value - 0 - successfull
        
*/
CREATE PROC delPrivilegeDomain ( @userID userIdentifier, @domain UrlType )
AS
BEGIN
  DECLARE @lastError int
  
  BEGIN TRAN delPrivilegeDomain
    DELETE privilegeDomains
      WHERE ( userID = @userID ) AND
            ( domain = @domain )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN delPrivilegeDomain
      RETURN @lastError
    END
  COMMIT TRAN delPrivilegeDomain
END

go
IF OBJECT_ID('dbo.delPrivilegeDomain') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.delPrivilegeDomain >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.delPrivilegeDomain >>>'
go

/* delete a privilege domain for a specific user

   INPUT  : user name, domain, reg. mode (default 2)
   OUTPUT : return value - 0 - successfull
        
*/
CREATE PROC delPrivilegeDomainByName
(
  @nickName VPuserID,
  @domain UrlType,
  @regMode VpRegMode = 2
)
AS
BEGIN
  DECLARE @lastError int
  
  BEGIN TRAN delPrivilegeDomainByName
    DELETE privilegeDomains
    FROM privilegeDomains, users
      WHERE ( privilegeDomains.userID = users.userID ) AND
            ( nickName = @nickName ) AND
            ( registrationMode = @regMode ) AND
            ( domain = @domain )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN delPrivilegeDomainByName
      RETURN @lastError
    END
  COMMIT TRAN delPrivilegeDomainByName
END

go
IF OBJECT_ID('dbo.delPrivilegeDomainByName') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.delPrivilegeDomainByName >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.delPrivilegeDomainByName >>>'
go

/* delete one lcoally registered user account */
/* input:  nickName
   output: Return value - 0 - success 
                          20001 - No such user existed in database */
CREATE PROC deleteUser ( @nickName VPuserID )
AS
BEGIN
  DECLARE @lastError int
  DECLARE @diffFromGMT int
  DECLARE @currentDate VpTime
  DECLARE @userID userIdentifier
  
  SELECT @nickName = lower(@nickName)
  
  BEGIN TRAN
    SELECT @userID = userID
      FROM users
      WHERE ( nickName = @nickName ) AND
            ( registrationMode = 2 )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END

    IF @userID IS NULL
    BEGIN
      ROLLBACK TRAN
      RETURN 20001
    END
    
    DELETE userDetails
      WHERE ( userID = @userID )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
    
    DELETE users
      WHERE ( userID = @userID )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END

  COMMIT TRAN
END

go
IF OBJECT_ID('dbo.deleteUser') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.deleteUser >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.deleteUser >>>'
go

/* Check if a someone has registered 
   in the database using the given email address */
/* input: email
   output: @isRegistered parameter will be set to 1 if the user 
   with this registration mode and nick
   name is written in the database, 0 otherwise
*/
CREATE PROC emailIsRegistered
(
  @email longName,
  @isRegistered int output
)
AS
BEGIN
  SELECT @email = lower(@email)
  DECLARE @mail longName
  SELECT @isRegistered = 0
  SELECT DISTINCT @mail = email
    FROM registration
    WHERE ( email = @email )
  IF ( @mail IS NOT NULL )
  BEGIN
    SELECT @isRegistered = 1
  END
END

go
IF OBJECT_ID('dbo.emailIsRegistered') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.emailIsRegistered >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.emailIsRegistered >>>'
go

/* find password for a given email
   INPUT  : email
   OUTPUT : list of passwords from the registration table
            for entries with this email
*/
CREATE PROC findPasswordsForEmail ( @email longName )
AS
BEGIN
  --  set isolation level to 0
  set transaction isolation level 0
  
  SELECT @email = lower(@email)
  SELECT password, userID
    FROM registration ( INDEX registrationByEmailIdx )
    WHERE email = @email
END

go
IF OBJECT_ID('dbo.findPasswordsForEmail') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.findPasswordsForEmail >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.findPasswordsForEmail >>>'
go

/* find password for a given email
   INPUT  : email
   OUTPUT : list of passwords from the registration table
            for entries with this email
*/
CREATE PROC findUserPermissions
(
  @userID userIdentifier, 
  @updateSignDate bit = 1
)
AS
BEGIN
  --  set isolation level to 0
  set transaction isolation level 0
  
  DECLARE @diffFromGMT int
  DECLARE @thisTime VpTime
  DECLARE @lastError int
  
  BEGIN TRAN findUserPermissions
    
    SELECT @diffFromGMT = gmt
      FROM getGMT
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN checkUser
      RETURN @lastError
    END
    
    IF @diffFromGMT IS NULL
      SELECT @diffFromGMT = 0
    
    SELECT @thisTime = dateadd( hour, (-1) * @diffFromGMT, getdate() )
    
    SELECT 1, penaltyType /* 1 to indicate that this is a penalty */
      FROM penalties
      WHERE ( penalties.userID = @userID ) AND
            ( expiresOn > @thisTime )      AND
            ( forgiven = 0 )
    UNION
    SELECT 0, privilegeType /* 0 marks this as privilege */
      FROM userPrivileges
      WHERE ( userPrivileges.userID = @userID )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN findUserPermissions
      RETURN @lastError
    END

    -- IF ( @updateSignDate = 1 )
    -- BEGIN
    --   /* mark the sign-on in the user's registration record */
    --   UPDATE registration
    --     SET lastSignOnDate = @thisTime
    --     WHERE ( userID = @userID )
    --   
    --   SELECT @lastError = @@error
    --   IF @lastError != 0
    --   BEGIN
    --     ROLLBACK TRAN findUserPermissions
    --     RETURN @lastError
    --   END
    -- END
  COMMIT TRAN findUserPermissions
END

go
IF OBJECT_ID('dbo.findUserPermissions') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.findUserPermissions >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.findUserPermissions >>>'
go

/* --- forgive an active penalty --- */
/* this is an interface for calling from an HTML GUI */
CREATE PROC forgivePenalty
( 
  @penaltyID integer
)
AS
BEGIN
  BEGIN TRAN

  UPDATE penalties
    SET forgiven = 1
    WHERE penaltyID = @penaltyID

  COMMIT TRAN
END

go
IF OBJECT_ID('dbo.forgivePenalty') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.forgivePenalty >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.forgivePenalty >>>'
go

/* get value of one configuration value
   from the configuration keys table    */
/* input:  key name
   output: int value, strValue for that key
 */
CREATE PROC getConfigKey ( @keyName varchar(20) )
AS
  SELECT intValue, strValue
    FROM configurationKeys
    WHERE keyName = @keyName

go
IF OBJECT_ID('dbo.getConfigKey') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getConfigKey >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getConfigKey >>>'
go

/* get all configuration values 
   from the configuration keys table, 
   for one service
*/
/* input:  service ID (like VP_MT_SERV_USR for users service)
   output: 3 result sets, one for each type of parameters -
           boolean, string, number (by that order)
           for each result set, the columns are
           key ID, key value (whether integer or string)

           NOTE that boolean values are returned as integer
 */
CREATE PROC getConfiguration ( @serviceID serviceID )
AS
BEGIN
  DECLARE @lastError int
  BEGIN TRAN getConfiguration
    SELECT keyID, intValue
      FROM configurationKeys
      WHERE belongsTo = @serviceID AND
            type = 1
      ORDER BY keyID
    SELECT @lastError = @@error
    IF @lastError !=0
    BEGIN
      ROLLBACK TRAN getConfiguration
      RETURN @lastError
    END
    
    SELECT keyID, strValue
      FROM configurationKeys
      WHERE belongsTo = @serviceID AND
            type = 2
      ORDER BY keyID
    SELECT @lastError = @@error
    IF @lastError !=0
    BEGIN
      ROLLBACK TRAN getConfiguration
      RETURN @lastError
    END
    
    SELECT keyID, intValue
      FROM configurationKeys
      WHERE belongsTo = @serviceID AND
            type = 3
      ORDER BY keyID
    SELECT @lastError = @@error
    IF @lastError !=0
    BEGIN
      ROLLBACK TRAN getConfiguration
      RETURN @lastError
    END
    
  COMMIT TRAN getConfiguration
END

go
IF OBJECT_ID('dbo.getConfiguration') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getConfiguration >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getConfiguration >>>'
go

/* get the privilege domains for specific user ID

   INPUT  : user ID
   OUTPUT : list of domain names
*/
CREATE PROC getPrivilegeDomains ( @userID userIdentifier )
AS
BEGIN
  DECLARE @lastError int

  BEGIN TRAN getPrivilegeDomains
    SELECT domain
      FROM privilegeDomains
      WHERE ( userID = @userID )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN getPrivilegeDomains
      RETURN @lastError
    END
  COMMIT TRAN getPrivilegeDomains
END

go
IF OBJECT_ID('dbo.getPrivilegeDomains') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getPrivilegeDomains >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getPrivilegeDomains >>>'
go

/* get the privilege domains for specific nick name

   INPUT  : user ID
   OUTPUT : list of domain names
*/
CREATE PROC getPrivilegeDomainsByName ( @nickName VPuserID, @regMode VpRegMode = 2 )
AS
BEGIN
  DECLARE @lastError int
  
  BEGIN TRAN getPrivilegeDomainsByName
    SELECT domain
      FROM users, privilegeDomains
      WHERE ( nickName = @nickName ) AND
            ( registrationMode = @regMode ) AND
            ( privilegeDomains.userID = users.userID )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN getPrivilegeDomainsByName
      RETURN @lastError
    END
  COMMIT TRAN getPrivilegeDomainsByName
END

go
IF OBJECT_ID('dbo.getPrivilegeDomainsByName') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getPrivilegeDomainsByName >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getPrivilegeDomainsByName >>>'
go

/* get all the information on one user, by name */
/* input:  user nick name
   output: 3 result sets -
           * 1 row with email, registration date,
             last sign on date and delete date (may be null)
           * privileges for this user
           * active penalties for this user
           return value - 0 if successfull
                          20001 if no such nick name is registered
*/
CREATE PROC getRegisteredUserInfo ( @nickName VPuserID )
AS
BEGIN
  --  set isolation level to 0
  set transaction isolation level 0

  SELECT @nickName = lower(@nickName)
 
  DECLARE @lastError int
  DECLARE @userID userIdentifier
  BEGIN TRAN getRegisteredUserInfo
    SELECT @userID = userID
      FROM users (INDEX usersByNickNameIdx)
      WHERE nickName = @nickName AND
            registrationMode = 2
    
    SELECT @lastError = @@error
    IF @lastError !=0
    BEGIN
      ROLLBACK TRAN getRegisteredUserInfo
      RETURN @lastError
    END
    
    IF @userID IS NULL
    BEGIN
      ROLLBACK TRAN getRegisteredUserInfo
      RETURN 20001
    END
    
    /* show user's registration details */
    SELECT email, registrationDate, lastSignOnDate, deleteDate
      FROM registration
      WHERE userID = @userID
    
    SELECT @lastError = @@error
    IF @lastError !=0
    BEGIN
      ROLLBACK TRAN getRegisteredUserInfo
      RETURN @lastError
    END
    
    /* show user's privileges */
    SELECT description
      FROM userPrivileges, privilegeTypes
      WHERE userID = @userID AND
            userPrivileges.privilegeType = privilegeTypes.privilegeType
    
    SELECT @lastError = @@error
    IF @lastError !=0
    BEGIN
      ROLLBACK TRAN getRegisteredUserInfo
      RETURN @lastError
    END
    
    /* show user's penalties */
    SELECT description AS Penalty,
           issuedOn,
           u1.nickName AS issuer,
           u1.registrationMode AS issuerMode,
           forgiven,
           expiresOn
    FROM penalties, penaltyTypes, users u1
  WHERE penalties.penaltyType = penaltyTypes.penaltyType AND
        penalties.userID = @userID AND
        penalties.issuedBy = u1.userID
    
    SELECT @lastError = @@error
    IF @lastError !=0
    BEGIN
      ROLLBACK TRAN getRegisteredUserInfo
      RETURN @lastError
    END
    
  COMMIT TRAN getRegisteredUserInfo
END

go
IF OBJECT_ID('dbo.getRegisteredUserInfo') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getRegisteredUserInfo >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getRegisteredUserInfo >>>'
go

/* get demographic details for specified user

   INPUT  : user ID
   OUTPUT : all details for that user (list to long to
            put it here)
            return value - 0 if successfull
                           20001 if matching user not found
*/

CREATE PROC getUserDetails ( @userID userIdentifier )
AS
BEGIN
  DECLARE @lastError int
  DECLARE @tmpBit int

  BEGIN TRAN getUserDetails
    
    SELECT @tmpBit = showEmail
      FROM userDetails
      WHERE userID = @userID
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN getUserDetails
    END
    
    IF @tmpBit IS NULL
    BEGIN
      ROLLBACK TRAN getUserDetails
      RETURN 20001
    END
    
    SELECT
	nickName,
	email,
	firstName,
	lastName,
	age,
	gender,
	city,
	state,
	country,
	zipcode,
	profession,
	company,
	motto,
	homePage,
  	income,
  	education,
  	maritalStatus,
  	children,
  	employment,
  	timeOnline,
  	accessFrequency,
  	bandwidth,
  	accessFromHome,
  	accessFromWork,
  	accessFromSchool,
  	beenInTalk,
	wantsNewsletter,
	
	cb_relationships,
	cb_electronics,
	cd_cars,
	cb_travel,
	cb_movies,
	cb_gardening,
	cb_business,
	cb_music,
	cb_home,
	cb_investing,
	cb_tv,
	cb_current,
	cb_family,
	cb_sports,
	cb_computers,
	cb_science,
	cb_literature,
	cb_arts,
	
	showInList,
	showEmail,
	showFirstName,
	showLastName,
	showAge,
	showGender,
	showCity,
	showState,
	showCountry,
	showZipcode,
	showBio,
	showProfession,
	showEducation,
	showEmployment,
	showCompany,
	showMotto,
	showHomePage
      FROM users, registration, userDetails
      WHERE ( users.userID = @userID ) AND
            ( userDetails.userID = @userID ) AND
            ( registration.userID = @userID )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN getUserDetails
    END
  COMMIT TRAN getUserDetails
END

go
IF OBJECT_ID('dbo.getUserDetails') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getUserDetails >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getUserDetails >>>'
go

/* get the user ID for a specified nick name
   of a registered user

   INPUT  : nick name, user ID (output parameter)
   OUTPUT : userID parameter will be set to the user ID of the 
            matching registered user, or 0 if there is no such user
*/

CREATE PROC getUserID ( @nickName VPuserID, @userID userIdentifier OUTPUT )
AS
BEGIN
  DECLARE @lastError int
  SELECT @userID = 0

  BEGIN TRAN getUserID
    SELECT @userID = userID
      FROM users
      WHERE ( nickName = @nickName )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN getUserID
    END
  COMMIT TRAN getUserID
END

go
IF OBJECT_ID('dbo.getUserID') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getUserID >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getUserID >>>'
go

/* find userID for a given email
   INPUT  : email
   OUTPUT : list of passwords from the registration table
            for entries with this email
*/
CREATE PROC getUserIdByEmail ( @email longName )
AS
BEGIN
  SELECT @email = lower(@email)
  SELECT users.userID, nickName
    FROM registration, users
    WHERE ( email = @email ) AND
          ( registrationMode = 2 ) AND
          ( registration.userID = users.userID )
END

go
IF OBJECT_ID('dbo.getUserIdByEmail') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getUserIdByEmail >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getUserIdByEmail >>>'
go

/* Check if a specific user has the requested privilege in the database */
/* input: name, privilege type
   output: @@isPrivileged parameter will be set to 1 if the user 
   has that privilege, 0 otherwise
*/
CREATE PROC isPrivileged
(
  @@name	VPuserID,
  @@privType privType,
  @@isPrivileged int output
)
AS
SELECT @@isPrivileged = count(*)
  FROM users, userPrivileges
  WHERE ( users.userID = userPrivileges.userID) AND
        ( users.nickName = @@name ) AND
        ( users.registrationMode = 2) AND
        ( userPrivileges.privilegeType = @@privType)

go
IF OBJECT_ID('dbo.isPrivileged') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.isPrivileged >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.isPrivileged >>>'
go

/* Check if a specific user is registered in the database */
/* input: name, registration mode
   output: @isRegistered parameter will be set to 1 if the user 
   with this registration mode and nick
   name is written in the database, 0 otherwise
*/
CREATE PROC isRegistered
(
  @name	VPuserID,
  @regMode VpRegMode,
  @isRegistered int output
)
AS
SELECT @isRegistered = count(*)
  FROM users
  WHERE ( nickName = @name ) AND
        ( registrationMode = @regMode )

go
IF OBJECT_ID('dbo.isRegistered') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.isRegistered >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.isRegistered >>>'
go

/* --- add a penalty for a user --- */
/* this is an interface for calling from an HTML GUI,
   so it just receives some parameters and uses them
   to call addPenalty. 
   NOTE: local DATABASE SERVER time is used (GMT is better) */
/* 
  output : return value - same as addPenaltyToUser
*/
CREATE PROC penalize
( 
  @nickName VPuserID,
  @regMode VpRegMode,
  @penaltyDescription varchar(30),
  @minutesDuration integer,
  @issuedBy VPuserID, 
  @issuerRegMode VpRegMode,
  @comment varchar(255) 
)
AS
BEGIN
  DECLARE @penaltyType integer
  DECLARE @allowAuxAsLocal bit
  DECLARE @lastError int
  DECLARE @retVal int
  
  SELECT @nickName = lower(@nickName)
  
  BEGIN TRAN penalize
    SELECT @penaltyType = penaltyType FROM penaltyTypes
      WHERE description = @penaltyDescription
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN penalize
      RETURN @lastError
    END
    
    SELECT @allowAuxAsLocal = 0
    SELECT @allowAuxAsLocal = intValue
      FROM configurationKeys
      WHERE ( keyName = "auxDbAllowed" )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
    
    EXEC @retVal =
      addPenaltyToUser @nickName, @regMode, 
                       @penaltyType, @minutesDuration, 
                       @issuedBy, @issuerRegMode, 
                       @comment, @allowAuxAsLocal
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN penalize
      RETURN @lastError
    END
    
    IF @retVal != 0
    BEGIN
      ROLLBACK TRAN penalize
      RETURN @retVal
    END
    
  COMMIT TRAN penalize
END

go
IF OBJECT_ID('dbo.penalize') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.penalize >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.penalize >>>'
go

/* show the details of one penalty (active or expired) --- */
/* this is an interface for calling from an HTML GUI */
CREATE PROC penaltyDetails
(
  @penaltyID integer
)
AS
BEGIN
  SELECT users.nickName, users.registrationMode, 
         expiresOn, issuedOn, 
         u1.nickName AS whoIssued, u1.registrationMode AS issuerMode, 
         forgiven, comment
    FROM penalties, users, users u1
    WHERE penalties.penaltyID = @penaltyID AND
          penalties.userID = users.userID  AND
          penalties.issuedBy = u1.userID
  UNION
  SELECT users.nickName, users.registrationMode, 
         expiresOn, issuedOn, 
         u1.nickName AS whoIssued, u1.registrationMode AS issuerMode, 
         forgiven, comment
    FROM history, users, users u1
    WHERE history.penaltyID = @penaltyID AND
          history.userID = users.userID  AND
          history.issuedBy = u1.userID
END

go
IF OBJECT_ID('dbo.penaltyDetails') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.penaltyDetails >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.penaltyDetails >>>'
go

/* --- do all periodic maintenance,
       to be initiated from the users service --- */
CREATE PROC periodicCheck
(
  @notEnteredDeleteAfter smallint,
  @nonActiveDeleteAfter smallint,
  @deletionGracePeriod smallint
)
AS
BEGIN

  /* check for expired/forgiven penalties, archive and notify what they are */
  EXEC refreshPenalties
END

go
IF OBJECT_ID('dbo.periodicCheck') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.periodicCheck >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.periodicCheck >>>'
go

/* find all new passwords that were changed in the last interval */
CREATE PROC refreshPasswords
AS
BEGIN
  DECLARE @lastError int
  
  BEGIN TRAN refreshPasswords
    /* first find all the passwords that were changed */
    SELECT DISTINCT nickName, email, password
      FROM passwordChanges
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN refreshPasswords
      RETURN @lastError
    END
    
    /* now delete all the password changes records */
    DELETE passwordChanges
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN refreshPasswords
      RETURN @lastError
    END
    
  COMMIT TRAN refreshPasswords
END

go
IF OBJECT_ID('dbo.refreshPasswords') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.refreshPasswords >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.refreshPasswords >>>'
go

/* find all penalties that have expired in the last interval */
CREATE PROC refreshPenalties
AS
BEGIN
  DECLARE @currentTimeValue VpTime
 
  DECLARE @lastError int
  DECLARE @diffFromGMT int
  DECLARE @issueTime VpTime
  
  BEGIN TRAN
    SELECT @diffFromGMT = intValue
      FROM configurationKeys
      WHERE keyName = "diffFromGMT"
    IF @diffFromGMT IS NULL
      SELECT @diffFromGMT = 0
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
    
    SELECT @issueTime = dateadd( hour, (-1) * @diffFromGMT, getdate() )
    
    /* show all the penalties for each user, with value to mark the expired penalties:
       -1 or 0 means expiry of penalty */
    /* forgiven field may recieve value of 0 (FALSE) or 1 (TRUE) - if its TRUE,
       then penalty is considered expired */
    SELECT nickName, registrationMode, penaltyType
      FROM penalties, users
      WHERE ( users.userID = penalties.userID ) AND
            ( ( expiresOn <= @issueTime ) OR
              ( forgiven=1 ) )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
    
    EXEC archivePenalties @issueTime
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
    
  COMMIT TRAN
END

go
IF OBJECT_ID('dbo.refreshPenalties') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.refreshPenalties >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.refreshPenalties >>>'
go

/* add a new service - register, add prefix "__" and set the needed privilege */
/* input:  service name, password, required privilege (number)
   output: return value -
           negative value - DB failure, 
           0 - success,
           20001 - user name already in DB
*/
CREATE PROC registerNewService
( 
  @nickName VPuserID,
  @password VPPassword,
  @privilegeType privType
)
AS
BEGIN
  DECLARE @lastError int
  DECLARE @oldUser userIdentifier
  
  /* turn all user ID to lower case, to get case insensitive comparisons */
  SELECT @nickName = lower(@nickName)

  BEGIN TRAN  
    /* find if there exists a user with that name */
    SELECT @oldUser = userID
      FROM users
      WHERE ( nickName = "__" + @nickName ) AND
            ( registrationMode = 2 )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
    
    IF @oldUser IS NOT NULL
    BEGIN
      ROLLBACK TRAN
      RETURN 20001
    END
  COMMIT TRAN
  
  EXEC registerNewUser @nickName,@nickName,@password

  BEGIN TRAN  
    /* add prefix "__" to service name */
    UPDATE users
      SET nickName = "__" + nickName
      WHERE ( nickName = @nickName ) AND
            ( registrationMode = 2 )
    SELECT @nickName = "__" + @nickName
      
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
  COMMIT TRAN

  EXEC addPrivilege @nickName, 2, @privilegeType
END

go
IF OBJECT_ID('dbo.registerNewService') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.registerNewService >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.registerNewService >>>'
go

/* add a new user */
/* input:  user name, user's email address, password (optional)
   output: return value -
           negative value - DB failure, 
           0 - success,
           20001 - exceeded number of permitted accounts per email
           20002 - user name already in DB
           20003 - user name is banned  */
CREATE PROC registerNewUser
( 
  @nickName VPuserID,
  @email longName,
  @password VPPassword = NULL
)
AS
BEGIN
  SELECT @email = lower(@email)
  DECLARE @localMode integer
  SELECT @localMode = 2
  DECLARE @accountsPermitted integer
  DECLARE @diffFromGMT int
  DECLARE @currentDate VpTime
  DECLARE @buddyListName VPuserID
  DECLARE @buddyListNameMask VPuserID
  DECLARE @maxAutoName VPuserID
  DECLARE @nextAutoNumber int
  DECLARE @accountsForEmail integer
  DECLARE @newUserID userIdentifier
  DECLARE @lastError int
  
  SELECT @buddyListName = "bdylist"
  SELECT @buddyListNameMask = @buddyListName + "%"
  
  /* turn all user ID to lower case, to get case insensitive comparisons */
  SELECT @nickName = lower(@nickName)
  SELECT @nickName = ltrim(@nickName)
  IF ( @nickName LIKE @buddyListNameMask )
  BEGIN
    -- banned name - "bdylist" is reserved for nick names
    -- to be automatically given to buddy list users
    RETURN 20003
  END
  

  BEGIN TRAN registerNewUser
    SELECT @diffFromGMT = gmt
      FROM getGMT
    IF @diffFromGMT IS NULL
      SELECT @diffFromGMT = 0
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN registerNewUser
      RETURN @lastError
    END

    SELECT @currentDate = dateadd( hour, (-1) * @diffFromGMT, getdate() )
    
    IF char_length(@nickName) > 0
    BEGIN
      /* check if name is banned */
      IF EXISTS 
        ( SELECT nickName FROM bannedNames 
            WHERE substring( @nickName, 1, char_length(nickName) )= nickName )
      BEGIN
        COMMIT TRAN registerNewUser
        RETURN 20003
      END
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRAN registerNewUser
        RETURN @lastError
      END
      
      IF EXISTS 
        ( SELECT nickName 
            FROM users
            WHERE ( nickName = @nickName ) AND
                  ( registrationMode = 2 )     )
      BEGIN
        COMMIT TRAN registerNewUser
        RETURN 20002
      END
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRAN registerNewUser
        RETURN @lastError
      END
      
    END
    ELSE
    BEGIN
      /* empty nick name - 
         make a name for the user */
      SELECT @nextAutoNumber = 
        max( convert( int, 
                      substring( nickName, 
                                 char_length(@buddyListName)+1,
                                 20 ) ) ) /* hopefully, 20 digits will cover */
        FROM users
        WHERE ( nickName LIKE @buddyListNameMask ) AND
              ( registrationMode = 2 )
      IF @nextAutoNumber IS NULL
        SELECT @nextAutoNumber = 1
      ELSE
      BEGIN
        /* find the number */
        SELECT @nextAutoNumber = @nextAutoNumber + 1
      END
      SELECT @nickName = @buddyListName + ltrim(str(@nextAutoNumber))
    END
    SELECT @accountsPermitted = intValue
      FROM configurationKeys
      WHERE keyName = "maxAccountsPerEmail"
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN registerNewUser
      RETURN @lastError
    END
    
    SELECT @accountsForEmail = count(*) 
      FROM registration
      WHERE ( email = @email )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN registerNewUser
      RETURN @lastError
    END
    
    IF @accountsForEmail >= @accountsPermitted
    BEGIN
    COMMIT TRAN registerNewUser
      RETURN 20001
    END
    ELSE
    BEGIN
      /* OK to insert user to DB */
      INSERT users ( nickName, registrationMode )
        VALUES ( @nickName, @localMode )
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRAN registerNewUser
        RETURN @lastError
      END
      
      SELECT @newUserID = @@identity
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRAN registerNewUser
        RETURN @lastError
      END
      
      INSERT INTO registration
        ( userID, email, password, registrationDate ) 
        VALUES ( @newUserID, @email, @password, @currentDate )
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRAN registerNewUser
        RETURN @lastError
      END
      
      SELECT @newUserID
    END
    /* returns 0 if successful, negative value otherwise */
  COMMIT TRAN registerNewUser
END

go
IF OBJECT_ID('dbo.registerNewUser') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.registerNewUser >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.registerNewUser >>>'
go

/* remove deleted users, allowing X days 
   from deletion to actual removal */
/* input:  allowed number of days since deletion
   output: NONE                                  */
CREATE PROC removeDeletedUsers 
( 
  @daysToWait integer
)
AS
BEGIN
  DECLARE @lastError int
  DECLARE @diffFromGMT int
  DECLARE @currentDate VpTime
  DECLARE @deleteBeforeDate VpTime
  DECLARE @localTransaction bit
  SELECT @localTransaction = 1 - sign(@@trancount)
  
  IF @localTransaction = 1
    BEGIN TRAN removeDeletedUsers
    
    SELECT @diffFromGMT = gmt
      FROM getGMT
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN /* NOTE: --> */
      /* name of transaction is not specified,
         for the case where the procedure is 
         called from inside another transaction. */
      
      RETURN @lastError
    END

    IF @diffFromGMT IS NULL
      SELECT @diffFromGMT = 0
    SELECT @currentDate = dateadd( hour, (-1) * @diffFromGMT, getdate() )
    SELECT @deleteBeforeDate = dateadd( day, (-1) * @daysToWait, @currentDate )
    
    DELETE registration
      WHERE deleteDate <= @deleteBeforeDate
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
    
    DELETE FROM users
      WHERE registrationMode = 2 AND
            nickName NOT IN 
              ( SELECT nickName
                  FROM registeredNames )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END

  IF @localTransaction = 1
    COMMIT TRAN removeDeletedUsers
END

go
IF OBJECT_ID('dbo.removeDeletedUsers') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.removeDeletedUsers >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.removeDeletedUsers >>>'
go

/* rename a banned name */
/* input:  old banned name, new banned name
   output: return value - 
           0 - success,
           20001 - if old name is not in the list,
           20002 - if new name is same as old name
           20003 - if new name is already in the list
           20004 - fixed banned name can't be deleted
*/
CREATE PROC renameBannedName ( @oldBannedName VPuserID, @newBannedName VPuserID )

AS
BEGIN
  DECLARE @lastError int
  DECLARE @oldName VPuserID
  DECLARE @newName VPuserID
  
  /* fixed banned name can't be deleted */
  IF ( @oldBannedName = "__" )
    RETURN 20004
  
  /* turn all user ID to lower case, to get case insensitive comparisons */
  SELECT @oldBannedName = lower(@oldBannedName)
  SELECT @newBannedName = lower(@newBannedName)
  IF ( @oldBannedName = @newBannedName )
    RETURN 20002

  BEGIN TRAN renameBannedName
    /* try to find the old name in the list */
    SELECT @oldName = nickName
      FROM bannedNames
      WHERE ( nickName = @oldBannedName )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN renameBannedName
      RETURN @lastError
    END
    
    IF ( @oldName IS NULL )
    BEGIN
      /* name not in list */
      ROLLBACK TRAN renameBannedName
      RETURN 20001
    END
    
    /* try to find the new name in the list */
    SELECT @newName = nickName
      FROM bannedNames
      WHERE ( nickName = @newBannedName )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN renameBannedName
      RETURN @lastError
    END
    
    IF ( @newName IS NOT NULL )
    BEGIN
      /* name not in list */
      ROLLBACK TRAN renameBannedName
      RETURN 20003
    END
    
    /* do the renaming */
    UPDATE bannedNames
      SET nickName = @newBannedName
      WHERE ( nickName = @oldBannedName )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN renameBannedName
      RETURN @lastError
    END
    
  COMMIT TRAN renameBannedName
END

go
IF OBJECT_ID('dbo.renameBannedName') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.renameBannedName >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.renameBannedName >>>'
go

/* set the value of one configuration value
   in the configuration keys table    */
/* input:  key name, s
   output: int value, strValue for that key
 */
CREATE PROC setConfigKey
(
 @keyName varchar(20),
 @intVal int = NULL,
 @strVal varchar(255) = NULL
)
AS
  /* set the value of one configurtion key */
  /* input:  keyName, int value (optional), str value (optional)
     output: None */
UPDATE configurationKeys
  SET intValue = @intVal,
      strValue = @strVal
  WHERE keyName = @keyName

go
IF OBJECT_ID('dbo.setConfigKey') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.setConfigKey >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.setConfigKey >>>'
go

/* update demographic details for specified user
   if no user details records exists for this user,
   it will be created.

   INPUT  : all details for that user (list to long to
            put it here)
   OUTPUT : return value - 0 if successfull
                           20001 if no matching registered user was found
*/

CREATE PROC setUserDetails
(
  @userID		userIdentifier,
  @firstName		varchar(30),
  @lastName		varchar(50),
  @age			tinyInt,
  @gender		bit,
  @city			varchar(30),
  @state		varchar(30),
  @country		char(2),
  @zipcode		varchar(25),
  @profession		smallInt,
  @company		varchar(30),
  @motto		varchar(50),
  @homePage		varchar(200),
  @income		smallInt,
  @education		tinyInt,
  @maritalStatus	tinyInt,
  @children		tinyInt,
  @employment		smallInt,
  @timeOnline		tinyInt,
  @accessFrequency	tinyInt,
  @bandwidth		tinyInt,
  @accessFromHome	bit,
  @accessFromWork	bit,
  @accessFromSchool	bit,
  @beenInTalk		bit,
  @wantsNewsletter	bit,

  @cb_relationships	bit,
  @cb_electronics	bit,
  @cd_cars		bit,
  @cb_travel		bit,
  @cb_movies		bit,
  @cb_gardening		bit,
  @cb_business		bit,
  @cb_music		bit,
  @cb_home		bit,
  @cb_investing		bit,
  @cb_tv		bit,
  @cb_current		bit,
  @cb_family		bit,
  @cb_sports		bit,
  @cb_computers		bit,
  @cb_science		bit,
  @cb_literature	bit,
  @cb_arts		bit,

  @showInList		bit,
  @showEmail		bit,
  @showFirstName	bit,
  @showLastName		bit,
  @showAge		bit,
  @showGender		bit,
  @showCity		bit,
  @showState		bit,
  @showCountry		bit,
  @showZipcode		bit,
  @showBio		bit,
  @showProfession	bit,
  @showEducation	bit,
  @showEmployment	bit,
  @showCompany		bit,
  @showMotto		bit,
  @showHomePage		bit
)
AS
BEGIN
  DECLARE @lastError int
  DECLARE @dummy longName
  DECLARE @detailsRecordExists bit

  BEGIN TRAN setUserDetails
    
    SELECT @dummy = email
      FROM registration
      WHERE userID = @userID
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN setUserDetails
      RETURN @lastError
    END
    
    IF @dummy IS NULL
    BEGIN
      ROLLBACK TRAN setUserDetails
      RETURN 20001
    END
    
    SELECT @detailsRecordExists = count(*)
      FROM userDetails
      WHERE userID = @userID
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN setUserDetails
      RETURN @lastError
    END
    
    IF @detailsRecordExists = 1
    BEGIN
      /* record already exists - update it */
      UPDATE userDetails
        SET
          firstName        = @firstName,
          lastName         = @lastName,
          age              = @age,
          gender           = @gender,
          city             = @city,
          state            = @state,
          country          = @country,
          zipcode          = @zipcode,
          profession       = @profession,
          company          = @company,
          motto            = @motto,
          homePage         = @homePage,
          income           = @income,
          education        = @education,
          maritalStatus    = @maritalStatus,
          children         = @children,
          employment       = @employment,
          timeOnline       = @timeOnline,
          accessFrequency  = @accessFrequency,
          bandwidth        = @bandwidth,
          accessFromHome   = @accessFromHome,
          accessFromWork   = @accessFromWork,
          accessFromSchool = @accessFromSchool,
          beenInTalk       = @beenInTalk,
          wantsNewsletter  = @wantsNewsletter,

          cb_relationships = @cb_relationships,
          cb_electronics   = @cb_electronics,
          cd_cars          = @cd_cars,
          cb_travel        = @cb_travel,
          cb_movies        = @cb_movies,
          cb_gardening     = @cb_gardening,
          cb_business      = @cb_business,
          cb_music         = @cb_music,
          cb_home          = @cb_home,
          cb_investing     = @cb_investing,
          cb_tv            = @cb_tv,
          cb_current       = @cb_current,
          cb_family        = @cb_family,
          cb_sports        = @cb_sports,
          cb_computers     = @cb_computers,
          cb_science       = @cb_science,
          cb_literature    = @cb_literature,
          cb_arts          = @cb_arts,

          showInList       = @showInList,
          showEmail        = @showEmail,
          showFirstName    = @showFirstName,
          showLastName     = @showLastName,
          showAge          = @showAge,
          showGender       = @showGender,
          showCity         = @showCity,
          showState        = @showState,
          showCountry      = @showCountry,
          showZipcode      = @showZipcode,
          showBio          = @showBio,
          showProfession   = @showProfession,
          showEducation    = @showEducation,
          showEmployment   = @showEmployment,
          showCompany      = @showCompany,
          showMotto        = @showMotto,
          showHomePage     = @showHomePage,
          upperFirst       = UPPER( @firstName),
          upperLast        = UPPER( @lastName)
        FROM userDetails
        WHERE userID = @userID
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRAN setUserDetails
        RETURN @lastError
      END
    END /* record already exists - update it */
    ELSE
    BEGIN
      /* record does not exist - create it */
      INSERT userDetails
        VALUES
        (
          @userID,
          @firstName,
          @lastName,
          @age,
          @gender,
          @city,
          @state,
          @country,
          @zipcode,
          @profession,
          @company,
          @motto,
          @homePage,
          @income,
          @education,
          @maritalStatus,
          @children,
          @employment,
          @timeOnline,
          @accessFrequency,
          @bandwidth,
          @accessFromHome,
          @accessFromWork,
          @accessFromSchool,
          @beenInTalk,
          @wantsNewsletter,

          @cb_relationships,
          @cb_electronics,
          @cd_cars,
          @cb_travel,
          @cb_movies,
          @cb_gardening,
          @cb_business,
          @cb_music,
          @cb_home,
          @cb_investing,
          @cb_tv,
          @cb_current,
          @cb_family,
          @cb_sports,
          @cb_computers,
          @cb_science,
          @cb_literature,
          @cb_arts,

          @showInList,
          @showEmail,
          @showFirstName,
          @showLastName,
          @showAge,
          @showGender,
          @showCity,
          @showState,
          @showCountry,
          @showZipcode,
          @showBio,
          @showProfession,
          @showEducation,
          @showEmployment,
          @showCompany,
          @showMotto,
          @showHomePage,
	  UPPER( @firstName ),
	  UPPER( @lastName )
        )
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRAN setUserDetails
        RETURN @lastError
      END
    END /* record does not exist - create it */
    
  COMMIT TRAN setUserDetails
END

go
IF OBJECT_ID('dbo.setUserDetails') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.setUserDetails >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.setUserDetails >>>'
go

/* display all users in registration table */
/* input:  NONE
   output: list of all entries in registration table */
CREATE PROC showAllUsers
AS
BEGIN
  SELECT users.nickName, registration.*
    FROM registration, users
    WHERE registration.userID = users.userID
    ORDER BY nickName
END

go
IF OBJECT_ID('dbo.showAllUsers') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.showAllUsers >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.showAllUsers >>>'
go

/* display all names from the banned names table 
   that are marked as words to filter */
/* input:  NONE
   output: list of all entries in the table */
CREATE PROC showBannedAndFiltered
AS
BEGIN
  SELECT nickName, isBanned, isFiltered
    FROM bannedNames
    WHERE ( nickName != "__" )
    ORDER BY nickName
END

go
IF OBJECT_ID('dbo.showBannedAndFiltered') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.showBannedAndFiltered >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.showBannedAndFiltered >>>'
go

/* display all names from the banned names table
   that are marked as words to filter */
/* input:  NONE
   output: list of all entries in the table */
CREATE PROC showFilteredWords
AS
BEGIN
  SELECT nickName
    FROM bannedNames
    WHERE ( isFiltered = 1 ) AND
          ( nickName != "__" )
    ORDER BY nickName
END

go
IF OBJECT_ID('dbo.showFilteredWords') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.showFilteredWords >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.showFilteredWords >>>'
go

/* show names of all users with host privilege, sorted by user name --- */
/* this stored procedure is meant to be called from the audset database */
CREATE PROC showHosts
AS
  SELECT nickName, registrationMode
    FROM userPrivileges, users
    WHERE userPrivileges.userID = users.userID AND
          userPrivileges.privilegeType = 273

go
IF OBJECT_ID('dbo.showHosts') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.showHosts >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.showHosts >>>'
go

/* find password for a given email
   INPUT  : email
   OUTPUT : list of nicknames and passwords
            for entries with this email
*/
CREATE PROC showNicknamesForEmail ( @email longName )
AS
BEGIN
  SELECT @email = lower(@email)
  SELECT nickName, password
    FROM registration, users
    WHERE ( email = @email ) AND
          ( registration.userID = users.userID )
END

go
IF OBJECT_ID('dbo.showNicknamesForEmail') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.showNicknamesForEmail >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.showNicknamesForEmail >>>'
go

/* --- show all penalties (active and expired) and warnings for all users --- */
/* this is an interface for calling from an HTML GUI */
CREATE PROC showPenalties
( 
  @showPen bit,
  @showWarn bit,
  @showExpired bit,
  @sortBy varchar(20) /* currently ignored */
)
AS
BEGIN
  /* make it case insensitive */
  /*
  SELECT @sortBy = upper(@sortBy)
  */

  DECLARE @lastError int
  DECLARE @diffFromGMT int
  DECLARE @now smalldatetime
  
  BEGIN TRAN
    SELECT @diffFromGMT = gmt
      FROM getGMT
    IF @diffFromGMT IS NULL
      SELECT @diffFromGMT = 0
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END

    SELECT @now = dateadd( hour, (-1) * @diffFromGMT, getdate() )

    /* ------------------------ 1 ------------------------ */
    IF ( ( @showPen = 1 ) AND ( @showWarn = 1 ) AND ( @showExpired = 1 ) )
    BEGIN
      SELECT Id, Name, Mode,
             Penalty, issuedOn AS "Issued On", 
             issuer AS "Issued By", issuerMode AS "Reg.Mode",
             ( (1-forgiven) * 
               (sign(sign(datediff(minute,@now,expiresOn))-1)+1))
               AS "In Effect"
        FROM penaltiesWithNames
      UNION
      SELECT Id, Name, Mode,
             Penalty, issuedOn AS "Issued On", 
             issuer AS "Issued By", issuerMode AS "Reg.Mode",
             0 AS "In Effect"
        FROM historyWithNames
      UNION
      SELECT Id, Name, Mode,
          "Warn" AS Penalty,
          issuedOn AS "Issued On", 
          issuer AS "Issued By", issuerMode AS "Reg.Mode",
          0 AS "In Effect"
        FROM warningsWithNames
        ORDER BY Name
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRAN
        RETURN @lastError
      END
      COMMIT TRAN
      RETURN
    END
  
    /* ------------------------ 2 ------------------------ */
    IF ( ( @showPen = 1 ) AND ( @showWarn = 1 ) )
    BEGIN
      SELECT Id, Name, Mode,
             Penalty, issuedOn AS "Issued On", 
             issuer AS "Issued By", issuerMode AS "Reg.Mode",
             1 AS "In Effect"
        FROM penaltiesWithNames
        WHERE NOT ( ( forgiven = 1 ) OR ( @now > expiresOn ) )
      UNION
      SELECT Id, Name, Mode,
          "Warn" AS Penalty,
          issuedOn AS "Issued On", 
          issuer AS "Issued By", issuerMode AS "Reg.Mode",
          0 AS "In Effect"
        FROM warningsWithNames
      ORDER BY Name
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRAN
        RETURN @lastError
      END
      COMMIT TRAN
      RETURN
    END
  
    /* ------------------------ 3 ------------------------ */
    IF ( ( @showPen = 1 ) AND ( @showExpired = 1 ) )
    BEGIN
      SELECT Id, Name, Mode,
             Penalty, issuedOn AS "Issued On", 
             issuer AS "Issued By", issuerMode AS "Reg.Mode",
             ( (1-forgiven) * 
               (sign(sign(datediff(minute,@now,expiresOn))-1)+1))
               AS "In Effect"
        FROM penaltiesWithNames
      UNION
      SELECT Id, Name, Mode,
             Penalty, issuedOn AS "Issued On", 
             issuer AS "Issued By", issuerMode AS "Reg.Mode",
             0 AS "In Effect"
        FROM historyWithNames
      ORDER BY Name
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRAN
        RETURN @lastError
      END
      COMMIT TRAN
      RETURN
    END
  
    /* ------------------------ 4 ------------------------ */
    IF ( ( @showWarn = 1 ) AND ( @showExpired = 1 ) )
    BEGIN
      SELECT Id, Name, Mode,
             Penalty, issuedOn AS "Issued On", 
             issuer AS "Issued By", issuerMode AS "Reg.Mode",
             0 AS "In Effect"
        FROM penaltiesWithNames
        WHERE ( ( forgiven = 1 ) OR ( @now > expiresOn ) )
      UNION
      SELECT Id, Name, Mode,
          "Warn" AS Penalty,
          issuedOn AS "Issued On", 
          issuer AS "Issued By", issuerMode AS "Reg.Mode",
          0 AS "In Effect"
        FROM warningsWithNames
      ORDER BY Name
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRAN
        RETURN @lastError
      END
      COMMIT TRAN
      RETURN
    END
  
    /* ------------------------ 5 ------------------------ */
    IF @showPen = 1
    BEGIN
      SELECT Id, Name, Mode,
             Penalty, issuedOn AS "Issued On", 
             issuer AS "Issued By", issuerMode AS "Reg.Mode",
             1 AS "In Effect"
        FROM penaltiesWithNames
        WHERE NOT ( ( forgiven = 1 ) OR ( @now > expiresOn ) )
        ORDER BY Name
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRAN
        RETURN @lastError
      END
      COMMIT TRAN
      RETURN
    END
  
    /* ------------------------ 6 ------------------------ */
    IF @showWarn = 1
    BEGIN
      SELECT Id, Name, Mode,
          "Warn" AS Penalty,
          issuedOn AS "Issued On", 
          issuer AS "Issued By", issuerMode AS "Reg.Mode",
          0 AS "In Effect"
        FROM warningsWithNames
      ORDER BY Name
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRAN
        RETURN @lastError
      END
      COMMIT TRAN
      RETURN
    END
  
    /* ------------------------ 7 ------------------------ */
    IF @showExpired = 1
    BEGIN
      SELECT Id, Name, Mode,
             Penalty, issuedOn AS "Issued On", 
             issuer AS "Issued By", issuerMode AS "Reg.Mode",
             0 AS "In Effect"
        FROM penaltiesWithNames
        WHERE ( ( forgiven = 1 ) OR ( @now > expiresOn ) )
      UNION
      SELECT Id, Name, Mode,
             Penalty, issuedOn AS "Issued On", 
             issuer AS "Issued By", issuerMode AS "Reg.Mode",
             0 AS "In Effect"
        FROM historyWithNames
      ORDER BY Name
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRAN
        RETURN @lastError
      END
      COMMIT TRAN
      RETURN
    END

  COMMIT TRAN
END

go
IF OBJECT_ID('dbo.showPenalties') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.showPenalties >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.showPenalties >>>'
go

/* --- show all penalties (active and expired) and warnings for all users --- */
/* this is an interface for calling from an HTML GUI */
/* Customized for Excite by Tom Lang 1/1999 */
CREATE PROC showPenaltiesOnDate
( 
  @when smalldatetime,
  @sortBy int 
 
	 ,
  @diffFromGMT int
)
AS
BEGIN
  /* sortBy 
  	1 = victim
	2 = date/time
	3 = host
  */

  DECLARE @lastError int
  DECLARE @now smalldatetime
  DECLARE @start smalldatetime
  DECLARE @end smalldatetime
  
    IF @diffFromGMT IS NULL
      SELECT @diffFromGMT = 0
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END

    SELECT @now = dateadd( hour, (-1) * @diffFromGMT, getdate() )
    SELECT @start = dateadd( hour, (-1) * @diffFromGMT,  
 
	 @when )
    SELECT @end = dateadd( hour, 24, @start )

    /* ------------------------ sort by victim ------------------------ */
    IF ( @sortBy = 1 )
    BEGIN
      SELECT Name, 
             Penalty, 
             dateadd( hour, (@diffFromGMT), issuedOn) AS "Issued On", 
             issuer AS "Issued By", 
             ( (1-forgiven) * 
               (sign(sign(datediff(minute,@now,expiresOn))-1)+1))
               AS "In Effect"
        FROM penaltiesWithNames
	WHERE issuedOn >= @start
	AND issuedOn <= @end
	 
      UNION
      SELECT Name, 
             Penalty, 
             dateadd( hour, (@diffFromGMT), issuedOn) AS "Issued On", 
             issuer AS "Issued By", 
             0 AS "In Effect"
        FROM historyWithNames
	WHERE issuedOn >= @start
	AND issuedOn <= @end
        ORDER BY Name
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRAN
        RETURN @lastError
      END
      COMMIT TRAN
      RETURN
    END

    /* ----------------------- 
 
	 - sort by date/time  ------------------------ */
    IF ( @sortBy = 2 )
    BEGIN
      SELECT Name, 
             Penalty, 
             dateadd( hour, (@diffFromGMT), issuedOn) AS "Issued On", 
             issuer AS "Issued By", 
             ( (1-forgiven) * 
               (sign(sign(datediff(minute,@now,expiresOn))-1)+1))
               AS "In Effect"
        FROM penaltiesWithNames
	WHERE issuedOn >= @start
	AND issuedOn <= @end
      UNION
      SELECT Name, 
             Penalty, 
             dateadd( hour, (@diffFromGMT), issuedOn) AS "Issued On", 
             issuer AS "Issued By", 
             0 AS "In Effect"
        FROM historyWithNames
	WHERE issuedOn >= @start
	AND issuedOn <= @end
        ORDER BY dateadd( hour, (@diffFromGMT), issuedOn) 
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRAN
        RETURN @lastError
      END
      COMMIT TRAN
      RETURN
    END

    /* ------------------------ sort by host ------------------------ */
  
 
	    IF ( @sortBy = 3 )
    BEGIN
      SELECT Name, 
             Penalty, 
             dateadd( hour, (@diffFromGMT), issuedOn) AS "Issued On", 
             issuer AS "Issued By", 
             ( (1-forgiven) * 
               (sign(sign(datediff(minute 
 
	 ,@now,expiresOn))-1)+1))
               AS "In Effect"
        FROM penaltiesWithNames
	WHERE issuedOn >= @start
	AND issuedOn <= @end
      UNION
      SELECT Name, 
             Penalty, 
             dateadd( hour, (@diffFromGMT), issuedOn) AS "Issued  On", 
             issuer AS "Issued By", 
             0 AS "In Effect"
        FROM historyWithNames
	WHERE issuedOn >= @start
	AND issuedOn <= @end
        ORDER BY issuer
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
   
 
	       ROLLBACK TRAN
        RETURN @lastError
      END
      COMMIT TRAN
      RETURN
    END
  

  COMMIT TRAN
END

go
IF OBJECT_ID('dbo.showPenaltiesOnDate') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.showPenaltiesOnDate >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.showPenaltiesOnDate >>>'
go

/* --- show all privileges, sorted by user and privilege type --- */
/* this is an interface for calling from an HTML GUI */
CREATE PROC showPrivileges
( 
  /* get list of privilege types to be shown,
     as string with names of types separarted by commas */
  @typesRequested varchar(255)
)
AS
BEGIN
  
  IF @typesRequested = "*"
  BEGIN
    /* show everything */
    SELECT * 
      FROM privilegesWithNames
      ORDER BY Name, Mode, Privilege
  END
  ELSE BEGIN
    /* find what privilege types to show */
    /* parse list */
    CREATE TABLE #typesToGet ( description varchar(30) )
    DECLARE @description varchar(30)
    DECLARE @commaPos integer
    WHILE ( ascii( rtrim(ltrim(@typesRequested ))) > 32 ) BEGIN
      SELECT @commaPos = patindex( "%,%", @typesRequested )
      IF @commaPos = 0 BEGIN
        SELECT @description = rtrim(ltrim(@typesRequested))
        SELECT @typesRequested = ""
      END
      ELSE BEGIN
        SELECT @description = rtrim( ltrim( substring( @typesRequested, 1, @commaPos-1 ) ) )
        SELECT @typesRequested = 
          substring( @typesRequested, 
                     @commaPos+1, 
                     char_length( @typesRequested ) - @commaPos )
      END
      INSERT INTO #typesToGet VALUES ( @description )
    END
    SELECT privilegesWithNames.*
      FROM privilegesWithNames, #typesToGet
      WHERE Privilege = #typesToGet.description
      ORDER BY Name, Mode, Privilege
  END  

END

go
IF OBJECT_ID('dbo.showPrivileges') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.showPrivileges >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.showPrivileges >>>'
go

/* display all registered users with email matching a given wildcard expression */
/* input:  wildcard expression
   output: list of all matching emails, with nicknames and userID) 
*/
CREATE PROC showUsersByMatchingEmail ( @@wildcard longName )
AS
BEGIN
  DECLARE @@convertedWildcard longName
  DECLARE @@pos tinyint
  DECLARE @@length tinyint
  DECLARE @@currentChar varchar(1)
  /* first, convert wildcard to sybase wildcard syntax */
  
  SELECT @@convertedWildcard = ltrim("")
  SELECT @@pos = 1
  SELECT @@length = char_length( @@wildcard )
  
  WHILE @@pos <= @@length
  BEGIN
    SELECT @@currentChar = substring( @@wildcard, @@pos, 1 )
    SELECT @@pos = @@pos + 1
  
    /* change "%" to "#%" */
    IF ( @@currentChar = "%" )
    BEGIN
      SELECT @@convertedWildcard = @@convertedWildcard + "#%"
      CONTINUE
    END
  
    /* change "_" to "#_" */
    IF ( @@currentChar = "_" )
    BEGIN
      SELECT @@convertedWildcard = @@convertedWildcard + "#_"
      CONTINUE
    END
  
    /* change "*" to "%" */
    IF ( @@currentChar = "*" )
    BEGIN
      SELECT @@convertedWildcard = @@convertedWildcard + "%"
      CONTINUE
    END
  
    /* change "?" to "_" */
    IF ( @@currentChar = "?" )
    BEGIN
      SELECT @@convertedWildcard = @@convertedWildcard + "_"
      CONTINUE
    END
  
    /* any other character is just appnded as is */
    SELECT @@convertedWildcard = @@convertedWildcard + @@currentChar
  END
  
  /* now find the matches */
  SELECT nickName, email, users.userID
    FROM users, registration
    WHERE ( users.userID = registration.userID ) AND
          ( registrationMode = 2 ) AND
          ( email LIKE @@convertedWildcard ESCAPE "#" )

END

go
IF OBJECT_ID('dbo.showUsersByMatchingEmail') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.showUsersByMatchingEmail >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.showUsersByMatchingEmail >>>'
go

/* display all users in with names starting with a given prefix */
/* input:  prefix, registration mode (default=2)
   output: list of all matching nicknames (with userID) */
CREATE PROC showUsersByPrefix ( @prefix VPuserID, @registrationMode int = 2 )
AS
BEGIN
  SELECT nickName, userID
    FROM users
    WHERE ( registrationMode = @registrationMode ) AND
          ( nickName like ( @prefix + "%" ) )
END

go
IF OBJECT_ID('dbo.showUsersByPrefix') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.showUsersByPrefix >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.showUsersByPrefix >>>'
go

/* display all users with names matching a given wildcard expression */
/* input:  wildcard expression, registration mode (default=2)
   output: list of all matching nicknames (with userID) 
*/
CREATE PROC showUsersByRegexp ( @@wildcard VPuserID, @@registrationMode int = 2 )
AS
BEGIN
  DECLARE @@convertedWildcard VPuserID
  DECLARE @@pos tinyint
  DECLARE @@length tinyint
  DECLARE @@currentChar varchar(1)
  /* first, convert wildcard to sybase wildcard syntax */
  
  SELECT @@convertedWildcard = ltrim("")
  SELECT @@pos = 1
  SELECT @@length = char_length( @@wildcard )
  
  WHILE @@pos <= @@length
  BEGIN
    SELECT @@currentChar = substring( @@wildcard, @@pos, 1 )
    SELECT @@pos = @@pos + 1
  
    /* change "%" to "#%" */
    IF ( @@currentChar = "%" )
    BEGIN
      SELECT @@convertedWildcard = @@convertedWildcard + "#%"
      CONTINUE
    END
  
    /* change "_" to "#_" */
    IF ( @@currentChar = "_" )
    BEGIN
      SELECT @@convertedWildcard = @@convertedWildcard + "#_"
      CONTINUE
    END
  
    /* change "*" to "%" */
    IF ( @@currentChar = "*" )
    BEGIN
      SELECT @@convertedWildcard = @@convertedWildcard + "%"
      CONTINUE
    END
  
    /* change "?" to "_" */
    IF ( @@currentChar = "?" )
    BEGIN
      SELECT @@convertedWildcard = @@convertedWildcard + "_"
      CONTINUE
    END
  
    /* any other character is just appnded as is */
    SELECT @@convertedWildcard = @@convertedWildcard + @@currentChar
  END
  
  /* now find the matches */
  SELECT nickName, userID
    FROM users
    WHERE ( registrationMode = @@registrationMode ) AND
          ( nickName LIKE @@convertedWildcard ESCAPE "#" )

END

go
IF OBJECT_ID('dbo.showUsersByRegexp') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.showUsersByRegexp >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.showUsersByRegexp >>>'
go

/* --- show all penalties (active and expired) and warnings for all users --- */
/* this is an interface for calling from an HTML GUI */
CREATE PROC showWarnings
( 
  @when smalldatetime,
  @sortBy int,
  @diffFromGMT int
)
AS
BEGIN
  /* sortBy 
  	1 = victim
	2 = date/time
	3 = host
  */

  DECLARE @lastError int
  DECLARE @start smalldatetime
  DECLARE @end smalldatetime
  
  BEGIN TRAN
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END

    SELECT @start = dateadd( hour, (-1) * (@diffFromGMT), @when )
    SELECT @end = dateadd( hour, 24, @start )

    /* ------------------------ sort by victim ------------------------ */
    IF ( @sortBy = 1 )
    BEGIN
      SELECT warningsWithNames.Name, 
          dateadd( hour, (@diffFromGMT), warnings.issuedOn) AS "Issued On", 
          warningsWithNames.issuer AS "Issued By",
	  content
        FROM warningsWithNames,warnings
	WHERE warningsWithNames.issuedOn >= @start 
          AND warningsWithNames.issuedOn < @end
	  AND Id=warnings.warningID
      ORDER BY warningsWithNames.Name
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRAN
        RETURN @lastError
      END
      COMMIT TRAN
      RETURN
    END

    /* ------------------------ sort by date/time  ------------------------ */
    IF ( @sortBy = 2 )
    BEGIN
      SELECT warningsWithNames.Name, 
          dateadd( hour, (@diffFromGMT), warnings.issuedOn) AS "Issued On", 
          warningsWithNames.issuer AS "Issued By",
	  content
        FROM warningsWithNames,warnings
	WHERE warningsWithNames.issuedOn >= @start 
          AND warningsWithNames.issuedOn < @end
	  AND Id=warnings.warningID
      ORDER BY warningsWithNames.issuedOn
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRAN
        RETURN @lastError
      END
      COMMIT TRAN
      RETURN
    END

    /* ------------------------ sort by host ------------------------ */
    IF ( @sortBy = 3 )
    BEGIN
      SELECT warningsWithNames.Name, 
          dateadd( hour,(@diffFromGMT), warnings.issuedOn) AS "Issued On", 
          warningsWithNames.issuer AS "Issued By",
	  content
        FROM warningsWithNames,warnings
	WHERE warningsWithNames.issuedOn >= @start 
          AND warningsWithNames.issuedOn < @end
	  AND Id=warnings.warningID
      ORDER BY warningsWithNames.issuer
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRAN
        RETURN @lastError
      END
      COMMIT TRAN
      RETURN
    END
  
  COMMIT TRAN
END

go
IF OBJECT_ID('dbo.showWarnings') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.showWarnings >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.showWarnings >>>'
go

/* update flags for a name in the banned names list */
/* input:  nickName, is it banned, is it filtered
   output: return value - 
           0 - success,
           20001 - if name is not in the list
*/
CREATE PROC updateBannedName ( @nickName VPuserID, @isBanned bit = 1, @isFiltered bit = 1 )

AS
BEGIN
  DECLARE @lastError int
  DECLARE @oldName VPuserID

  /* turn all user ID to lower case, to get case insensitive comparisons */
  SELECT @nickName = lower(@nickName)
  BEGIN TRAN updateBannedName
    /* try to find this name in the list */
    SELECT @oldName = nickName
      FROM bannedNames
      WHERE ( nickName = @nickName )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN updateBannedName
      RETURN @lastError
    END
    
    IF ( @oldName IS NULL )
    BEGIN
      /* name not in list */
      ROLLBACK TRAN updateBannedName
      RETURN 20001
    END
    
    /* try to update it if it already exists */
    UPDATE bannedNames
      SET isBanned = @isBanned,
          isFiltered = @isFiltered
      WHERE ( nickName = @nickName )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN updateBannedName
      RETURN @lastError
    END
    
  COMMIT TRAN updateBannedName
END

go
IF OBJECT_ID('dbo.updateBannedName') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.updateBannedName >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.updateBannedName >>>'
go

/* update a privilege domain name for a specific user ID

   INPUT  : user ID, old domain name, new domain name
   OUTPUT : return value - 0 - successfull
                           -4 - trying to rename domain to a name that already exists
                                for this user
        
*/
CREATE PROC updatePrivilegeDomain
(
  @userID userIdentifier,
  @oldDomain UrlType,
  @newDomain UrlType
)
AS
BEGIN
  DECLARE @lastError int
  
  BEGIN TRAN delPrivilegeDomain
    UPDATE privilegeDomains
      SET domain = @newDomain
      WHERE ( userID = @userID ) AND
            ( domain = @oldDomain )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN delPrivilegeDomain
      RETURN @lastError
    END
  COMMIT TRAN delPrivilegeDomain
END

go
IF OBJECT_ID('dbo.updatePrivilegeDomain') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.updatePrivilegeDomain >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.updatePrivilegeDomain >>>'
go

/* --- show all privileges, sorted by user and privilege type --- */
/* this is an interface for calling from an HTML GUI */
/* it is therefor assumed that no privilege will be
   included both in the privileges to add and the privileges
   to delete lists. */
/* 
   INPUT : nick name of user, registration mode of user,
           privileges to add - as string, comma-separated list
           privileges to delete - string, comma-separated list
   OUTPUT: Return Value - 0 - Success
                          20001 - trying to add privilege for 
                              non-registered user in 
                              local registration mode
 */
CREATE PROC updatePrivileges
( 
  @nickName VPuserID,          /* name of user to update privileges for */
  @regMode VpRegMode,          /* registration mode of user */
  @privsToAdd varchar(255), /* comma-separated list of privilege to be added */
  @privsToDel varchar(255)  /* comma-separated list of privilege to be deleted */
)
AS
BEGIN
  DECLARE @lastError int
  DECLARE @retVal int
  DECLARE @userID userIdentifier
  DECLARE @description varchar(30)
  DECLARE @commaPos integer
  DECLARE @counter integer
  DECLARE @auxAsLocalAllowed bit
  DECLARE @auxDbAddress longName
  
  /* turn all user ID to lower case, to get case insensitive comparisons */
  SELECT @nickName = lower(@nickName)
  
  CREATE TABLE #privsToAdd ( description varchar(30), counter integer )
  CREATE TABLE #privsToDel ( description varchar(30) )
  BEGIN TRAN
  
    /* first load the names of the privilege types 
       into the temporary tables                   */
  
    /* find what privilege types to add */
    /* parse list */
    SELECT @counter = 0
    WHILE ( ascii( rtrim(ltrim(@privsToAdd ))) > 32 ) BEGIN
      SELECT @commaPos = patindex( "%,%", @privsToAdd )
      IF @commaPos = 0 BEGIN
        SELECT @description = rtrim(ltrim(@privsToAdd))
        SELECT @privsToAdd = ""
      END
      ELSE BEGIN
        SELECT @description = rtrim( ltrim( substring( @privsToAdd, 1, @commaPos-1 ) ) )
        SELECT @privsToAdd = substring( @privsToAdd, @commaPos+1, char_length( @privsToAdd ) - @commaPos )
      END
      INSERT INTO #privsToAdd VALUES ( @description, @counter )
      
      SELECT @lastError = @@error
      IF @lastError !=0
      BEGIN
        ROLLBACK TRAN
        RETURN @lastError
      END
      
      SELECT @counter = @counter + 1
    END /* of WHILE */
  
    /* find what privilege types to delete */
    /* parse list */
    WHILE ( ascii( rtrim(ltrim(@privsToDel ))) > 32 ) BEGIN
      SELECT @commaPos = patindex( "%,%", @privsToDel )
      IF @commaPos = 0 BEGIN
        SELECT @description = rtrim(ltrim(@privsToDel))
        SELECT @privsToDel = ""
      END
      ELSE BEGIN
        SELECT @description = rtrim( ltrim( substring( @privsToDel, 1, @commaPos-1 ) ) )
        SELECT @privsToDel = substring( @privsToDel, @commaPos+1, char_length( @privsToDel ) - @commaPos )
      END
      INSERT INTO #privsToDel VALUES ( @description )
      
      SELECT @lastError = @@error
      IF @lastError !=0
      BEGIN
        ROLLBACK TRAN
        RETURN @lastError
      END
      
    END /* of WHILE */
    
    SELECT @auxDbAddress = ""
    SELECT @auxDbAddress = strValue
      FROM configurationKeys
      WHERE ( keyName = "auxDbAddress" )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END

    IF @auxDbAddress = ""
      SELECT @auxAsLocalAllowed = 0
    ELSE
      SELECT @auxAsLocalAllowed = 1
    
    /* find the given user's user ID,
       adding him if necessary        */
    EXEC @retVal =
      updateUser @userID OUTPUT, @nickName, @regMode, @auxAsLocalAllowed
    
    SELECT @lastError = @@error
    IF @lastError !=0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
    
    IF @userID = 0
    BEGIN
      ROLLBACK TRAN
      RETURN 20001
    END
      
    IF ( @retVal NOT IN ( 20001, 0 ) )
    BEGIN
      ROLLBACK TRAN
      RETURN @retVal
    END
  
    /* now eliminate privileges that are already
       in or out, depending on the respective list */
    DELETE FROM #privsToAdd
      WHERE description IN
        ( SELECT description
            FROM userPrivileges,privilegeTypes
            WHERE userID = @userID AND 
                  userPrivileges.privilegeType = privilegeTypes.privilegeType )
    
    SELECT @lastError = @@error
    IF @lastError !=0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
    
    DELETE FROM #privsToDel
      WHERE description NOT IN
        ( SELECT description
            FROM userPrivileges,privilegeTypes
            WHERE userID = @userID AND 
                  userPrivileges.privilegeType = privilegeTypes.privilegeType )
    
    SELECT @lastError = @@error
    IF @lastError !=0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
    
    /* delete privileges for the user */
    DELETE FROM userPrivileges
      WHERE userID = @userID AND
            privilegeType IN 
            ( SELECT privilegeType 
                FROM #privsToDel,privilegeTypes
                WHERE privilegeTypes.description = #privsToDel.description )
    
    SELECT @lastError = @@error
    IF @lastError !=0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END

    /* add privileges for the user */
    INSERT userPrivileges ( userID, privilegeType )
      SELECT @userID, privilegeType
        FROM #privsToAdd,privilegeTypes
          WHERE privilegeTypes.description = #privsToAdd.description
    
    SELECT @lastError = @@error
    IF @lastError !=0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
    
  COMMIT TRAN
END

go
IF OBJECT_ID('dbo.updatePrivileges') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.updatePrivileges >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.updatePrivileges >>>'
go

/* get name and registration mode of user,
  add to users table if necessary          --- */
/* input: user ID (passed "by name"-for output), 
          user name, registration mode,
          allow Aux as local (optional - default = FALSE)
   output: return value -
             0 - added the user
             20001 - user already existed
             20002 - can't add user in local reg.mode
                     (unless @allowAuxAsLocal = TRUE)
           in User ID parameter -
             0 - in case user was not found,
             otherwise the ID for the matching user
*/
CREATE PROC updateUser
( 
  @userID userIdentifier OUTPUT,
  @userName VPuserID, 
  @regMode VpRegMode,
  @allowAuxAsLocal bit = 0
)
AS
BEGIN
  DECLARE @lastError int
  DECLARE @localTransaction bit
  SELECT @userID = 0
  
  SELECT @localTransaction =  1 - sign( @@trancount )
  
  IF ( @localTransaction = 1 )
    BEGIN TRAN updateUser
    
    IF ( ( @allowAuxAsLocal = 1 ) AND
         ( @regMode = 2 ) )

    BEGIN
      /* for the case where usage of auxiliary registration
         database is allowed, check to see if user exists
         with either local registration mode or 
         auxiliary regitration mode */
      SELECT @userID = userID
        FROM users
        WHERE ( nickName = @userName ) AND
              ( registrationMode IN (2,3) )
    END
    ELSE
    BEGIN
      /* do normal test to see if user exists in users table */
      SELECT @userID = userID
        FROM users
        WHERE ( nickName = @userName ) AND
              ( registrationMode = @regMode )
    END
      
    SELECT @lastError = @@error
    IF ( @lastError != 0 )
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
    
    IF ( @userID > 0 )
    BEGIN
      /* user already exists in the database -
         Return status 20001 marks this */
      IF @localTransaction = 1
        COMMIT TRAN updateUser
      RETURN 20001
    END
    
    IF ( ( @userID = 0 )  AND 
         ( @regMode = 2 )     )
    BEGIN
      IF ( @allowAuxAsLocal = 0 )
      BEGIN
        IF @localTransaction = 1
          ROLLBACK TRAN updateUser
        RETURN 20002
      END
      ELSE
      BEGIN
        /* let user be recorded as auxiliary registered */
        SELECT @regMode = 3
      END
    END
    
    INSERT users ( nickName, registrationMode )
      VALUES ( @userName, @regMode )

    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END

    SELECT @userID = @@identity
    
  IF @localTransaction = 1
    COMMIT TRAN updateUser

END

go
IF OBJECT_ID('dbo.updateUser') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.updateUser >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.updateUser >>>'
go

/* show the details of one warning --- */
/* this is an interface for calling from an HTML GUI */
CREATE PROC warningDetails
( 
  @warningID integer
)
AS
BEGIN
  SELECT users.nickName, users.registrationMode, 
         content, issuedOn, 
         u1.nickName AS whoIssued, u1.registrationMode AS issuerMode, 
         comment
    FROM warnings, users, users u1
    WHERE warnings.warningID = @warningID AND
          warnings.userID = users.userID  AND
          warnings.issuedBy = u1.userID
END

go
IF OBJECT_ID('dbo.warningDetails') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.warningDetails >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.warningDetails >>>'
go


--
-- CREATE TRIGGERS
--
/* delete all data related to a user
   after that user was deleted */
CREATE TRIGGER delUserData
  ON users
  FOR DELETE
AS
BEGIN
  DECLARE @lastError int
  
  /* delete related registration */
  DELETE registration
  FROM registration, deleted
  WHERE registration.userID = deleted.userID
  
  SELECT @lastError = @@error
  IF @lastError != 0
  BEGIN
    ROLLBACK TRAN
  END
  
  
  /* delete related privileges */
  DELETE userPrivileges
  FROM userPrivileges, deleted
  WHERE userPrivileges.userID = deleted.userID
  
  SELECT @lastError = @@error
  IF @lastError != 0
  BEGIN
    ROLLBACK TRAN
  END
  
  /* delete related privilege domains */
  DELETE privilegeDomains
  FROM privilegeDomains, deleted
  WHERE privilegeDomains.userID = deleted.userID
  
  SELECT @lastError = @@error
  IF @lastError != 0
  BEGIN
    ROLLBACK TRAN
  END
  
  /* delete related penalties */
  DELETE penalties
  FROM penalties, deleted
  WHERE penalties.userID = deleted.userID
  
  SELECT @lastError = @@error
  IF @lastError != 0
  BEGIN
    ROLLBACK TRAN
  END
  
  /* delete related history */
  DELETE history
  FROM history, deleted
  WHERE history.userID = deleted.userID
  
  SELECT @lastError = @@error
  IF @lastError != 0
  BEGIN
    ROLLBACK TRAN
  END
  
  /* delete related warnings */
  DELETE warnings
  FROM warnings, deleted
  WHERE warnings.userID = deleted.userID
  
  SELECT @lastError = @@error
  IF @lastError != 0
  BEGIN
    ROLLBACK TRAN
  END
  
END
go
IF OBJECT_ID('delUserData') IS NOT NULL
    PRINT '<<< CREATED TRIGGER delUserData >>>'
ELSE
    PRINT '<<< FAILED CREATING TRIGGER delUserData >>>'
go

GRANT REFERENCES ON dbo.bannedNames TO public
go
GRANT REFERENCES ON dbo.configurationKeys TO public
go
GRANT REFERENCES ON dbo.history TO public
go
GRANT REFERENCES ON dbo.penalties TO public
go
GRANT REFERENCES ON dbo.penaltyTypes TO public
go
GRANT REFERENCES ON dbo.privilegeTypes TO public
go
GRANT REFERENCES ON dbo.registration TO public
go
GRANT REFERENCES ON dbo.passwordChanges TO public
go
GRANT REFERENCES ON dbo.privilegeDomains TO public
go
GRANT SELECT ON dbo.sysobjects TO public
go
GRANT SELECT ON dbo.sysobjects(id) TO public
go
GRANT SELECT ON dbo.sysobjects(uid) TO public
go
GRANT SELECT ON dbo.sysobjects(name) TO public
go
GRANT SELECT ON dbo.sysobjects(type) TO public
go
GRANT SELECT ON dbo.sysobjects(cache) TO public
go
GRANT SELECT ON dbo.sysobjects(crdate) TO public
go
GRANT SELECT ON dbo.sysobjects(ckfirst) TO public
go
GRANT SELECT ON dbo.sysobjects(deltrig) TO public
go
GRANT SELECT ON dbo.sysobjects(expdate) TO public
go
GRANT SELECT ON dbo.sysobjects(instrig) TO public
go
GRANT SELECT ON dbo.sysobjects(seltrig) TO public
go
GRANT SELECT ON dbo.sysobjects(sysstat) TO public
go
GRANT SELECT ON dbo.sysobjects(updtrig) TO public
go
GRANT SELECT ON dbo.sysobjects(indexdel) TO public
go
GRANT SELECT ON dbo.sysobjects(objspare) TO public
go
GRANT SELECT ON dbo.sysobjects(sysstat2) TO public
go
GRANT SELECT ON dbo.sysobjects(userstat) TO public
go
GRANT SELECT ON dbo.sysobjects(schemacnt) TO public
go
GRANT SELECT ON dbo.sysindexes TO public
go
GRANT SELECT ON dbo.syscolumns TO public
go
GRANT SELECT ON dbo.systypes TO public
go
GRANT SELECT ON dbo.sysprocedures TO public
go
GRANT SELECT ON dbo.syscomments TO public
go
GRANT SELECT ON dbo.syssegments TO public
go
GRANT SELECT ON dbo.syslogs TO public
go
GRANT SELECT ON dbo.sysprotects TO public
go
GRANT SELECT ON dbo.sysusers TO public
go
GRANT SELECT ON dbo.sysalternates TO public
go
GRANT SELECT ON dbo.sysdepends TO public
go
GRANT SELECT ON dbo.syskeys TO public
go
GRANT SELECT ON dbo.sysusermessages TO public
go
GRANT SELECT ON dbo.sysreferences TO public
go
GRANT SELECT ON dbo.sysconstraints TO public
go
GRANT SELECT ON dbo.sysattributes TO public
go
GRANT SELECT ON dbo.getGMT TO public
go
GRANT SELECT ON dbo.historyWithNames TO public
go
GRANT SELECT ON dbo.hosts TO public
go
GRANT SELECT ON dbo.penaltiesWithNames TO public
go
GRANT SELECT ON dbo.privilegesWithNames TO public
go
GRANT SELECT ON dbo.registeredNames TO public
go
GRANT SELECT ON dbo.warningsWithNames TO public
go
GRANT SELECT ON dbo.bannedNames TO public
go
GRANT SELECT ON dbo.configurationKeys TO public
go
GRANT SELECT ON dbo.history TO public
go
GRANT SELECT ON dbo.penalties TO public
go
GRANT SELECT ON dbo.penaltyTypes TO public
go
GRANT SELECT ON dbo.privilegeTypes TO public
go
GRANT SELECT ON dbo.registration TO public
go
GRANT SELECT ON dbo.passwordChanges TO public
go
GRANT SELECT ON dbo.privilegeDomains TO public
go
GRANT INSERT ON dbo.getGMT TO public
go
GRANT INSERT ON dbo.historyWithNames TO public
go
GRANT INSERT ON dbo.hosts TO public
go
GRANT INSERT ON dbo.penaltiesWithNames TO public
go
GRANT INSERT ON dbo.privilegesWithNames TO public
go
GRANT INSERT ON dbo.registeredNames TO public
go
GRANT INSERT ON dbo.warningsWithNames TO public
go
GRANT INSERT ON dbo.bannedNames TO public
go
GRANT INSERT ON dbo.configurationKeys TO public
go
GRANT INSERT ON dbo.history TO public
go
GRANT INSERT ON dbo.penalties TO public
go
GRANT INSERT ON dbo.penaltyTypes TO public
go
GRANT INSERT ON dbo.privilegeTypes TO public
go
GRANT INSERT ON dbo.registration TO public
go
GRANT INSERT ON dbo.passwordChanges TO public
go
GRANT INSERT ON dbo.privilegeDomains TO public
go
GRANT DELETE ON dbo.getGMT TO public
go
GRANT DELETE ON dbo.historyWithNames TO public
go
GRANT DELETE ON dbo.hosts TO public
go
GRANT DELETE ON dbo.penaltiesWithNames TO public
go
GRANT DELETE ON dbo.privilegesWithNames TO public
go
GRANT DELETE ON dbo.registeredNames TO public
go
GRANT DELETE ON dbo.warningsWithNames TO public
go
GRANT DELETE ON dbo.bannedNames TO public
go
GRANT DELETE ON dbo.configurationKeys TO public
go
GRANT DELETE ON dbo.history TO public
go
GRANT DELETE ON dbo.penalties TO public
go
GRANT DELETE ON dbo.penaltyTypes TO public
go
GRANT DELETE ON dbo.privilegeTypes TO public
go
GRANT DELETE ON dbo.registration TO public
go
GRANT DELETE ON dbo.passwordChanges TO public
go
GRANT DELETE ON dbo.privilegeDomains TO public
go
GRANT UPDATE ON dbo.getGMT TO public
go
GRANT UPDATE ON dbo.historyWithNames TO public
go
GRANT UPDATE ON dbo.hosts TO public
go
GRANT UPDATE ON dbo.penaltiesWithNames TO public
go
GRANT UPDATE ON dbo.privilegesWithNames TO public
go
GRANT UPDATE ON dbo.registeredNames TO public
go
GRANT UPDATE ON dbo.warningsWithNames TO public
go
GRANT UPDATE ON dbo.bannedNames TO public
go
GRANT UPDATE ON dbo.configurationKeys TO public
go
GRANT UPDATE ON dbo.history TO public
go
GRANT UPDATE ON dbo.penalties TO public
go
GRANT UPDATE ON dbo.penaltyTypes TO public
go
GRANT UPDATE ON dbo.privilegeTypes TO public
go
GRANT UPDATE ON dbo.registration TO public
go
GRANT UPDATE ON dbo.passwordChanges TO public
go
GRANT UPDATE ON dbo.privilegeDomains TO public
go
GRANT EXECUTE ON dbo.getConfiguration TO public
go
GRANT EXECUTE ON dbo.isRegistered TO public
go
GRANT EXECUTE ON dbo.isPrivileged TO public
go
GRANT EXECUTE ON dbo.autobackup TO public
go
