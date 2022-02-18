--------------------------------------------------------------------------------
-- DBArtisan Schema Extraction
-- TARGET DB:
-- 	vpplaces
--------------------------------------------------------------------------------

--
-- Target Database: vpplaces
--

USE vpplaces
go

--
-- DROP INDEXES
--
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.PersistentPTGlist') AND name='persistentPTGIdx')
BEGIN
    DROP INDEX PersistentPTGlist.persistentPTGIdx
    IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.PersistentPTGlist') AND name='persistentPTGIdx')
        PRINT '<<< FAILED DROPPING INDEX PersistentPTGlist.persistentPTGIdx >>>'
    ELSE
        PRINT '<<< DROPPED INDEX PersistentPTGlist.persistentPTGIdx >>>'
END
go

IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.persistentPlacesChange') AND name='PPlaceChangesIdx')
BEGIN
    DROP INDEX persistentPlacesChange.PPlaceChangesIdx
    IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.persistentPlacesChange') AND name='PPlaceChangesIdx')
        PRINT '<<< FAILED DROPPING INDEX persistentPlacesChange.PPlaceChangesIdx >>>'
    ELSE
        PRINT '<<< DROPPED INDEX persistentPlacesChange.PPlaceChangesIdx >>>'
END
go

IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.placeUsage') AND name='placeUsageIdx')
BEGIN
    DROP INDEX placeUsage.placeUsageIdx
    IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.placeUsage') AND name='placeUsageIdx')
        PRINT '<<< FAILED DROPPING INDEX placeUsage.placeUsageIdx >>>'
    ELSE
        PRINT '<<< DROPPED INDEX placeUsage.placeUsageIdx >>>'
END
go

IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.placeUsage') AND name='placeUsageByTimeIdx')
BEGIN
    DROP INDEX placeUsage.placeUsageByTimeIdx
    IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.placeUsage') AND name='placeUsageByTimeIdx')
        PRINT '<<< FAILED DROPPING INDEX placeUsage.placeUsageByTimeIdx >>>'
    ELSE
        PRINT '<<< DROPPED INDEX placeUsage.placeUsageByTimeIdx >>>'
END
go


--
-- DROP PROCEDURES
--
IF OBJECT_ID('dbo.addCategory') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.addCategory
    IF OBJECT_ID('dbo.addCategory') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.addCategory >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.addCategory >>>'
END
go

IF OBJECT_ID('dbo.addPPtgItem') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.addPPtgItem
    IF OBJECT_ID('dbo.addPPtgItem') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.addPPtgItem >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.addPPtgItem >>>'
END
go

IF OBJECT_ID('dbo.addPersistentPlace') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.addPersistentPlace
    IF OBJECT_ID('dbo.addPersistentPlace') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.addPersistentPlace >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.addPersistentPlace >>>'
END
go

IF OBJECT_ID('dbo.addPlaceToCategory') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.addPlaceToCategory
    IF OBJECT_ID('dbo.addPlaceToCategory') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.addPlaceToCategory >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.addPlaceToCategory >>>'
END
go

IF OBJECT_ID('dbo.addPlaceType') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.addPlaceType
    IF OBJECT_ID('dbo.addPlaceType') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.addPlaceType >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.addPlaceType >>>'
END
go

IF OBJECT_ID('dbo.addPlaceUsage') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.addPlaceUsage
    IF OBJECT_ID('dbo.addPlaceUsage') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.addPlaceUsage >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.addPlaceUsage >>>'
END
go

IF OBJECT_ID('dbo.addPtgItem') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.addPtgItem
    IF OBJECT_ID('dbo.addPtgItem') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.addPtgItem >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.addPtgItem >>>'
END
go

IF OBJECT_ID('dbo.addShadowPlace') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.addShadowPlace
    IF OBJECT_ID('dbo.addShadowPlace') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.addShadowPlace >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.addShadowPlace >>>'
END
go

IF OBJECT_ID('dbo.addTotalUsageData') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.addTotalUsageData
    IF OBJECT_ID('dbo.addTotalUsageData') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.addTotalUsageData >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.addTotalUsageData >>>'
END
go

IF OBJECT_ID('dbo.addVpPlace') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.addVpPlace
    IF OBJECT_ID('dbo.addVpPlace') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.addVpPlace >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.addVpPlace >>>'
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

IF OBJECT_ID('dbo.cleanPlaceUsage') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.cleanPlaceUsage
    IF OBJECT_ID('dbo.cleanPlaceUsage') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.cleanPlaceUsage >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.cleanPlaceUsage >>>'
END
go

IF OBJECT_ID('dbo.clearHistory') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.clearHistory
    IF OBJECT_ID('dbo.clearHistory') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.clearHistory >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.clearHistory >>>'
END
go

IF OBJECT_ID('dbo.clearPTG') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.clearPTG
    IF OBJECT_ID('dbo.clearPTG') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.clearPTG >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.clearPTG >>>'
END
go

IF OBJECT_ID('dbo.clearSpecialPlaces') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.clearSpecialPlaces
    IF OBJECT_ID('dbo.clearSpecialPlaces') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.clearSpecialPlaces >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.clearSpecialPlaces >>>'
END
go

IF OBJECT_ID('dbo.createTreeTable') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.createTreeTable
    IF OBJECT_ID('dbo.createTreeTable') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.createTreeTable >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.createTreeTable >>>'
END
go

IF OBJECT_ID('dbo.delCategory') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.delCategory
    IF OBJECT_ID('dbo.delCategory') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.delCategory >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.delCategory >>>'
END
go

IF OBJECT_ID('dbo.delPPlace') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.delPPlace
    IF OBJECT_ID('dbo.delPPlace') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.delPPlace >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.delPPlace >>>'
END
go

IF OBJECT_ID('dbo.delPPtgItem') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.delPPtgItem
    IF OBJECT_ID('dbo.delPPtgItem') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.delPPtgItem >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.delPPtgItem >>>'
END
go

IF OBJECT_ID('dbo.delPersistentPlace') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.delPersistentPlace
    IF OBJECT_ID('dbo.delPersistentPlace') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.delPersistentPlace >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.delPersistentPlace >>>'
END
go

IF OBJECT_ID('dbo.delPlaceFromCategory') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.delPlaceFromCategory
    IF OBJECT_ID('dbo.delPlaceFromCategory') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.delPlaceFromCategory >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.delPlaceFromCategory >>>'
END
go

IF OBJECT_ID('dbo.delPlaceType') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.delPlaceType
    IF OBJECT_ID('dbo.delPlaceType') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.delPlaceType >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.delPlaceType >>>'
END
go

IF OBJECT_ID('dbo.delPtgItem') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.delPtgItem
    IF OBJECT_ID('dbo.delPtgItem') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.delPtgItem >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.delPtgItem >>>'
END
go

IF OBJECT_ID('dbo.delShadowPlace') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.delShadowPlace
    IF OBJECT_ID('dbo.delShadowPlace') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.delShadowPlace >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.delShadowPlace >>>'
END
go

IF OBJECT_ID('dbo.delVpPlacesList') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.delVpPlacesList
    IF OBJECT_ID('dbo.delVpPlacesList') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.delVpPlacesList >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.delVpPlacesList >>>'
END
go

IF OBJECT_ID('dbo.getCategories') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getCategories
    IF OBJECT_ID('dbo.getCategories') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getCategories >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getCategories >>>'
END
go

IF OBJECT_ID('dbo.getCategoryPlaces') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getCategoryPlaces
    IF OBJECT_ID('dbo.getCategoryPlaces') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getCategoryPlaces >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getCategoryPlaces >>>'
END
go

IF OBJECT_ID('dbo.getCategoryTree') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getCategoryTree
    IF OBJECT_ID('dbo.getCategoryTree') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getCategoryTree >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getCategoryTree >>>'
END
go

IF OBJECT_ID('dbo.getCurrentBLTotal') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getCurrentBLTotal
    IF OBJECT_ID('dbo.getCurrentBLTotal') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getCurrentBLTotal >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getCurrentBLTotal >>>'
END
go

IF OBJECT_ID('dbo.getCurrentChatTotal') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getCurrentChatTotal
    IF OBJECT_ID('dbo.getCurrentChatTotal') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getCurrentChatTotal >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getCurrentChatTotal >>>'
END
go

IF OBJECT_ID('dbo.getDailyAvgStatistics') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getDailyAvgStatistics
    IF OBJECT_ID('dbo.getDailyAvgStatistics') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getDailyAvgStatistics >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getDailyAvgStatistics >>>'
END
go

IF OBJECT_ID('dbo.getDailyMaxStatistics') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getDailyMaxStatistics
    IF OBJECT_ID('dbo.getDailyMaxStatistics') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getDailyMaxStatistics >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getDailyMaxStatistics >>>'
END
go

IF OBJECT_ID('dbo.getDailyMinStatistics') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getDailyMinStatistics
    IF OBJECT_ID('dbo.getDailyMinStatistics') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getDailyMinStatistics >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getDailyMinStatistics >>>'
END
go

IF OBJECT_ID('dbo.getDailyStatistics') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getDailyStatistics
    IF OBJECT_ID('dbo.getDailyStatistics') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getDailyStatistics >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getDailyStatistics >>>'
END
go

IF OBJECT_ID('dbo.getDailyTotalStatistics') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getDailyTotalStatistics
    IF OBJECT_ID('dbo.getDailyTotalStatistics') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getDailyTotalStatistics >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getDailyTotalStatistics >>>'
END
go

IF OBJECT_ID('dbo.getHourlyAvgStatistics') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getHourlyAvgStatistics
    IF OBJECT_ID('dbo.getHourlyAvgStatistics') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getHourlyAvgStatistics >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getHourlyAvgStatistics >>>'
END
go

IF OBJECT_ID('dbo.getHourlyMaxStatistics') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getHourlyMaxStatistics
    IF OBJECT_ID('dbo.getHourlyMaxStatistics') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getHourlyMaxStatistics >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getHourlyMaxStatistics >>>'
END
go

IF OBJECT_ID('dbo.getHourlyMinStatistics') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getHourlyMinStatistics
    IF OBJECT_ID('dbo.getHourlyMinStatistics') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getHourlyMinStatistics >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getHourlyMinStatistics >>>'
END
go

IF OBJECT_ID('dbo.getHourlyStatistics') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getHourlyStatistics
    IF OBJECT_ID('dbo.getHourlyStatistics') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getHourlyStatistics >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getHourlyStatistics >>>'
END
go

IF OBJECT_ID('dbo.getHourlyTotalStatistics') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getHourlyTotalStatistics
    IF OBJECT_ID('dbo.getHourlyTotalStatistics') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getHourlyTotalStatistics >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getHourlyTotalStatistics >>>'
END
go

IF OBJECT_ID('dbo.getMonthlyAvgStatistics') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getMonthlyAvgStatistics
    IF OBJECT_ID('dbo.getMonthlyAvgStatistics') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getMonthlyAvgStatistics >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getMonthlyAvgStatistics >>>'
END
go

IF OBJECT_ID('dbo.getMonthlyMaxStatistics') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getMonthlyMaxStatistics
    IF OBJECT_ID('dbo.getMonthlyMaxStatistics') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getMonthlyMaxStatistics >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getMonthlyMaxStatistics >>>'
END
go

IF OBJECT_ID('dbo.getMonthlyMinStatistics') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getMonthlyMinStatistics
    IF OBJECT_ID('dbo.getMonthlyMinStatistics') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getMonthlyMinStatistics >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getMonthlyMinStatistics >>>'
END
go

IF OBJECT_ID('dbo.getPPlaces') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getPPlaces
    IF OBJECT_ID('dbo.getPPlaces') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getPPlaces >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getPPlaces >>>'
END
go

IF OBJECT_ID('dbo.getPPlacesChanges') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getPPlacesChanges
    IF OBJECT_ID('dbo.getPPlacesChanges') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getPPlacesChanges >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getPPlacesChanges >>>'
END
go

IF OBJECT_ID('dbo.getPagePlaces') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getPagePlaces
    IF OBJECT_ID('dbo.getPagePlaces') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getPagePlaces >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getPagePlaces >>>'
END
go

IF OBJECT_ID('dbo.getParentCategory') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getParentCategory
    IF OBJECT_ID('dbo.getParentCategory') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getParentCategory >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getParentCategory >>>'
END
go

IF OBJECT_ID('dbo.getPersistentPlace') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getPersistentPlace
    IF OBJECT_ID('dbo.getPersistentPlace') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getPersistentPlace >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getPersistentPlace >>>'
END
go

IF OBJECT_ID('dbo.getPlaceTypes') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getPlaceTypes
    IF OBJECT_ID('dbo.getPlaceTypes') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getPlaceTypes >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getPlaceTypes >>>'
END
go

IF OBJECT_ID('dbo.getPlaces') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getPlaces
    IF OBJECT_ID('dbo.getPlaces') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getPlaces >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getPlaces >>>'
END
go

IF OBJECT_ID('dbo.getShadowPlaces') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getShadowPlaces
    IF OBJECT_ID('dbo.getShadowPlaces') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getShadowPlaces >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getShadowPlaces >>>'
END
go

IF OBJECT_ID('dbo.getSubCategories') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getSubCategories
    IF OBJECT_ID('dbo.getSubCategories') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getSubCategories >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getSubCategories >>>'
END
go

IF OBJECT_ID('dbo.getWeeklyAvgStatistics') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getWeeklyAvgStatistics
    IF OBJECT_ID('dbo.getWeeklyAvgStatistics') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getWeeklyAvgStatistics >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getWeeklyAvgStatistics >>>'
END
go

IF OBJECT_ID('dbo.getWeeklyMaxStatistics') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getWeeklyMaxStatistics
    IF OBJECT_ID('dbo.getWeeklyMaxStatistics') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getWeeklyMaxStatistics >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getWeeklyMaxStatistics >>>'
END
go

IF OBJECT_ID('dbo.getWeeklyMinStatistics') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getWeeklyMinStatistics
    IF OBJECT_ID('dbo.getWeeklyMinStatistics') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getWeeklyMinStatistics >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getWeeklyMinStatistics >>>'
END
go

IF OBJECT_ID('dbo.persistentPlaceExists') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.persistentPlaceExists
    IF OBJECT_ID('dbo.persistentPlaceExists') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.persistentPlaceExists >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.persistentPlaceExists >>>'
END
go

IF OBJECT_ID('dbo.renameCategory') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.renameCategory
    IF OBJECT_ID('dbo.renameCategory') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.renameCategory >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.renameCategory >>>'
END
go

IF OBJECT_ID('dbo.updPlaceType') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.updPlaceType
    IF OBJECT_ID('dbo.updPlaceType') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.updPlaceType >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.updPlaceType >>>'
END
go

IF OBJECT_ID('dbo.updatePPlace') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.updatePPlace
    IF OBJECT_ID('dbo.updatePPlace') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.updatePPlace >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.updatePPlace >>>'
END
go


--
-- DROP TRIGGERS
--
IF OBJECT_ID('addDailyUsageRecord') IS NOT NULL
BEGIN
    DROP TRIGGER addDailyUsageRecord
    IF OBJECT_ID('addDailyUsageRecord') IS NOT NULL
        PRINT '<<< FAILED DROPPING TRIGGER addDailyUsageRecord >>>'
    ELSE
        PRINT '<<< DROPPED TRIGGER addDailyUsageRecord >>>'
END
go

IF OBJECT_ID('addTotalUsageRecord') IS NOT NULL
BEGIN
    DROP TRIGGER addTotalUsageRecord
    IF OBJECT_ID('addTotalUsageRecord') IS NOT NULL
        PRINT '<<< FAILED DROPPING TRIGGER addTotalUsageRecord >>>'
    ELSE
        PRINT '<<< DROPPED TRIGGER addTotalUsageRecord >>>'
END
go


--
-- DROP VIEWS
--
IF OBJECT_ID('dbo.usagePeaksView') IS NOT NULL
BEGIN
    DROP VIEW dbo.usagePeaksView
    IF OBJECT_ID('dbo.usagePeaksView') IS NOT NULL
        PRINT '<<< FAILED DROPPING VIEW dbo.usagePeaksView >>>'
    ELSE
        PRINT '<<< DROPPED VIEW dbo.usagePeaksView >>>'
END
go

IF OBJECT_ID('dbo.usagePeaksWithTimeView') IS NOT NULL
BEGIN
    DROP VIEW dbo.usagePeaksWithTimeView
    IF OBJECT_ID('dbo.usagePeaksWithTimeView') IS NOT NULL
        PRINT '<<< FAILED DROPPING VIEW dbo.usagePeaksWithTimeView >>>'
    ELSE
        PRINT '<<< DROPPED VIEW dbo.usagePeaksWithTimeView >>>'
END
go


--
-- DROP TABLES
--
DROP TABLE dbo.PTGlist
go

DROP TABLE dbo.PersistentPTGlist
go

IF OBJECT_ID('parentCategoryRefCategories') IS NOT NULL
BEGIN
    ALTER TABLE dbo.categories DROP CONSTRAINT parentCategoryRefCategories
    IF OBJECT_ID('parentCategoryRefCategories') IS NOT NULL
        PRINT '<<< FAILED DROPPING CONSTRAINT parentCategoryRefCategories >>>'
    ELSE
        PRINT '<<< DROPPED CONSTRAINT parentCategoryRefCategories >>>'
END
go
DROP TABLE dbo.categories
go

DROP TABLE dbo.dailyUsage
go

DROP TABLE dbo.persistentPlaces
go

DROP TABLE dbo.persistentPlacesChange
go

DROP TABLE dbo.placeCategories
go

DROP TABLE dbo.placeTypes
go

DROP TABLE dbo.placeUsage
go

DROP TABLE dbo.shadowPlaces
go

DROP TABLE dbo.totalUsage
go

DROP TABLE dbo.vpPlacesList
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
-- DROP ALIASES
--
IF EXISTS (SELECT * FROM sysalternates WHERE suid=SUSER_ID('sa'))
BEGIN
    EXEC sp_dropalias 'sa'
    IF EXISTS (SELECT * FROM sysalternates WHERE suid=SUSER_ID('sa'))
        PRINT '<<< FAILED DROPPING ALIAS sa >>>'
    ELSE
        PRINT '<<< DROPPED ALIAS sa >>>'
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

IF USER_ID('vpusr') IS NOT NULL
BEGIN
    EXEC sp_dropuser 'vpusr'
    IF USER_ID('vpusr') IS NOT NULL
        PRINT '<<< FAILED DROPPING USER vpusr >>>'
    ELSE
        PRINT '<<< DROPPED USER vpusr >>>'
END
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

EXEC sp_adduser 'vpusr','vpusr','public'
go
IF USER_ID('vpusr') IS NOT NULL
    PRINT '<<< CREATED USER vpusr >>>'
ELSE
    PRINT '<<< FAILED CREATING USER vpusr >>>'
go


--
-- CREATE ALIASES
--
EXEC sp_addalias 'sa','dbo'
go
IF EXISTS (SELECT * FROM sysalternates WHERE suid=SUSER_ID("sa"))
    PRINT '<<< CREATED ALIAS sa >>>'
ELSE
    PRINT '<<< FAILED CREATING ALIAS sa >>>'
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
CREATE TABLE dbo.PTGlist 
(
    serialNumber int          NOT NULL,
    URL          varchar(255) NOT NULL,
    title        varchar(255) NOT NULL,
    roomUsage    int          NOT NULL,
    corrUsage    int          NOT NULL,
    CONSTRAINT isPrimary PRIMARY KEY CLUSTERED (serialNumber)
)
go
IF OBJECT_ID('dbo.PTGlist') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.PTGlist >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.PTGlist >>>'
go

CREATE TABLE dbo.PersistentPTGlist 
(
    serialNumber int          NOT NULL,
    URL          varchar(255) NOT NULL,
    title        varchar(255) NOT NULL,
    type         int          NOT NULL,
    roomUsage    int          NOT NULL,
    corrUsage    int          NOT NULL,
    CONSTRAINT Persistent_1120034302 UNIQUE NONCLUSTERED (serialNumber,type)
)
go
IF OBJECT_ID('dbo.PersistentPTGlist') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.PersistentPTGlist >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.PersistentPTGlist >>>'
go

CREATE TABLE dbo.categories 
(
    category        categoryIdentifier IDENTITY,
    description     varchar(30)        NOT NULL,
    parentCategeory categoryIdentifier NULL,
    CONSTRAINT isPrimary PRIMARY KEY CLUSTERED (category),
    CONSTRAINT uniqueCategoryName UNIQUE NONCLUSTERED (parentCategeory,description)
)
go
IF OBJECT_ID('dbo.categories') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.categories >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.categories >>>'
go

CREATE TABLE dbo.dailyUsage 
(
    time      VpTime  NOT NULL,
    userType  tinyint NOT NULL,
    valueType tinyint NOT NULL,
    value     int     DEFAULT 0		 NOT NULL
)
go
IF OBJECT_ID('dbo.dailyUsage') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.dailyUsage >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.dailyUsage >>>'
go

CREATE TABLE dbo.persistentPlaces 
(
    URL           longName NOT NULL,
    type          int      NOT NULL,
    title         longName NOT NULL,
    roomCapacity  int      NOT NULL,
    roomProtected bit      NOT NULL,
    numberOfRows  int      NOT NULL,
    rowSize       int      NOT NULL,
    rowPrefix     longName NOT NULL,
    CONSTRAINT isPrimary PRIMARY KEY CLUSTERED (URL)
)
go
IF OBJECT_ID('dbo.persistentPlaces') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.persistentPlaces >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.persistentPlaces >>>'
go

CREATE TABLE dbo.persistentPlacesChange 
(
    time   VpTime   NOT NULL,
    URL    longName NOT NULL,
    change char(1)  NOT NULL
)
go
IF OBJECT_ID('dbo.persistentPlacesChange') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.persistentPlacesChange >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.persistentPlacesChange >>>'
go

CREATE TABLE dbo.placeCategories 
(
    category   categoryIdentifier NOT NULL,
    URL        UrlType            NOT NULL,
    domainFlag bit                DEFAULT 1	 NOT NULL,
    CONSTRAINT uniquePlaceCategory UNIQUE NONCLUSTERED (category,URL)
)
go
IF OBJECT_ID('dbo.placeCategories') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.placeCategories >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.placeCategories >>>'
go

CREATE TABLE dbo.placeTypes 
(
    type            int NOT NULL,
    minPeople       int DEFAULT 1 NOT NULL,
    sortOrder       int DEFAULT 1 NOT NULL,
    unifyReplicates bit DEFAULT 1 NOT NULL,
    excludeShadow   bit DEFAULT 0 NOT NULL,
    CONSTRAINT isPrimary PRIMARY KEY CLUSTERED (type)
)
go
IF OBJECT_ID('dbo.placeTypes') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.placeTypes >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.placeTypes >>>'
go

CREATE TABLE dbo.placeUsage 
(
    time          smalldatetime NOT NULL,
    URL           varchar(255)  NOT NULL,
    title         varchar(255)  NOT NULL,
    roomUsage     int           NOT NULL,
    corridorUsage int           NOT NULL
)
go
IF OBJECT_ID('dbo.placeUsage') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.placeUsage >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.placeUsage >>>'
go

CREATE TABLE dbo.shadowPlaces 
(
    URL varchar(255) NOT NULL,
    CONSTRAINT isPrimary PRIMARY KEY CLUSTERED (URL)
)
go
IF OBJECT_ID('dbo.shadowPlaces') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.shadowPlaces >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.shadowPlaces >>>'
go

CREATE TABLE dbo.totalUsage 
(
    time       VpTime NOT NULL,
    totalUsage int    NOT NULL,
    roomUsage  int    NOT NULL,
    corrUsage  int    NOT NULL,
    BLUsage    int    NOT NULL,
    CONSTRAINT isPrimary PRIMARY KEY CLUSTERED (time)
)
go
IF OBJECT_ID('dbo.totalUsage') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.totalUsage >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.totalUsage >>>'
go

CREATE TABLE dbo.vpPlacesList 
(
    serialNumber int          NOT NULL,
    URL          varchar(255) NOT NULL,
    title        varchar(255) NOT NULL,
    roomUsage    int          NOT NULL,
    corrUsage    int          NOT NULL,
    type         int          NOT NULL,
    capacity     int          NOT NULL,
    repCount     int          NOT NULL,
    CONSTRAINT isPrimary PRIMARY KEY CLUSTERED (serialNumber)
)
go
IF OBJECT_ID('dbo.vpPlacesList') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.vpPlacesList >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.vpPlacesList >>>'
go


--
-- ADD REFERENTIAL CONSTRAINTS
--
ALTER TABLE dbo.categories ADD CONSTRAINT parentCategoryRefCategories FOREIGN KEY (parentCategeory) REFERENCES dbo.categories (category)
go

--
-- CREATE INDEXES
--
CREATE UNIQUE NONCLUSTERED INDEX persistentPTGIdx
    ON dbo.PersistentPTGlist(type,serialNumber)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.PersistentPTGlist') AND name='persistentPTGIdx')
    PRINT '<<< CREATED INDEX dbo.PersistentPTGlist.persistentPTGIdx >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.PersistentPTGlist.persistentPTGIdx >>>'
go

CREATE UNIQUE NONCLUSTERED INDEX PPlaceChangesIdx
    ON dbo.persistentPlacesChange(change,URL)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.persistentPlacesChange') AND name='PPlaceChangesIdx')
    PRINT '<<< CREATED INDEX dbo.persistentPlacesChange.PPlaceChangesIdx >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.persistentPlacesChange.PPlaceChangesIdx >>>'
go

CREATE NONCLUSTERED INDEX placeUsageIdx
    ON dbo.placeUsage(time,roomUsage)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.placeUsage') AND name='placeUsageIdx')
    PRINT '<<< CREATED INDEX dbo.placeUsage.placeUsageIdx >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.placeUsage.placeUsageIdx >>>'
go

CREATE NONCLUSTERED INDEX placeUsageByTimeIdx
    ON dbo.placeUsage(time)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.placeUsage') AND name='placeUsageByTimeIdx')
    PRINT '<<< CREATED INDEX dbo.placeUsage.placeUsageByTimeIdx >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.placeUsage.placeUsageByTimeIdx >>>'
go


--
-- CREATE VIEWS
--
CREATE VIEW usagePeaksView
AS
  SELECT max(totalUsage)      AS peakPoint,
         datepart( YY, time ) AS day,
         datepart( mm, time ) AS month,
         datepart( dd, time ) AS year
  FROM totalUsage
  GROUP BY datepart( YY, time ),
           datepart( mm, time ),
           datepart( dd, time )

go
IF OBJECT_ID('dbo.usagePeaksView') IS NOT NULL
    PRINT '<<< CREATED VIEW dbo.usagePeaksView >>>'
ELSE
    PRINT '<<< FAILED CREATING VIEW dbo.usagePeaksView >>>'
go

CREATE VIEW usagePeaksWithTimeView
AS
  SELECT dateadd( hour, gmt, time ) AS localTime,
         time as timeGMT,
         totalUsage
  FROM totalUsage tu, usagePeaksView upv, vpusers..getGMT
  WHERE ( tu.totalUsage = upv.peakPoint ) AND
        ( datepart( YY, tu.time ) = upv.day ) AND
        ( datepart( mm, tu.time ) = upv.month ) AND
        ( datepart( dd, tu.time ) = upv.year )

go
IF OBJECT_ID('dbo.usagePeaksWithTimeView') IS NOT NULL
    PRINT '<<< CREATED VIEW dbo.usagePeaksWithTimeView >>>'
ELSE
    PRINT '<<< FAILED CREATING VIEW dbo.usagePeaksWithTimeView >>>'
go


--
-- CREATE PROCEDURES
--
/* add a new category */
/*
  INPUT  : category description (name), parent category
  OUTPUT : ID of new category
           return value - 0 if successful
                          20001 if parent category does not exist
                          20002 if category with the same name is 
                                already defined for that parent category
*/
CREATE PROC addCategory
(
  @description varchar(30),
  @parentCategory categoryIdentifier = NULL
)
AS
BEGIN
  DECLARE @lastError int
  DECLARE @category categoryIdentifier
  DECLARE @oldCategory varchar(30)
  
  BEGIN TRAN addCategory
    IF ( @parentCategory IS NOT NULL )
    BEGIN
      /* check if the given parent category exists */
      SELECT @category = category
        FROM categories
        WHERE ( category = @parentCategory )
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRAN addCategory
        RETURN @lastError
      END
      
      IF ( @category IS NULL )
      BEGIN
        ROLLBACK TRAN addCategory
        RETURN 20001
      END
    END
    
    SELECT @oldCategory = category
      FROM categories
      WHERE ( parentCategeory = @parentCategory ) AND
            ( description = @description )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN addCategory
      RETURN @lastError
    END
    
    IF ( @oldCategory IS NOT NULL )
    BEGIN
      ROLLBACK TRAN addCategory
      RETURN 20002
    END
    
    INSERT categories ( parentCategeory, description )
      VALUES ( @parentCategory, @description )    
    
    SELECT @lastError = @@error

    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN addCategory
      RETURN @lastError
    END
    
    SELECT category
      FROM categories
      WHERE ( parentCategeory = @parentCategory ) AND
            ( description = @description )
    
  COMMIT TRAN addCategory
END

go
IF OBJECT_ID('dbo.addCategory') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.addCategory >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.addCategory >>>'
go

/* add (or update if an entry with the same serial 
   number already exists) the record for a
   Persistent-Places-To-Go list item. */
/* input:  serial number in list, type of place,
           URL, title, roomUsage, corrUsage
   output: NONE
*/
CREATE PROC addPPtgItem
(
  @serialNumber	integer,
  @type		integer,
  @URL		varchar(255),
  @title	varchar(255),
  @roomUsage	integer,
  @corrUsage	integer
)
AS
BEGIN  
  DECLARE @lastError int
  DECLARE @insideTransaction int
  DECLARE @matchFound bit

  IF ( @@trancount > 0 )
    SELECT @insideTransaction = 1
  ELSE 
    SELECT @insideTransaction = 0

  IF ( @insideTransaction = 0 )
    BEGIN TRAN addPtgItem

    /* first check if the auditorium exists */
    IF EXISTS (
      SELECT serialNumber
        FROM PersistentPTGlist
        WHERE serialNumber = @serialNumber 
	AND type = @type)
      SELECT @matchFound = 1
    ELSE
      SELECT @matchFound = 0
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      raiserror @lastError
      ROLLBACK TRAN
      RETURN @lastError
    END
    
    IF @matchFound = 1
    BEGIN
      /* update existing entry */
      UPDATE PersistentPTGlist
        SET title = @title,
            URL = @URL,
            roomUsage = @roomUsage,
	    corrUsage = @corrUsage
        FROM PersistentPTGlist
        WHERE serialNumber = @serialNumber
	AND type = @type
    END
    ELSE
    BEGIN
      /* insert a new entry */
      INSERT PersistentPTGlist
        VALUES ( @serialNumber, @URL, @title, @type, @roomUsage, @corrUsage )
    END

    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      raiserror @lastError
      ROLLBACK TRAN
      RETURN @lastError
    END
    
  IF ( @insideTransaction = 0 )
    COMMIT TRAN addPtgItem
END

go
IF OBJECT_ID('dbo.addPPtgItem') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.addPPtgItem >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.addPPtgItem >>>'
go

/* add a new auditorium persistent place to the database */
/* input:  URL, type, title, room Capacity, num. of rows, row size,
		row prefix
   output: return value - 0 if successfull,
                          20001 if URL is already in use 
                                by an existing persistent place
*/
CREATE PROC addPersistentPlace
(
  @URL			longName,
  @type			integer,
  @title		longName,
  @roomCapacity		integer,
  @protected		bit,
  @numberOfRows		integer,
  @rowSize		integer,
  @rowPrefix		longName
)
AS
BEGIN
  DECLARE @lastError int
  DECLARE @diffFromGMT int
  DECLARE @existingURL longName

  BEGIN TRAN
    /* try to find an existing
       persistent place using
       the same URL */
    SELECT @existingURL = URL
      FROM persistentPlaces
      WHERE URL = @URL 
   
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
  
    IF @existingURL IS NOT NULL
    BEGIN
      /* fond an existing
         persistent place
         using the same URL */
      ROLLBACK TRAN
      RETURN 20001
    END
  
    SELECT @diffFromGMT = gmt
    FROM vpusers..getGMT
   
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END

   INSERT persistentPlaces
      ( URL, type, title, roomCapacity, 
	roomProtected, numberOfRows, rowSize, rowPrefix  )
      VALUES 
      ( @URL, @type, @title, @roomCapacity, 
	@protected, @numberOfRows, @rowSize, @rowPrefix )
   
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END

    /* add a change record */
    INSERT persistentPlacesChange
    VALUES(dateadd(hour, (-1) * @diffFromGMT, getdate()), @URL, "A")
        
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END

  COMMIT TRAN

END

go
IF OBJECT_ID('dbo.addPersistentPlace') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.addPersistentPlace >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.addPersistentPlace >>>'
go

/* add a place under a category */
/*
  INPUT  : parent category, new place URL, domainFlag
  OUTPUT : return value - 0 if successful
                          20001 if given category does not exist
                          20002 if given place is already defined 
                                for this category
*/
CREATE PROC addPlaceToCategory
(
  @parentCategory categoryIdentifier,
  @URL UrlType,
  @domainFlag bit = 1
)
AS
BEGIN
  DECLARE @lastError int
  DECLARE @category categoryIdentifier
  DECLARE @oldPlace UrlType
  
  BEGIN TRAN addPlaceToCategory
    SELECT @category = category
      FROM categories
      WHERE ( category = @parentCategory )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN addPlaceToCategory
      RETURN @lastError
    END
    
    IF ( @category IS NULL )
    BEGIN
      ROLLBACK TRAN addPlaceToCategory
      RETURN 20001
    END
    
    SELECT @oldPlace = URL
      FROM placeCategories
      WHERE ( category = @parentCategory ) AND
            ( URL = @URL )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN addPlaceToCategory
      RETURN @lastError
    END
    
    IF ( @oldPlace IS NOT NULL )
    BEGIN
      ROLLBACK TRAN addPlaceToCategory
      RETURN 20002
    END
    
    INSERT placeCategories ( category, URL, domainFlag )
      VALUES ( @parentCategory, @URL, @domainFlag )    
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN addPlaceToCategory
      RETURN @lastError
    END
    
  COMMIT TRAN addPlaceToCategory
END

go
IF OBJECT_ID('dbo.addPlaceToCategory') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.addPlaceToCategory >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.addPlaceToCategory >>>'
go

/* add a new place type to the database */
/* input:  type, min people for showing places, sort order,
           unify replicates, exclude shadow places
   output:  none 
*/
CREATE PROC addPlaceType
(
  @type             integer,
  @minPeople	    integer = 1,
  @sortOrder        integer = 1,
  @unifyReplicated  bit = 1,
  @excludeShadow    bit = 0
)
AS
BEGIN
  
  DECLARE @lastError int

    INSERT placeTypes
      VALUES( @type, @minPeople, @sortOrder,
              @unifyReplicated, @excludeShadow )  
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END

END

go
IF OBJECT_ID('dbo.addPlaceType') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.addPlaceType >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.addPlaceType >>>'
go

/* add (or update if an entry with the same date 
   	already exists) the record for a
   Places-usage list. */

CREATE PROC addPlaceUsage
(
  @date		smalldateTime,
  @URL		varchar(255),
  @title	varchar(255),
  @RoomUsage	integer,
  @CorrUsage	integer
)
AS
BEGIN  
  DECLARE @lastError int
  DECLARE @insideTransaction int
  DECLARE @matchFound bit

  DECLARE @prevRoom integer
  DECLARE @prevCorr integer

  IF ( @@trancount > 0 )
    SELECT @insideTransaction = 1
  ELSE 
    SELECT @insideTransaction = 0

  IF ( @insideTransaction = 0 )
    BEGIN TRAN addPtgItem

  /* first check if the placeusage */
  IF EXISTS (
    SELECT time
      FROM placeUsage
      WHERE time = @date
	AND URL = @URL )
    SELECT @matchFound = 1
  ELSE
    SELECT @matchFound = 0
  
  SELECT @lastError = @@error
  IF @lastError != 0
  BEGIN
    raiserror @lastError
    ROLLBACK TRAN
    RETURN @lastError
  END
    
  IF @matchFound = 1
  BEGIN
    /* update existing entry */
    UPDATE placeUsage
      SET title = @title,
          URL = @URL,
          roomUsage = roomUsage+@RoomUsage,
          corridorUsage = corridorUsage+@CorrUsage
      FROM placeUsage
      WHERE time = @date
	AND URL = @URL
  END
  ELSE
  BEGIN
    /* insert a new entry */
    INSERT placeUsage
      VALUES ( @date, @URL, @title, @RoomUsage, @CorrUsage )
  END

  SELECT @lastError = @@error
  IF @lastError != 0
  BEGIN
    raiserror @lastError
    ROLLBACK TRAN
    RETURN @lastError
  END
    
  IF ( @insideTransaction = 0 )
    COMMIT TRAN addPtgItem
END

go
IF OBJECT_ID('dbo.addPlaceUsage') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.addPlaceUsage >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.addPlaceUsage >>>'
go

/* add (or update if an entry with the same serial 
   number already exists) the record for a
   Places-To-Go list item. */
/* input:  serial number in list,
           URL, title, usage
   output: NONE
*/
CREATE PROC addPtgItem
(
  @serialNumber	integer,
  @url		varchar(255),
  @title	varchar(255),
  @Rusage	integer,
  @Cusage	integer
)
AS
BEGIN  
  DECLARE @lastError int
  DECLARE @insideTransaction int
  DECLARE @matchFound bit

  IF ( @@trancount > 0 )
    SELECT @insideTransaction = 1
  ELSE 
    SELECT @insideTransaction = 0

  IF ( @insideTransaction = 0 )
    BEGIN TRAN addPtgItem

    /* first check if the auditorium exists */
    IF EXISTS (
      SELECT serialNumber
        FROM PTGlist
        WHERE serialNumber = @serialNumber )
      SELECT @matchFound = 1
    ELSE
      SELECT @matchFound = 0
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      raiserror @lastError
      ROLLBACK TRAN
      RETURN @lastError
    END
    
    IF @matchFound = 1
    BEGIN
      /* update existing entry */
      UPDATE PTGlist
        SET title = @title,
            URL = @url,
            roomUsage = @Rusage,
            corrUsage = @Cusage
        FROM PTGlist
        WHERE serialNumber = @serialNumber
    END
    ELSE
    BEGIN
      /* insert a new entry */
      INSERT PTGlist
        VALUES ( @serialNumber, @url, @title, @Rusage, @Cusage )
    END

    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      raiserror @lastError
      ROLLBACK TRAN
      RETURN @lastError
    END
    
  IF ( @insideTransaction = 0 )
    COMMIT TRAN addPtgItem
END

go
IF OBJECT_ID('dbo.addPtgItem') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.addPtgItem >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.addPtgItem >>>'
go

/* add a shadow place entry */
CREATE PROC addShadowPlace ( @URL longName )
AS
BEGIN
  DECLARE @lastError int
  DECLARE @diffFromGMT int
  DECLARE @existingURL longName

  BEGIN TRAN
    /* try to find an existing
       shadow place using
       the same URL */
    SELECT @existingURL = URL
      FROM shadowPlaces
      WHERE URL = @URL 
   
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
  
    IF @existingURL IS NOT NULL
    BEGIN
      /* found an existing
         shadow place
         using the same URL */
      ROLLBACK TRAN
      RETURN 20001
    END
  
  INSERT shadowPlaces VALUES ( @URL )

  COMMIT TRAN

END

go
IF OBJECT_ID('dbo.addShadowPlace') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.addShadowPlace >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.addShadowPlace >>>'
go

/* add one record to the total usage record */
/*
   INPUT: total usage, room usage, corridor usage, Buddy List usage
*/
CREATE PROCEDURE addTotalUsageData
(
  @totalUsage int,
  @roomUsage int,
  @corrUsage int,
  @BLUsage int
)
AS
BEGIN
  DECLARE @lastError int
  DECLARE @diffFromGMT int
  DECLARE @currentTime VpTime
  DECLARE @localTime VpTime
  DECLARE @deleteTime VpTime

  BEGIN TRANSACTION addTotalUsageData
    SELECT @diffFromGMT = gmt
      FROM vpusers..getGMT
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK transaction addTotalUsageData
      RETURN @lastError
    END
    
    IF ( @diffFromGMT IS NULL )
      SELECT @diffFromGMT = 0
    SELECT @localTime = getdate()
    SELECT @currentTime = dateadd( hour, (-1) * @diffFromGMT, @localTime )
    SELECT @deleteTime = dateadd( day, (-1) * 180, @currentTime)
    
    DELETE totalUsage
      WHERE time < @deleteTime
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK transaction addTotalUsageData
      RETURN @lastError
    END
    
    INSERT totalUsage
      VALUES ( @currentTime, 
               @totalUsage, @roomUsage,
               @corrUsage, @BLUsage )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK transaction addTotalUsageData
      RETURN @lastError
    END
  COMMIT TRANSACTION addTotalUsageData
END

go
IF OBJECT_ID('dbo.addTotalUsageData') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.addTotalUsageData >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.addTotalUsageData >>>'
go

/* add (or update if an entry with the same serial 
   number already exists) the record for a
   vp places list item. */
/* input:  serial number in list,
           URL, title, usage, type, replicate count, capacity

   output: NONE
*/
CREATE PROC addVpPlace
(
  @serialNumber	integer,
  @url		varchar(255),
  @title	varchar(255),
  @type		integer,
  @repCount 	integer,
  @capacity     integer,
  @Rusage	integer,
  @Cusage	integer
)
AS
BEGIN  
  DECLARE @lastError int
  DECLARE @insideTransaction int
  DECLARE @matchFound bit

  IF ( @@trancount > 0 )
    SELECT @insideTransaction = 1
  ELSE 
    SELECT @insideTransaction = 0

  IF ( @insideTransaction = 0 )
    BEGIN TRAN addVpPlace

    /* first check if the auditorium exists */
    IF EXISTS (
      SELECT serialNumber
        FROM vpPlacesList
        WHERE serialNumber = @serialNumber )
      SELECT @matchFound = 1
    ELSE
      SELECT @matchFound = 0
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      raiserror @lastError
      ROLLBACK TRAN
      RETURN @lastError
    END
    
    IF @matchFound = 1
    BEGIN
      /* update existing entry */
      UPDATE vpPlacesList
        SET title = @title,
            URL = @url,
            roomUsage = @Rusage,
            corrUsage = @Cusage,
            type = @type,
            capacity = @capacity,
            repCount = @repCount
        FROM vpPlacesList
        WHERE serialNumber = @serialNumber
    END
    ELSE
    BEGIN
      /* insert a new entry */
      INSERT vpPlacesList
        VALUES ( @serialNumber, @url, @title, @Rusage, @Cusage, 
                 @type, @capacity, @repCount )
    END

    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      raiserror @lastError
      ROLLBACK TRAN
      RETURN @lastError
    END
    
  IF ( @insideTransaction = 0 )
    COMMIT TRAN addVpPlace
END

go
IF OBJECT_ID('dbo.addVpPlace') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.addVpPlace >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.addVpPlace >>>'
go

CREATE PROCEDURE autobackup
AS
BEGIN
  DUMP TRAN vpplaces WITH TRUNCATE_ONLY
END

go
IF OBJECT_ID('dbo.autobackup') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.autobackup >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.autobackup >>>'
go

/* Clear from database all records for placeusage
	that are @keppdays ago or older */
/* input:  
     number of days back to keep
   output: None */

CREATE PROC cleanPlaceUsage
(
  @keepDays   smallint
)
AS
BEGIN
  DECLARE @lastDay VpTime

  SELECT @lastDay = dateadd( day, @keepDays  * -1, getdate() )
  
  DELETE
  FROM placeUsage
  WHERE time < @lastDay

END

go
IF OBJECT_ID('dbo.cleanPlaceUsage') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.cleanPlaceUsage >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.cleanPlaceUsage >>>'
go

/* Clear from database all usage history records */
CREATE PROC clearHistory
AS
  DELETE placeUsage

go
IF OBJECT_ID('dbo.clearHistory') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.clearHistory >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.clearHistory >>>'
go

/* Clear from database all Places To Go records and all
   Persistent Places To Go Records                       */
CREATE PROC clearPTG
AS
BEGIN
  DECLARE @lastError int
  
  BEGIN TRAN
    DELETE PTGlist
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
    
    DELETE PersistentPTGlist
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
  COMMIT TRAN
END

go
IF OBJECT_ID('dbo.clearPTG') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.clearPTG >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.clearPTG >>>'
go

/* Clear from database all Persistent Places records and
   Shadow Places Records                       */
CREATE PROC clearSpecialPlaces
AS
BEGIN
  DECLARE @lastError int
  
  BEGIN TRAN
    DELETE shadowPlaces
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
    
    DELETE persistentPlaces
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
  COMMIT TRAN
END

go
IF OBJECT_ID('dbo.clearSpecialPlaces') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.clearSpecialPlaces >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.clearSpecialPlaces >>>'
go

/* Create Results table for the procedure getCategoryTree */
CREATE PROC createTreeTable 
AS
BEGIN
DECLARE @lastError integer
CREATE TABLE tempdb..TreeTable (
	treeLevel integer,
	type  char(1),
	catId numeric(6,0) NULL,
	name  varchar(255),
	protectedFlag bit,
        vptype integer NULL,
	title varchar(255)  NULL,
	capacity integer  NULL,
	audName varchar(255) NULL,
        audId   numeric(10,0) NULL,
	client  varchar(255)  NULL,
	welcomeMsg1 varchar(255)  NULL,
	welcomeMsg2 varchar(255) NULL,
	rowSize     integer  NULL,
	numRows     integer  NULL
)
SELECT @lastError = @@error
IF @lastError != 0
  RETURN 20001
END

go
IF OBJECT_ID('dbo.createTreeTable') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.createTreeTable >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.createTreeTable >>>'
go

/* delete a category - related data will be 
   removed by the delCategoryData trigger 
   NOTE: to avoid having to do a recursive call to
   the trigger (which is limited to up to 16 levels),
   sub-categories are deleted gradually here by 
   collecting them in a temporary table
*/
/*
  INPUT  : category ID
  OUTPUT : NONE
*/
CREATE PROC delCategory
(
  @category categoryIdentifier
)
AS
BEGIN
  CREATE TABLE #subCategories
  (
    category	numeric(10,0)		NOT NULL,
    nestLevel	int			NOT NULL
  )
  DECLARE @lastError int
  DECLARE @nestingLevel int
  DECLARE @rowsAdded int
  SELECT @nestingLevel = 0
  
  BEGIN TRAN delCategory
  /* find all sub-categories */

  /* find all sub-categories which are
     in the first level                */
  INSERT #subCategories
    VALUES ( @category, @nestingLevel )
  
      
  SELECT @lastError = @@error
  IF @lastError != 0
  BEGIN
    ROLLBACK TRAN delCategory
    RETURN @lastError
  END
  
  SELECT @rowsAdded = 1
  WHILE ( @rowsAdded > 0 )
  BEGIN
    SELECT @nestingLevel = @nestingLevel + 1
    /* find the sub-categories in the next level */
    INSERT #subCategories
      SELECT c.category, @nestingLevel
      FROM categories c, #subCategories sc
      WHERE ( sc.nestLevel = @nestingLevel-1 ) AND
            ( c.parentCategeory = sc.category )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN delCategory
      RETURN @lastError
    END
    
    SELECT @rowsAdded = count(*)
      FROM #subCategories
      WHERE nestLevel = @nestingLevel
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN delCategory
      RETURN @lastError
    END
    
  END /* WHILE ( @rowsAdded > 0 ) */

  
  /* delete all the place related 
     to any of the sub-categories found */
  DELETE placeCategories
    FROM placeCategories pc, #subCategories sc
    WHERE ( pc.category = sc.category )
  
  SELECT @lastError = @@error
  IF @lastError != 0
  BEGIN
    ROLLBACK TRAN delCategory
    RETURN @lastError
  END
  
  /* now, go over all sub-categories that were
     put in the temporary table and delete them
     from the categories table                  */
  
  WHILE ( @nestingLevel > 0 ) 
  BEGIN
    SELECT @nestingLevel = @nestingLevel - 1
    DELETE categories
      FROM categories c, #subCategories sc
      WHERE ( sc.nestLevel = @nestingLevel ) AND
            ( c.category = sc.category )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN delCategory
      RETURN @lastError
    END
  END
  
  /* empty the temporary table */
  DELETE #subCategories
  
  SELECT @lastError = @@error
  IF @lastError != 0
  BEGIN
    ROLLBACK TRAN delCategory
    RETURN @lastError
  END
  
  COMMIT TRAN delCategory
END

go
IF OBJECT_ID('dbo.delCategory') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.delCategory >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.delCategory >>>'
go

/* input:  URL
   output: NONE

  NOTE: this is done in a separate stored procedure from 
        delPersistentPlace because it deals with persistent 
        places that weren't reported yet to the VP server
*/
CREATE PROC delPPlace
(
  @URL longName
)
AS
  DELETE persistentPlaces
    WHERE URL = @URL

go
IF OBJECT_ID('dbo.delPPlace') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.delPPlace >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.delPPlace >>>'
go

/* del all items from type and number higher then serialnumber */
CREATE PROC delPPtgItem
(
@serialNumber 	integer,
@type		integer
)
AS
  DELETE
    FROM PersistentPTGlist
    WHERE serialNumber >= @serialNumber
    AND type = @type

go
IF OBJECT_ID('dbo.delPPtgItem') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.delPPtgItem >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.delPPtgItem >>>'
go

/* input:  URL
   output: NONE
*/
CREATE PROC delPersistentPlace
(
  @URL			varchar(255)
)
AS
BEGIN
  DECLARE @diffFromGMT int
  DECLARE @lastError int

  BEGIN TRAN
  
    SELECT @diffFromGMT = gmt
    FROM vpusers..getGMT
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END

    DELETE persistentPlaces
    WHERE URL = @URL
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END

    /* add a delete change record */
    INSERT persistentPlacesChange
    VALUES(dateadd(hour, (-1) * @diffFromGMT, getdate()), @URL, "D")
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END

  COMMIT TRAN  
END

go
IF OBJECT_ID('dbo.delPersistentPlace') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.delPersistentPlace >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.delPersistentPlace >>>'
go

/* delete a place from under a category */
/*
  INPUT  : parent category, URL to delete
  OUTPUT : return value - 0 if successful
                          20001 if given category does not exist
                          20002 if given place does not exist
                                for this category
*/
CREATE PROC delPlaceFromCategory
(
  @parentCategory categoryIdentifier,
  @URL UrlType
)
AS
BEGIN
  DECLARE @lastError int
  DECLARE @category categoryIdentifier
  DECLARE @rowsDeleted int
  
  BEGIN TRAN delPlaceFromCategory
    SELECT @category = category
      FROM categories
      WHERE ( category = @parentCategory )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN delPlaceFromCategory
      RETURN @lastError
    END
    
    IF ( @category IS NULL )
    BEGIN
      ROLLBACK TRAN delPlaceFromCategory
      RETURN 20001
    END
    
    DELETE placeCategories
      WHERE ( category = @parentCategory ) AND
            ( URL = @URL )
    
    SELECT @lastError = @@error
    SELECT @rowsDeleted = @@rowcount
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN delPlaceFromCategory
      RETURN @lastError
    END
    
    IF ( @rowsDeleted = 0 )
    BEGIN
      ROLLBACK TRAN delPlaceFromCategory
      RETURN 20002
    END
    
  COMMIT TRAN delPlaceFromCategory
END

go
IF OBJECT_ID('dbo.delPlaceFromCategory') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.delPlaceFromCategory >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.delPlaceFromCategory >>>'
go

/* deleted a place type from the database */
/* input:  placeType
   output: return value is 20001 if place type does not exist,
           0 otherwise
*/
CREATE PROC delPlaceType
(
  @placeType       integer
)
AS
BEGIN
  
  DECLARE @lastError int

  BEGIN TRAN
    SELECT type
      FROM placeTypes
      WHERE type = @placeType
    IF @@rowCount = 0
    BEGIN
      /* place type not found */
      ROLLBACK TRAN
      RETURN 20001
    END
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END

    DELETE placeTypes
    WHERE type = @placeType
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
    
  COMMIT TRAN

END

go
IF OBJECT_ID('dbo.delPlaceType') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.delPlaceType >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.delPlaceType >>>'
go

/* del all items from number and up */
CREATE PROC delPtgItem
(
@serialNumber integer
)
AS
  DELETE
    FROM PTGlist
    WHERE serialNumber >= @serialNumber

go
IF OBJECT_ID('dbo.delPtgItem') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.delPtgItem >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.delPtgItem >>>'
go

/* add a shadow place entry */
CREATE PROC delShadowPlace ( @URL longName )
AS
  DELETE shadowPlaces
    WHERE URL = @URL

go
IF OBJECT_ID('dbo.delShadowPlace') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.delShadowPlace >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.delShadowPlace >>>'
go

/* del all items from number and up */
CREATE PROC delVpPlacesList
(
@serialNumber integer
)
AS
  DELETE
    FROM vpPlacesList
    WHERE serialNumber >= @serialNumber

go
IF OBJECT_ID('dbo.delVpPlacesList') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.delVpPlacesList >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.delVpPlacesList >>>'
go

/* find all the catgeories */
/*
  INPUT  : NONE
  OUTPUT : list of all the categories, with all their data
*/
CREATE PROC getCategories
AS
  SELECT *
    FROM categories
    ORDER BY description

go
IF OBJECT_ID('dbo.getCategories') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getCategories >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getCategories >>>'
go

/* find all the places belonging to a specific catgeory */
/*
  INPUT  : category ID or NULL for root places
  OUTPUT : all the URLs of places directly related to this category
*/
CREATE PROC getCategoryPlaces
(
  @category categoryIdentifier = NULL
)
AS
BEGIN

  CREATE TABLE #categPlaces (URL varchar(255), type integer)
 
  INSERT #categPlaces
    SELECT URL, 2
      FROM placeCategories
      WHERE ( category = @category )

  UPDATE #categPlaces
    SET type = 0
    WHERE URL IN (SELECT URL FROM persistentPlaces WHERE type != 2049)

  UPDATE #categPlaces
    SET type = 1
    WHERE URL IN (SELECT URL FROM persistentPlaces WHERE type = 2049)

  SELECT *
    FROM #categPlaces

END  

go
IF OBJECT_ID('dbo.getCategoryPlaces') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getCategoryPlaces >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getCategoryPlaces >>>'
go

CREATE PROC getCategoryTree
/*  Get the category subTree from a given category */
/*
INPUT  : category id or NULL for the root category
OUTPUT : the category subTree in the form of a table listing 
         the following fields (when applicable):
	 treeLevel, 
         node type (C = category, P = persistent or cool place, 
                    A = auditorium, R = regular place), 
         category Id, 
         name (category name or URL), 
         protected Flag, 
         title, 
         capacity,
	 auditorium Name, 
         auditorium Id, 
         auditorium client, 
         auditorium welcomeMsg1, 
         auditorium welcomeMsg2, 
         rowSize, 
         numRows
*/
(
@categoryId categoryIdentifier = NULL, 
@level int = 1
)
as
BEGIN
DECLARE @subCategory	categoryIdentifier 
DECLARE @name 		varchar(30)
DECLARE @subLevel 	integer
DECLARE @URL 		varchar(255)
DECLARE @type 		integer
DECLARE @title 		varchar(255)
DECLARE @capacity 	integer
DECLARE @protected 	bit
DECLARE @vptype 	integer
DECLARE @audName 	varchar(16)
DECLARE @audId          numeric(10,0)
DECLARE @client 	varchar(16)
DECLARE @welc1 		varchar(255) 
DECLARE @welc2 		varchar(255)
DECLARE @rowSize	integer
DECLARE @numRows	integer

SELECT @subLevel = @level + 1

IF (@level = 1)
  DELETE tempdb..TreeTable

/* Get subcategories and process them */
DECLARE categCursor CURSOR
  FOR SELECT category, description
    FROM vpplaces..categories
    WHERE ( parentCategeory = @categoryId )
  FOR READ ONLY

OPEN categCursor
FETCH categCursor INTO @subCategory, @name
WHILE (@@SQLSTATUS = 0)
BEGIN
    INSERT tempdb..TreeTable
      VALUES(@level, "C", @subCategory, @name, 0, NULL, NULL, NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL) 
    EXEC getCategoryTree @subCategory, @subLevel
    FETCH categCursor INTO @subCategory, @name
END

CLOSE categCursor

/* Get category Places with all the information about them */
/* Get list of places in temporary table */
CREATE TABLE #categPlaces (URL varchar(255), type integer)

IF @categoryId = NULL
BEGIN
  INSERT #categPlaces
    SELECT URL,0 
      FROM persistentPlaces 
      WHERE URL NOT IN (SELECT URL FROM placeCategories)

  UPDATE #categPlaces
    SET type = 1
    WHERE URL IN (SELECT URL FROM persistentPlaces WHERE type = 2049)
END
ELSE
BEGIN
  INSERT #categPlaces
    SELECT URL, 2
      FROM vpplaces..placeCategories
      WHERE ( category = @categoryId )

  UPDATE #categPlaces
    SET type = 0
    WHERE URL IN (SELECT URL FROM vpplaces..persistentPlaces WHERE type != 2049)

  UPDATE #categPlaces
    SET type = 1
    WHERE URL IN (SELECT URL FROM vpplaces..persistentPlaces WHERE type = 2049)
END

/* Process each place according to its type */
IF @categoryId = NULL
  SELECT @categoryId = 0

DECLARE placesCursor CURSOR
  FOR SELECT * 
    FROM #categPlaces
  FOR READ ONLY

OPEN placesCursor
FETCH placesCursor INTO @URL, @type
WHILE (@@SQLSTATUS = 0)
BEGIN
    IF @type = 0           /* Cool Place */
    BEGIN
      SELECT @title = title, @capacity = roomCapacity, @protected = roomProtected, @vptype = type
        FROM vpplaces..persistentPlaces
        WHERE URL = @URL
      INSERT tempdb..TreeTable
        VALUES(@level, "P", @categoryId, @URL, @protected, @vptype, @title, @capacity, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL) 
    END
    ELSE 
    IF @type = 1           /* Auditorium */
    BEGIN
      SELECT @audName = name, @audId = auditoriumID, @client = client, @title = title, @capacity = stageCapacity, 
             @welc1 = welcomeMsg1, @welc2 = welcomeMsg2, @rowSize = rowSize, 
             @numRows = numberOfRows
        FROM audset..auditoriums
        WHERE background = @URL
      IF (@welc2 = NULL)	/* This should be the only field that could be NULL */
        SELECT @welc2 = " " 	
      INSERT tempdb..TreeTable
        VALUES(@level, "A", @categoryId, @URL, 1, NULL, @title, @capacity, @audName, @audId, @client,
             @welc1, @welc2, @rowSize, @numRows) 
    END
    ELSE                        /* Regular place */
      INSERT tempdb..TreeTable
        VALUES(@level, "R", @categoryId, @URL, 0, NULL, NULL, NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL)     
    FETCH placesCursor INTO @URL, @type    
END

CLOSE placesCursor

DROP TABLE #categPlaces

IF (@level = 1)
BEGIN
  SELECT * 
    FROM tempdb..TreeTable

  DROP TABLE tempdb..TreeTable
END

END

go
IF OBJECT_ID('dbo.getCategoryTree') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getCategoryTree >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getCategoryTree >>>'
go

/* get total of buddy list users */
CREATE PROC getCurrentBLTotal
AS
BEGIN
  DECLARE @lastError int
  DECLARE @total int
  DECLARE @time VpTime
  
  BEGIN TRAN getCurrentBLTotal
    SELECT @time = max(time)
      FROM totalUsage
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN getCurrentBLTotal
      SELECT BLTotal = 0
      RETURN @lastError
    END
    
    SELECT @total = BLUsage
      FROM totalUsage
      WHERE time = @time
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN getCurrentBLTotal
      SELECT BLTotal = 0
      RETURN @lastError
    END
    
    IF @total IS NULL
      SELECT @total = 0
    
    SELECT BLTotal = @total
    
  COMMIT TRAN getCurrentBLTotal
END

go
IF OBJECT_ID('dbo.getCurrentBLTotal') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getCurrentBLTotal >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getCurrentBLTotal >>>'
go

/*
get total number of chatters = 
total numbe of users - total number of buddy list users 
*/
CREATE PROC getCurrentChatTotal
AS
BEGIN
  DECLARE @lastError int
  DECLARE @BLTotal int
  DECLARE @roomUsage int
  DECLARE @corrUsage int
  DECLARE @time VpTime
  
  BEGIN TRAN getCurrentChatTotal
    SELECT @time = max(time)
      FROM totalUsage
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN getCurrentChatTotal
      SELECT roomUsage = 0, corrUsage = 0
      RETURN @lastError
    END
    
    SELECT @roomUsage = roomUsage, @corrUsage = corrUsage, @BLTotal = BLUsage
      FROM totalUsage
      WHERE time = @time
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN getCurrentChatTotal
      SELECT roomUsage = 0, corrUsage = 0
      RETURN @lastError
    END
    
    IF @roomUsage IS NULL
      SELECT @roomUsage = 0
    IF @corrUsage IS NULL
      SELECT @corrUsage = 0
    IF @BLTotal IS NULL
      SELECT @BLTotal = 0
    
    SELECT roomUsage = @roomUsage, corrUsage = @corrUsage
    
  COMMIT TRAN getCurrentChatTotal
END

go
IF OBJECT_ID('dbo.getCurrentChatTotal') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getCurrentChatTotal >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getCurrentChatTotal >>>'
go

/* get the usage statistics for a given period of time, by day
   NOTE: dailyUsage is used, so statistics are good only
         up to the previous day

  INPUT  : startTime, endTime
  OUTPUT : time, 
           summary values - ( all users, chat users, Buddy list users ) X 
                            (average)

           e.g. if summary is desired for period starting on 
           January 1st 1997, and ending on January 15th 1997, values will look like this:

           1997 1 1 00:00 <all-avg> <chat-avg> <bl-avg>
           1997 1 2 00:00 <all-avg> <chat-avg> <bl-avg>
           1997 1 3 00:00 <all-avg> <chat-avg> <bl-avg>
            .   . . .       .        .
            .   . . .       .        .
            .   . . .       .        .
            .   . . .       .        .
            .   . . .       .        .
           1997 1 15 00:00 <all-avg> <chat-avg> <bl-avg>

           where each <braced value> is a 4-byte-representable integer.
*/
CREATE PROC getDailyAvgStatistics
(
  @startTime VpTime,
  @endTime VpTime
)
AS
BEGIN
  /* first fix times to include each possible entry from the given days */
  /* make @startTime be 00:00 of the day on which @startTime belongs to */
  SELECT @startTime = dateadd( hour, (-1) * datepart(hour,@startTime), @startTime )
  SELECT @startTime = dateadd( minute, (-1) * datepart(minute,@startTime), @startTime )
  
  /* make @endTime be 23:59 of the day to which @endTime belongs to */
  SELECT @endTime = dateadd( hour, 23 - datepart(hour,@endTime), @endTime )
  SELECT @endTime = dateadd( minute, 59 - datepart(minute,@endTime), @endTime )


  SELECT DISTINCT
         year=datepart( year, d1.time), 
         month=datepart( month, d1.time), 
         day=datepart( day, d1.time),
         hour=0, /* daily summary, so hour is meaningless */
         allAvg=avg(d1.value),
         chatAvg=avg(d2.value),
         BlAvg=avg(d3.value)
  FROM
         dailyUsage d1,
         dailyUsage d2,
         dailyUsage d3
  WHERE	    
         ( d1.time BETWEEN @startTime AND @endTime ) AND
         ( d2.time BETWEEN @startTime AND @endTime ) AND
         ( d3.time BETWEEN @startTime AND @endTime ) AND
         ( datepart(year,d2.time) = datepart(year,d1.time) ) AND
         ( datepart(month,d2.time) = datepart(month,d1.time) ) AND
         ( datepart(day,d2.time) = datepart(day,d1.time) ) AND
         ( datepart(year,d3.time) = datepart(year,d1.time) ) AND
         ( datepart(month,d3.time) = datepart(month,d1.time) ) AND
         ( datepart(day,d3.time) = datepart(day,d1.time) ) AND
         (d1.userType=0) AND (d1.valueType=0) AND
         (d2.userType=1) AND (d2.valueType=0) AND
         (d3.userType=2) AND (d3.valueType=0)

  GROUP BY datepart( year, d1.time), 
           datepart( month, d1.time), 
           datepart( day, d1.time)
  ORDER BY year, month, day


END

go
IF OBJECT_ID('dbo.getDailyAvgStatistics') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getDailyAvgStatistics >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getDailyAvgStatistics >>>'
go

/* get the usage statistics for a given period of time, by day
   NOTE: dailyUsage is used, so statistics are good only
         up to the previous day

  INPUT  : startTime, endTime
  OUTPUT : time, 
           summary values - ( all users, chat users, Buddy list users ) X 
                            (maximum)

           e.g. if summary is desired for period starting on 
           January 1st 1997, and ending on January 15th 1997, values will look like this:

           1997 1 1 00:00 <all-max> <chat-max> <bl-max>
           1997 1 2 00:00 <all-max> <chat-max> <bl-max>
           1997 1 3 00:00 <all-max> <chat-max> <bl-max>
            .   . . .       .        .
            .   . . .       .        .
            .   . . .       .        .
            .   . . .       .        .
            .   . . .       .        .
           1997 1 15 00:00 <all-max> <chat-max> <bl-max>

           where each <braced value> is a 4-byte-representable integer.
*/
CREATE PROC getDailyMaxStatistics
(
  @startTime VpTime,
  @endTime VpTime
)
AS
BEGIN
  /* first fix times to include each possible entry from the given days */
  /* make @startTime be 00:00 of the day on which @startTime belongs to */
  SELECT @startTime = dateadd( hour, (-1) * datepart(hour,@startTime), @startTime )
  SELECT @startTime = dateadd( minute, (-1) * datepart(minute,@startTime), @startTime )
  
  /* make @endTime be 23:59 of the day to which @endTime belongs to */
  SELECT @endTime = dateadd( hour, 23 - datepart(hour,@endTime), @endTime )
  SELECT @endTime = dateadd( minute, 59 - datepart(minute,@endTime), @endTime )


  SELECT DISTINCT
         year=datepart( year, d1.time), 
         month=datepart( month, d1.time), 
         day=datepart( day, d1.time),
         hour=0, /* daily summary, so hour is meaningless */
         allMax=max(d1.value),
         chatMax=max(d2.value),
         BlMax=max(d3.value)
  FROM
         dailyUsage d1,
         dailyUsage d2,
         dailyUsage d3
  WHERE	    
         ( d1.time BETWEEN @startTime AND @endTime ) AND
         ( d2.time BETWEEN @startTime AND @endTime ) AND
         ( d3.time BETWEEN @startTime AND @endTime ) AND
         ( datepart(year,d2.time) = datepart(year,d1.time) ) AND
         ( datepart(month,d2.time) = datepart(month,d1.time) ) AND
         ( datepart(day,d2.time) = datepart(day,d1.time) ) AND
         ( datepart(year,d3.time) = datepart(year,d1.time) ) AND
         ( datepart(month,d3.time) = datepart(month,d1.time) ) AND
         ( datepart(day,d3.time) = datepart(day,d1.time) ) AND
         (d1.userType=0) AND (d1.valueType=2) AND
         (d2.userType=1) AND (d2.valueType=2) AND
         (d3.userType=2) AND (d3.valueType=2)

  GROUP BY datepart( year, d1.time), 
           datepart( month, d1.time), 
           datepart( day, d1.time)
  ORDER BY year, month, day


END

go
IF OBJECT_ID('dbo.getDailyMaxStatistics') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getDailyMaxStatistics >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getDailyMaxStatistics >>>'
go

/* get the usage statistics for a given period of time, by day
   NOTE: dailyUsage is used, so statistics are good only
         up to the previous day

  INPUT  : startTime, endTime
  OUTPUT : time, 
           summary values - ( all users, chat users, Buddy list users ) X 
                            (minimum)

           e.g. if summary is desired for period starting on 
           January 1st 1997, and ending on January 15th 1997, values will look like this:

           1997 1 1 00:00 <all-min> <chat-min> <bl-min>
           1997 1 2 00:00 <all-min> <chat-min> <bl-min>
           1997 1 3 00:00 <all-min> <chat-min> <bl-min>
            .   . . .       .        .
            .   . . .       .        .
            .   . . .       .        .
            .   . . .       .        .
            .   . . .       .        .
           1997 1 15 00:00 <all-min> <chat-min> <bl-min>

           where each <braced value> is a 4-byte-representable integer.
*/
CREATE PROC getDailyMinStatistics
(
  @startTime VpTime,
  @endTime VpTime
)
AS
BEGIN
  /* first fix times to include each possible entry from the given days */
  /* make @startTime be 00:00 of the day on which @startTime belongs to */
  SELECT @startTime = dateadd( hour, (-1) * datepart(hour,@startTime), @startTime )
  SELECT @startTime = dateadd( minute, (-1) * datepart(minute,@startTime), @startTime )
  
  /* make @endTime be 23:59 of the day to which @endTime belongs to */
  SELECT @endTime = dateadd( hour, 23 - datepart(hour,@endTime), @endTime )
  SELECT @endTime = dateadd( minute, 59 - datepart(minute,@endTime), @endTime )


  SELECT DISTINCT
         year=datepart( year, d1.time), 
         month=datepart( month, d1.time), 
         day=datepart( day, d1.time),
         hour=0, /* daily summary, so hour is meaningless */
         allMin=min(d1.value),
         chatMin=min(d2.value),
         BlMin=min(d3.value)
  FROM
         dailyUsage d1,
         dailyUsage d2,
         dailyUsage d3
  WHERE	    
         ( d1.time BETWEEN @startTime AND @endTime ) AND
         ( d2.time BETWEEN @startTime AND @endTime ) AND
         ( d3.time BETWEEN @startTime AND @endTime ) AND
         ( datepart(year,d2.time) = datepart(year,d1.time) ) AND
         ( datepart(month,d2.time) = datepart(month,d1.time) ) AND
         ( datepart(day,d2.time) = datepart(day,d1.time) ) AND
         ( datepart(year,d3.time) = datepart(year,d1.time) ) AND
         ( datepart(month,d3.time) = datepart(month,d1.time) ) AND
         ( datepart(day,d3.time) = datepart(day,d1.time) ) AND
         (d1.userType=0) AND (d1.valueType=1) AND
         (d2.userType=1) AND (d2.valueType=1) AND
         (d3.userType=2) AND (d3.valueType=1)

  GROUP BY datepart( year, d1.time), 
           datepart( month, d1.time), 
           datepart( day, d1.time)
  ORDER BY year, month, day


END

go
IF OBJECT_ID('dbo.getDailyMinStatistics') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getDailyMinStatistics >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getDailyMinStatistics >>>'
go

/* get the usage statistics for a given period of time, by day
   NOTE: dailyUsage is used, so statistics are good only
         up to the previous day

  INPUT  : startTime, endTime
  OUTPUT : time, 
           summary values - ( all users, chat users, Buddy list users ) X 
                            (average, minimum, maximum)

           e.g. if summary is desired for period starting on 
           January 1st 1997, and ending on January 15th 1997, values will look like this:

           1997 1 1 00:00 <all-avg> <all-min> <all-max>...<bl-avg> <bl-min> <bl-max>
           1997 1 2 00:00 <all-avg> <all-min> <all-max>...<bl-avg> <bl-min> <bl-max>
           1997 1 3 00:00 <all-avg> <all-min> <all-max>...<bl-avg> <bl-min> <bl-max>
            .   . . .       .        .
            .   . . .       .        .
            .   . . .       .        .
            .   . . .       .        .
            .   . . .       .        .
           1997 1 15 00:00 <all-avg> <all-min> <all-max>...<bl-avg> <bl-min> <bl-max>

           where each <braced value> is a 4-byte-representable integer.
*/
CREATE PROC getDailyStatistics
(
  @startTime VpTime,
  @endTime VpTime
)
AS
BEGIN
  /* first fix times to include each possible entry from the given days */
  /* make @startTime be 00:00 of the day on which @startTime belongs to */
  SELECT @startTime = dateadd( hour, (-1) * datepart(hour,@startTime), @startTime )
  SELECT @startTime = dateadd( minute, (-1) * datepart(minute,@startTime), @startTime )
  
  /* make @endTime be 23:59 of the day to which @endTime belongs to */
  SELECT @endTime = dateadd( hour, 23 - datepart(hour,@endTime), @endTime )
  SELECT @endTime = dateadd( minute, 59 - datepart(minute,@endTime), @endTime )

  SELECT DISTINCT
         year=datepart( year, d1.time), 
         month=datepart( month, d1.time), 
         day=datepart( day, d1.time),
         hour=0, /* daily summary, so hour is meaningless */
         allAvg=avg(d1.value),
         allMin=min(d2.value),
         allMax=max(d3.value),
         chatAvg=avg(d4.value),
         chatMin=min(d5.value),
         chatMax=max(d6.value),
         BlAvg=avg(d7.value),
         BlMin=min(d8.value),
         BlMax=max(d9.value)
  FROM
         dailyUsage d1,
         dailyUsage d2,
         dailyUsage d3,
         dailyUsage d4,
         dailyUsage d5,
         dailyUsage d6,
         dailyUsage d7,
         dailyUsage d8,
         dailyUsage d9
  WHERE	    
         ( d1.time BETWEEN @startTime AND @endTime ) AND
         ( d2.time BETWEEN @startTime AND @endTime ) AND
         ( d3.time BETWEEN @startTime AND @endTime ) AND
         ( d4.time BETWEEN @startTime AND @endTime ) AND
         ( d5.time BETWEEN @startTime AND @endTime ) AND
         ( d6.time BETWEEN @startTime AND @endTime ) AND
         ( d7.time BETWEEN @startTime AND @endTime ) AND
         ( d8.time BETWEEN @startTime AND @endTime ) AND
         ( d9.time BETWEEN @startTime AND @endTime ) AND
         ( datepart(year,d2.time) = datepart(year,d1.time) ) AND
         ( datepart(month,d2.time) = datepart(month,d1.time) ) AND
         ( datepart(day,d2.time) = datepart(day,d1.time) ) AND
         ( datepart(year,d3.time) = datepart(year,d2.time) ) AND
         ( datepart(month,d3.time) = datepart(month,d2.time) ) AND
         ( datepart(day,d3.time) = datepart(day,d2.time) ) AND
         ( datepart(year,d4.time) = datepart(year,d3.time) ) AND
         ( datepart(month,d4.time) = datepart(month,d3.time) ) AND
         ( datepart(day,d4.time) = datepart(day,d3.time) ) AND
         ( datepart(year,d5.time) = datepart(year,d4.time) ) AND
         ( datepart(month,d5.time) = datepart(month,d4.time) ) AND
         ( datepart(day,d5.time) = datepart(day,d4.time) ) AND
         ( datepart(year,d6.time) = datepart(year,d5.time) ) AND
         ( datepart(month,d6.time) = datepart(month,d5.time) ) AND
         ( datepart(day,d6.time) = datepart(day,d5.time) ) AND
         ( datepart(year,d7.time) = datepart(year,d6.time) ) AND
         ( datepart(month,d7.time) = datepart(month,d6.time) ) AND
         ( datepart(day,d7.time) = datepart(day,d6.time) ) AND
         ( datepart(year,d8.time) = datepart(year,d7.time) ) AND
         ( datepart(month,d8.time) = datepart(month,d7.time) ) AND
         ( datepart(day,d8.time) = datepart(day,d7.time) ) AND
         ( datepart(year,d9.time) = datepart(year,d8.time) ) AND
         ( datepart(month,d9.time) = datepart(month,d8.time) ) AND
         ( datepart(day,d9.time) = datepart(day,d8.time) ) AND
         (d1.userType=0) AND (d1.valueType=0) AND
         (d2.userType=0) AND (d2.valueType=1) AND
         (d3.userType=0) AND (d3.valueType=2) AND
         (d4.userType=1) AND (d4.valueType=0) AND
         (d5.userType=1) AND (d5.valueType=1) AND
         (d6.userType=1) AND (d6.valueType=2) AND
         (d7.userType=2) AND (d7.valueType=0) AND
         (d8.userType=2) AND (d8.valueType=1) AND
         (d9.userType=2) AND (d9.valueType=2)

  ORDER BY year, month, day, hour


END

go
IF OBJECT_ID('dbo.getDailyStatistics') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getDailyStatistics >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getDailyStatistics >>>'
go

/* get the total usage statistics for a given period of time, by day
   the number is a sum over the whole period, thus giving a good
   estimate of the number of usage minutes

  INPUT  : startTime, endTime
  OUTPUT : time,
           summary values - ( all users, chat users, Buddy list users ) X 
                            (sum)

           e.g. if summary is desired for period starting on 
           January 15th 1997, 12:20, and ending on January 16th 1997, 21:17, values will look like this:

           1997 1 15 12:00 <all-sum> <chat-sum> <bl-sum>
           1997 1 15 13:00 <all-sum> <chat-sum> <bl-sum>
           1997 1 15 14:00 <all-sum> <chat-sum> <bl-sum>
            .   . . .       .        .
            .   . . .       .        .
            .   . . .       .        .
            .   . . .       .        .
            .   . . .       .        .
           1997 1 16 21:00 <all-sum> <chat-sum> <bl-sum>

           where each <braced value> is a 4-byte-representable integer.
           note that the start of the hour for the respective hours are used,
           so that the data is correct for all of the regarded hours.
*/
CREATE PROC getDailyTotalStatistics
(
  @startTime VpTime,
  @endTime VpTime
)
AS
BEGIN
  /* first fix times to include each possible entry from the given days */
  /* make @startTime be 00:00 of the day on which @startTime belongs to */
  SELECT @startTime = dateadd( hour, (-1) * datepart(hour,@startTime), @startTime )
  SELECT @startTime = dateadd( minute, (-1) * datepart(minute,@startTime), @startTime )
  
  /* make @endTime be 23:59 of the day to which @endTime belongs to */
  SELECT @endTime = dateadd( hour, 23 - datepart(hour,@endTime), @endTime )
  SELECT @endTime = dateadd( minute, 59 - datepart(minute,@endTime), @endTime )

  SELECT DISTINCT
         year=datepart( year, time),
         month=datepart( month, time),
         day=datepart( day, time),
         hour=0,
         allSum=sum(totalUsage),
         chatSum=sum(roomUsage+corrUsage),
         BlSum=sum(BLUsage)
  FROM totalUsage
  WHERE ( time BETWEEN @startTime AND @endTime )
  GROUP BY datepart( year, time), datepart( month, time), datepart( day, time)
  ORDER BY year, month, day
  
END

go
IF OBJECT_ID('dbo.getDailyTotalStatistics') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getDailyTotalStatistics >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getDailyTotalStatistics >>>'
go

/* get the average usage statistics for a given period of time, by hour

  INPUT  : startTime, endTime
  OUTPUT : time,
           summary values - ( all users, chat users, Buddy list users ) X 
                            (average)

           e.g. if summary is desired for period starting on 
           January 15th 1997, 12:20, and ending on January 16th 1997, 21:17, values will look like this:

           1997 1 15 12:00 <all-avg> <chat-avg> <bl-avg>
           1997 1 15 13:00 <all-avg> <chat-avg> <bl-avg>
           1997 1 15 14:00 <all-avg> <chat-avg> <bl-avg>
            .   . . .       .        .
            .   . . .       .        .
            .   . . .       .        .
            .   . . .       .        .
            .   . . .       .        .
           1997 1 16 21:00 <all-avg> <chat-avg> <bl-avg>

           where each <braced value> is a 4-byte-representable integer.
           note that the start of the hour for the respective hours are used,
           so that the data is correct for all of the regarded hours.
*/
CREATE PROC getHourlyAvgStatistics
(
  @startTime VpTime,
  @endTime VpTime
)
AS
BEGIN
  /* first fix times to include each possible entry from the given hours */
  /* make @startTime be the start of the hour which @startTime belongs to */
  SELECT @startTime = dateadd( minute, (-1) * datepart(minute,@startTime), @startTime )
  
  /* make @endTime be 23:59 of the last day on the hour which @endTime belongs to */
  SELECT @endTime = dateadd( minute, 59 - datepart(minute,@endTime), @endTime )

  SELECT DISTINCT
         year=datepart( year, time),
         month=datepart( month, time),
         day=datepart( day, time),
         hour=datepart( hour, time),
         allAvg=avg(totalUsage),
         chatAvg=avg(roomUsage+corrUsage),
         BlAvg=avg(BLUsage)
  FROM totalUsage
  WHERE ( time BETWEEN @startTime AND @endTime )
  GROUP BY datepart( year, time), datepart( month, time), datepart( day, time), datepart( hour, time)
  ORDER BY year, month, day, hour
  
END

go
IF OBJECT_ID('dbo.getHourlyAvgStatistics') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getHourlyAvgStatistics >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getHourlyAvgStatistics >>>'
go

/* get the maximum usage statistics for a given period of time, by hour

  INPUT  : startTime, endTime
  OUTPUT : time,
           summary values - ( all users, chat users, Buddy list users ) X 
                            (maximum)

           e.g. if summary is desired for period starting on 
           January 15th 1997, 12:20, and ending on January 16th 1997, 21:17, values will look like this:

           1997 1 15 12:00 <all-max> <chat-max> <bl-max>
           1997 1 15 13:00 <all-max> <chat-max> <bl-max>
           1997 1 15 14:00 <all-max> <chat-max> <bl-max>
            .   . . .       .        .
            .   . . .       .        .
            .   . . .       .        .
            .   . . .       .        .
            .   . . .       .        .
           1997 1 16 21:00 <all-max> <chat-max> <bl-max>

           where each <braced value> is a 4-byte-representable integer.
           note that the start of the hour for the respective hours are used,
           so that the data is correct for all of the regarded hours.
*/
CREATE PROC getHourlyMaxStatistics
(
  @startTime VpTime,
  @endTime VpTime
)
AS
BEGIN
  /* first fix times to include each possible entry from the given hours */
  /* make @startTime be the start of the hour which @startTime belongs to */
  SELECT @startTime = dateadd( minute, (-1) * datepart(minute,@startTime), @startTime )
  
  /* make @endTime be 23:59 of the last day on the hour which @endTime belongs to */
  SELECT @endTime = dateadd( minute, 59 - datepart(minute,@endTime), @endTime )

  SELECT DISTINCT
         year=datepart( year, time),
         month=datepart( month, time),
         day=datepart( day, time),
         hour=datepart( hour, time),
         allMax=max(totalUsage),
         chatMax=max(roomUsage+corrUsage),
         BlMax=max(BLUsage)
  FROM totalUsage
  WHERE ( time BETWEEN @startTime AND @endTime )
  GROUP BY datepart( year, time), datepart( month, time), datepart( day, time), datepart( hour, time)
  ORDER BY year, month, day, hour
  
END

go
IF OBJECT_ID('dbo.getHourlyMaxStatistics') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getHourlyMaxStatistics >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getHourlyMaxStatistics >>>'
go

/* get the minimum usage statistics for a given period of time, by hour

  INPUT  : startTime, endTime
  OUTPUT : time,
           summary values - ( all users, chat users, Buddy list users ) X 
                            (minimum)

           e.g. if summary is desired for period starting on 
           January 15th 1997, 12:20, and ending on January 16th 1997, 21:17, values will look like this:

           1997 1 15 12:00 <all-min> <chat-min> <bl-min>
           1997 1 15 13:00 <all-min> <chat-min> <bl-min>
           1997 1 15 14:00 <all-min> <chat-min> <bl-min>
            .   . . .       .        .
            .   . . .       .        .
            .   . . .       .        .
            .   . . .       .        .
            .   . . .       .        .
           1997 1 16 21:00 <all-min> <chat-min> <bl-min>

           where each <braced value> is a 4-byte-representable integer.
           note that the start of the hour for the respective hours are used,
           so that the data is correct for all of the regarded hours.
*/
CREATE PROC getHourlyMinStatistics
(
  @startTime VpTime,
  @endTime VpTime
)
AS
BEGIN
  /* first fix times to include each possible entry from the given hours */
  /* make @startTime be the start of the hour which @startTime belongs to */
  SELECT @startTime = dateadd( minute, (-1) * datepart(minute,@startTime), @startTime )
  
  /* make @endTime be 23:59 of the last day on the hour which @endTime belongs to */
  SELECT @endTime = dateadd( minute, 59 - datepart(minute,@endTime), @endTime )

  SELECT DISTINCT
         year=datepart( year, time),
         month=datepart( month, time),
         day=datepart( day, time),
         hour=datepart( hour, time),
         allMin=min(totalUsage),
         chatMin=min(roomUsage+corrUsage),
         BlMin=min(BLUsage)
  FROM totalUsage
  WHERE ( time BETWEEN @startTime AND @endTime )
  GROUP BY datepart( year, time), datepart( month, time), datepart( day, time), datepart( hour, time)
  ORDER BY year, month, day, hour
  
END

go
IF OBJECT_ID('dbo.getHourlyMinStatistics') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getHourlyMinStatistics >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getHourlyMinStatistics >>>'
go

/* get the usage statistics for a given period of time, by hour

  INPUT  : startTime, endTime
  OUTPUT : time,
           summary values - ( all users, chat users, Buddy list users ) X 
                            (average, minimum, maximum)

           e.g. if summary is desired for period starting on 
           January 15th 1997, 12:20, and ending on January 16th 1997, 21:17, values will look like this:

           1997 1 15 12:00 <all-avg> <all-min> <all-max>...<bl-avg> <bl-min> <bl-max>
           1997 1 15 13:00 <all-avg> <all-min> <all-max>...<bl-avg> <bl-min> <bl-max>
           1997 1 15 14:00 <all-avg> <all-min> <all-max>...<bl-avg> <bl-min> <bl-max>
            .   . . .       .        .
            .   . . .       .        .
            .   . . .       .        .
            .   . . .       .        .
            .   . . .       .        .
           1997 1 16 21:00 <all-avg> <all-min> <all-max>...<bl-avg> <bl-min> <bl-max>

           where each <braced value> is a 4-byte-representable integer.
           note that the start of the hour for the respective hours are used,
           so that the data is correct for all of the regarded hours.
*/
CREATE PROC getHourlyStatistics
(
  @startTime VpTime,
  @endTime VpTime
)
AS
BEGIN
  /* first fix times to include each possible entry from the given hours */
  /* make @startTime be the start of the hour which @startTime belongs to */
  SELECT @startTime = dateadd( minute, (-1) * datepart(minute,@startTime), @startTime )
  
  /* make @endTime be 23:59 of the last day on the hour which @endTime belongs to */
  SELECT @endTime = dateadd( minute, 59 - datepart(minute,@endTime), @endTime )

  SELECT DISTINCT
         year=datepart( year, time),
         month=datepart( month, time),
         day=datepart( day, time),
         hour=datepart( hour, time),
         allAvg=avg(totalUsage),
         allMin=min(totalUsage),
         allMax=max(totalUsage),
         chatAvg=avg(roomUsage+corrUsage),
         chatMin=min(roomUsage+corrUsage),
         chatMax=max(roomUsage+corrUsage),
         BlAvg=avg(BLUsage),
         BlMin=min(BLUsage),
         BlMax=max(BLUsage)
  FROM totalUsage
  WHERE ( time BETWEEN @startTime AND @endTime )
  GROUP BY datepart( year, time), datepart( month, time), datepart( day, time), datepart( hour, time)
  ORDER BY year, month, day, hour
  
END

go
IF OBJECT_ID('dbo.getHourlyStatistics') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getHourlyStatistics >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getHourlyStatistics >>>'
go

/* get the total usage statistics for a given period of time, by hour
   the number is a sum over the whole period, thus giving a good
   estimate of the number of usage minutes

  INPUT  : startTime, endTime
  OUTPUT : time,
           summary values - ( all users, chat users, Buddy list users ) X 
                            (sum)

           e.g. if summary is desired for period starting on 
           January 15th 1997, 12:20, and ending on January 16th 1997, 21:17, values will look like this:

           1997 1 15 12:00 <all-sum> <chat-sum> <bl-sum>
           1997 1 15 13:00 <all-sum> <chat-sum> <bl-sum>
           1997 1 15 14:00 <all-sum> <chat-sum> <bl-sum>
            .   . . .       .        .
            .   . . .       .        .
            .   . . .       .        .
            .   . . .       .        .
            .   . . .       .        .
           1997 1 16 21:00 <all-sum> <chat-sum> <bl-sum>

           where each <braced value> is a 4-byte-representable integer.
           note that the start of the hour for the respective hours are used,
           so that the data is correct for all of the regarded hours.
*/
CREATE PROC getHourlyTotalStatistics
(
  @startTime VpTime,
  @endTime VpTime
)
AS
BEGIN
  /* first fix times to include each possible entry from the given hours */
  /* make @startTime be the start of the hour which @startTime belongs to */
  SELECT @startTime = dateadd( minute, (-1) * datepart(minute,@startTime), @startTime )
  
  /* make @endTime be 23:59 of the last day on the hour which @endTime belongs to */
  SELECT @endTime = dateadd( minute, 59 - datepart(minute,@endTime), @endTime )

  SELECT DISTINCT
         year=datepart( year, time),
         month=datepart( month, time),
         day=datepart( day, time),
         hour=datepart( hour, time),
         allSum=sum(totalUsage),
         chatSum=sum(roomUsage+corrUsage),
         BlSum=sum(BLUsage)
  FROM totalUsage
  WHERE ( time BETWEEN @startTime AND @endTime )
  GROUP BY datepart( year, time), datepart( month, time), datepart( day, time), datepart( hour, time)
  ORDER BY year, month, day, hour
  
END

go
IF OBJECT_ID('dbo.getHourlyTotalStatistics') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getHourlyTotalStatistics >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getHourlyTotalStatistics >>>'
go

/* get the usage statistics for a given period of time, by month
   NOTE: dailyUsage is used, so statistics are good only
         up to the previous day

  INPUT  : startTime, endTime
  OUTPUT : time, 
           summary values - ( all users, chat users, Buddy list users ) X 
                            (average)

           e.g. if summary is desired for period starting on 
           January 1st 1997, and ending on December 31st 1997, values will look like this:

           1997 1 1 00:00 <all-avg> <chat-avg> <bl-avg>  
           1997 2 1 00:00 <all-avg> <chat-avg> <bl-avg>  
           1997 3 1 00:00 <all-avg> <chat-avg> <bl-avg>  
            .   . . .      .	                       
            .   . . .      .	                       
            .   . . .      .	                       
            .   . . .      .	                       
            .   . . .      .	                       
           1997 12 1 00:00 <all-avg> <chat-avg> <bl-avg>>

           where each <braced value> is a 4-byte-representable integer.
           note that the starting days for the respective months are used,
           so that the data is correct for all of the regarded month.
*/
CREATE PROC getMonthlyAvgStatistics
(
  @startTime VpTime,
  @endTime VpTime
)
AS
BEGIN
  /* first fix times to include each possible entry from the given months */
  /* make @startTime be 00:00 of the first day on the month which @startTime belongs to */
  SELECT @startTime = dateadd( day, 1 - datepart(day,@startTime), @startTime )
  SELECT @startTime = dateadd( hour, (-1) * datepart(hour,@startTime), @startTime )
  SELECT @startTime = dateadd( minute, (-1) * datepart(minute,@startTime), @startTime )
  
  /* make @endTime be 23:59 of the last day on the month which @endTime belongs to */
  SELECT @endTime = dateadd( month, 1, @endTime )
  SELECT @endTime = dateadd( day, (-1) * datepart(day,@endTime), @endTime )
  SELECT @endTime = dateadd( hour, 23 - datepart(hour,@endTime), @endTime )
  SELECT @endTime = dateadd( minute, 59 - datepart(minute,@endTime), @endTime )

  SELECT DISTINCT
         year=datepart( year, d1.time), 
         month=datepart( month, d1.time), 
         day=1, /* monthly summary, so day & hour are meaningless */
         hour=0,
         allAvg=avg(d1.value),
         chatAvg=avg(d2.value),
         BlAvg=avg(d3.value)
  FROM
         dailyUsage d1,
         dailyUsage d2,
         dailyUsage d3
  WHERE	    
         ( d1.time BETWEEN @startTime AND @endTime ) AND
         ( d2.time BETWEEN @startTime AND @endTime ) AND
         ( d3.time BETWEEN @startTime AND @endTime ) AND
         ( datepart(year,d2.time) = datepart(year,d1.time) ) AND
         ( datepart(month,d2.time) = datepart(month,d1.time) ) AND
         ( datepart(year,d3.time) = datepart(year,d1.time) ) AND
         ( datepart(month,d3.time) = datepart(month,d1.time) ) AND
         (d1.userType=0) AND (d1.valueType=0) AND
         (d2.userType=1) AND (d2.valueType=0) AND
         (d3.userType=2) AND (d3.valueType=0)

  GROUP BY datepart( year, d1.time), datepart( month, d1.time)
  ORDER BY year, month


END

go
IF OBJECT_ID('dbo.getMonthlyAvgStatistics') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getMonthlyAvgStatistics >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getMonthlyAvgStatistics >>>'
go

/* get the usage statistics for a given period of time, by month
   NOTE: dailyUsage is used, so statistics are good only
         up to the previous day

  INPUT  : startTime, endTime
  OUTPUT : time, 
           summary values - ( all users, chat users, Buddy list users ) X 
                            (maximum)

           e.g. if summary is desired for period starting on 
           January 1st 1997, and ending on December 31st 1997, values will look like this:

           1997 1 1 00:00 <all-max> <chat-max> <bl-max>  
           1997 2 1 00:00 <all-max> <chat-max> <bl-max>  
           1997 3 1 00:00 <all-max> <chat-max> <bl-max>  
            .   . . .      .	                       
            .   . . .      .	                       
            .   . . .      .	                       
            .   . . .      .	                       
            .   . . .      .	                       
           1997 12 1 00:00 <all-max> <chat-max> <bl-max>>

           where each <braced value> is a 4-byte-representable integer.
           note that the starting days for the respective months are used,
           so that the data is correct for all of the regarded month.
*/
CREATE PROC getMonthlyMaxStatistics
(
  @startTime VpTime,
  @endTime VpTime
)
AS
BEGIN
  /* first fix times to include each possible entry from the given months */
  /* make @startTime be 00:00 of the first day on the month which @startTime belongs to */
  SELECT @startTime = dateadd( day, 1 - datepart(day,@startTime), @startTime )
  SELECT @startTime = dateadd( hour, (-1) * datepart(hour,@startTime), @startTime )
  SELECT @startTime = dateadd( minute, (-1) * datepart(minute,@startTime), @startTime )
  
  /* make @endTime be 23:59 of the last day on the month which @endTime belongs to */
  SELECT @endTime = dateadd( month, 1, @endTime )
  SELECT @endTime = dateadd( day, (-1) * datepart(day,@endTime), @endTime )
  SELECT @endTime = dateadd( hour, 23 - datepart(hour,@endTime), @endTime )
  SELECT @endTime = dateadd( minute, 59 - datepart(minute,@endTime), @endTime )
  
  SELECT DISTINCT
         year=datepart( year, d1.time), 
         month=datepart( month, d1.time), 
         day=1, /* monthly summary, so day & hour are meaningless */
         hour=0,
         allMax=max(d1.value),
         chatMax=max(d2.value),
         BlMax=max(d3.value)
  FROM
         dailyUsage d1,
         dailyUsage d2,
         dailyUsage d3
  WHERE	    
         ( d1.time BETWEEN @startTime AND @endTime ) AND
         ( d2.time BETWEEN @startTime AND @endTime ) AND
         ( d3.time BETWEEN @startTime AND @endTime ) AND
         ( datepart(year,d2.time) = datepart(year,d1.time) ) AND
         ( datepart(month,d2.time) = datepart(month,d1.time) ) AND
         ( datepart(year,d3.time) = datepart(year,d1.time) ) AND
         ( datepart(month,d3.time) = datepart(month,d1.time) ) AND
         (d1.userType=0) AND (d1.valueType=2) AND
         (d2.userType=1) AND (d2.valueType=2) AND
         (d3.userType=2) AND (d3.valueType=2)

  GROUP BY datepart( year, d1.time), datepart( month, d1.time)
  ORDER BY year, month


END

go
IF OBJECT_ID('dbo.getMonthlyMaxStatistics') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getMonthlyMaxStatistics >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getMonthlyMaxStatistics >>>'
go

/* get the usage statistics for a given period of time, by month
   NOTE: dailyUsage is used, so statistics are good only
         up to the previous day

  INPUT  : startTime, endTime
  OUTPUT : time, 
           summary values - ( all users, chat users, Buddy list users ) X 
                            (minimum)

           e.g. if summary is desired for period starting on 
           January 1st 1997, and ending on December 31st 1997, values will look like this:

           1997 1 1 00:00 <all-min> <chat-min> <bl-min>  
           1997 2 1 00:00 <all-min> <chat-min> <bl-min>  
           1997 3 1 00:00 <all-min> <chat-min> <bl-min>  
            .   . . .      .	                       
            .   . . .      .	                       
            .   . . .      .	                       
            .   . . .      .	                       
            .   . . .      .	                       
           1997 12 1 00:00 <all-min> <chat-min> <bl-min>>

           where each <braced value> is a 4-byte-representable integer.
           note that the starting days for the respective months are used,
           so that the data is correct for all of the regarded month.
*/
CREATE PROC getMonthlyMinStatistics
(
  @startTime VpTime,
  @endTime VpTime
)
AS
BEGIN
  /* first fix times to include each possible entry from the given months */
  /* make @startTime be 00:00 of the first day on the month which @startTime belongs to */
  SELECT @startTime = dateadd( day, 1 - datepart(day,@startTime), @startTime )
  SELECT @startTime = dateadd( hour, (-1) * datepart(hour,@startTime), @startTime )
  SELECT @startTime = dateadd( minute, (-1) * datepart(minute,@startTime), @startTime )
  
  /* make @endTime be 23:59 of the last day on the month which @endTime belongs to */
  SELECT @endTime = dateadd( month, 1, @endTime )
  SELECT @endTime = dateadd( day, (-1) * datepart(day,@endTime), @endTime )
  SELECT @endTime = dateadd( hour, 23 - datepart(hour,@endTime), @endTime )
  SELECT @endTime = dateadd( minute, 59 - datepart(minute,@endTime), @endTime )
  
  SELECT DISTINCT
         year=datepart( year, d1.time), 
         month=datepart( month, d1.time), 
         day=1, /* monthly summary, so day & hour are meaningless */
         hour=0,
         allMin=min(d1.value),
         chatMin=min(d2.value),
         BlMin=min(d3.value)
  FROM
         dailyUsage d1,
         dailyUsage d2,
         dailyUsage d3
  WHERE	    
         ( d1.time BETWEEN @startTime AND @endTime ) AND
         ( d2.time BETWEEN @startTime AND @endTime ) AND
         ( d3.time BETWEEN @startTime AND @endTime ) AND
         ( datepart(year,d2.time) = datepart(year,d1.time) ) AND
         ( datepart(month,d2.time) = datepart(month,d1.time) ) AND
         ( datepart(year,d3.time) = datepart(year,d1.time) ) AND
         ( datepart(month,d3.time) = datepart(month,d1.time) ) AND
         (d1.userType=0) AND (d1.valueType=1) AND
         (d2.userType=1) AND (d2.valueType=1) AND
         (d3.userType=2) AND (d3.valueType=1)

  GROUP BY datepart( year, d1.time), datepart( month, d1.time)
  ORDER BY year, month


END

go
IF OBJECT_ID('dbo.getMonthlyMinStatistics') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getMonthlyMinStatistics >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getMonthlyMinStatistics >>>'
go

/* find all persistent places */
CREATE PROC getPPlaces
AS
BEGIN
  SELECT *
    FROM persistentPlaces

END

go
IF OBJECT_ID('dbo.getPPlaces') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getPPlaces >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getPPlaces >>>'
go

/* find all persistent places changes */
CREATE PROC getPPlacesChanges
AS
BEGIN

  /* find added data */
  SELECT DATA.*
    FROM persistentPlacesChange,
        persistentPlaces DATA
    WHERE persistentPlacesChange.URL = DATA.URL
    AND change = "A"

  /* find all changes */
  SELECT URL,change
    FROM persistentPlacesChange

  DELETE 
    FROM persistentPlacesChange

END

go
IF OBJECT_ID('dbo.getPPlacesChanges') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getPPlacesChanges >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getPPlacesChanges >>>'
go

/* Find all places for a given PTG page
 */
/*
  INPUT  : pageType (Cool = 0, Events = 1, All= 2, Category = 3),
           category id, exclude shadow places flag,
           unify replicates flag, minimum people in place
  OUTPUT : all details from the PTG list file 
*/
CREATE PROC getPagePlaces(
	@pageType	integer,
	@categoryId	categoryIdentifier,
	@exclShadow	bit,
	@unifyRepl	bit,
	@minPeople	integer
)
AS
BEGIN
  DECLARE @lastError integer

  CREATE TABLE #tempTable (URL varchar(255), title varchar(255), 
                           roomUsage integer, corrUsage integer, type integer,
			   capacity integer, repCount integer)
  SELECT @lastError = @@error
  IF @lastError != 0
    RETURN @lastError

  IF @pageType = 0		/* Cool Places */
   INSERT #tempTable 
      SELECT URL,title,roomUsage,corrUsage,type,capacity,repCount
        FROM vpPlacesList 
        WHERE URL NOT LIKE "vpbuddy://%" AND
              serialNumber != -1 AND
              URL IN (SELECT URL 
		      FROM persistentPlaces 
                      WHERE type != 2049)
  ELSE
  IF @pageType = 1		/* Auditorium Places */
  BEGIN
    INSERT #tempTable
      SELECT URL,title,roomUsage,corrUsage,type,capacity,repCount
        FROM vpPlacesList 
        WHERE URL NOT LIKE "vpbuddy://%" AND
              serialNumber != -1 AND
              URL IN (SELECT URL 
		      FROM persistentPlaces 
                      WHERE type = 2049)
    SELECT @lastError = @@error
    IF @lastError != 0
      RETURN @lastError

    UPDATE #tempTable
      SET capacity = rowSize * numberOfRows
      FROM #tempTable, persistentPlaces
      WHERE #tempTable.URL = persistentPlaces.URL
  END  
  ELSE
  IF @pageType = 2		/* All Places */
    INSERT #tempTable
      SELECT URL,title,roomUsage,corrUsage,type,capacity,repCount
        FROM vpPlacesList 
        WHERE URL NOT LIKE "vpbuddy://%" AND
              serialNumber != -1 
  ELSE
  IF @pageType = 3		/* Category Places */
  BEGIN
    /* Get all the places matching a place prefix for this category */
    INSERT #tempTable
      SELECT vpPlacesList.URL,title,roomUsage,corrUsage,type,capacity,repCount
        FROM vpPlacesList, placeCategories 
        WHERE vpPlacesList.URL NOT LIKE "vpbuddy://%" AND
            serialNumber != -1 AND
            category = @categoryId AND
            vpPlacesList.URL LIKE (placeCategories.URL + "%")
    SELECT @lastError = @@error
    IF @lastError != 0
      RETURN @lastError
    /* Add all the places prefixes for this category if not already
       in the table (from the server's snapshot -- vpPlaces table).
       only the URL is important, the rest are dummy values */
    INSERT #tempTable
      SELECT placeCategories.URL, placeCategories.URL, 0, 0, 0, 25, 0
      FROM placeCategories
      WHERE placeCategories.category = @categoryId AND
	placeCategories.URL NOT IN (SELECT URL FROM #tempTable) 
  END
  IF @lastError != 0
    RETURN @lastError

  IF @exclShadow = 1
  BEGIN
    IF @unifyRepl = 1
      SELECT DISTINCT URL, title, sum(roomUsage), sum(corrUsage), 
             type, max(capacity), count(repCount)
        FROM #tempTable
        WHERE URL NOT IN (SELECT #tempTable.URL 
                            FROM #tempTable, shadowPlaces
		            WHERE #tempTable.URL LIKE (shadowPlaces.URL + "%"))
        GROUP BY URL
        HAVING sum(roomUsage) + sum(corrUsage) >= @minPeople
        ORDER BY sum(roomUsage) DESC,sum(corrUsage) DESC
    ELSE
      SELECT *
        FROM #tempTable
        WHERE (roomUsage + corrUsage)>= @minPeople AND
              URL NOT IN (SELECT #tempTable.URL 
                            FROM #tempTable, shadowPlaces
		            WHERE #tempTable.URL LIKE (shadowPlaces.URL + "%"))
        ORDER BY roomUsage DESC ,corrUsage DESC
  END
  ELSE 		/* Do not exclude shadow places */
  BEGIN
    IF @unifyRepl = 1
      SELECT DISTINCT URL, title, sum(roomUsage), sum(corrUsage), 
             type, max(capacity), count(repCount)
        FROM #tempTable
        GROUP BY URL
        HAVING sum(roomUsage) + sum(corrUsage) >= @minPeople
        ORDER BY sum(roomUsage) DESC, sum(corrUsage) DESC 
    ELSE
      SELECT *
        FROM #tempTable
        WHERE (roomUsage + corrUsage)>= @minPeople 
        ORDER BY  roomUsage DESC,corrUsage DESC
  END
END

go
IF OBJECT_ID('dbo.getPagePlaces') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getPagePlaces >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getPagePlaces >>>'
go

/* get the id and name of the 
   parent category of a specific category */
/*
  INPUT  : category id (assumed to belong to 
                        an existing category)
  OUTPUT : parent category id, parent category name
*/
CREATE PROC getParentCategory
(
  @category categoryIdentifier
)
AS
BEGIN
  SELECT c1.category, c1.description
    FROM categories c1, categories c2
    WHERE ( c2.category = @category ) AND
          ( c1.category = c2.parentCategeory )
END

go
IF OBJECT_ID('dbo.getParentCategory') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getParentCategory >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getParentCategory >>>'
go

/* getPersistentPlace returns all the parameters relevent to a cool place
   INPUT: URL
   OUTPUT: URL, type, title, roomCapacity. roomProtected, numberOfRows,
	   rowSize, rowPrefix
*/

CREATE PROC getPersistentPlace (@URL longName)
AS
   SELECT * 
	FROM persistentPlaces
	WHERE URL = @URL

go
IF OBJECT_ID('dbo.getPersistentPlace') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getPersistentPlace >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getPersistentPlace >>>'
go

/* get details of all places types */
/* input:  NONE
   output: list of place types, stating -
   type, min people for showing a place, sort order, 
   unify replicates flag, exclude shadow places flag
*/
CREATE PROC getPlaceTypes
AS
BEGIN
  SELECT *
    FROM placeTypes
    ORDER BY type
END

go
IF OBJECT_ID('dbo.getPlaceTypes') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getPlaceTypes >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getPlaceTypes >>>'
go

/* Find all places for a given place type
 */
/*
  INPUT  : placeType (Cool = 0, Events = 1, All= 2),
           category id,
           start index (where to start in the returned list of places),
           number of places (number of places to return)
  OUTPUT : all details for the PTG directory
  RETURNS - 20001 if the place type is not found in the place types table
            0 otherwise.
*/

CREATE PROC getPlaces(
  @placeType 	integer,
  @categoryId   numeric(6,0) = NULL,
  @startIndex   integer	     = 0,
  @numPlaces    integer      = -1
)
AS
BEGIN
  DECLARE @lastError integer
  DECLARE @exclShadow	bit
  DECLARE @unifyRepl	bit
  DECLARE @minPeople	integer
  DECLARE @sortOrder	integer /* NumPeople = 0, Title = 1 */

  /* Get the place type's details from the placeTypes table */
  SELECT @minPeople = minPeople, @sortOrder = sortOrder, 
         @exclShadow = excludeShadow, @unifyRepl = unifyReplicates
    FROM placeTypes
    WHERE type = @placeType
  IF @@rowcount = 0
    RETURN 20001

  SELECT @lastError = @@error
  IF @lastError != 0
    RETURN @lastError

  /* Create temporary tables for processing the data */
  CREATE TABLE #tempTable (URL varchar(255), title varchar(255), 
                           roomUsage integer, corrUsage integer, type integer,
                           capacity integer, repCount integer, category numeric(6,0)  NULL)
  CREATE TABLE #sortTable (URL varchar(255), title varchar(255), 
                           roomUsage integer, corrUsage integer, type integer,
			   capacity integer, repCount integer, category numeric(6,0) NULL)
  SELECT @lastError = @@error
  IF @lastError != 0
    RETURN @lastError

  IF @placeType = 0		/* Cool Places */
  BEGIN
   IF @categoryId = NULL
   BEGIN 
     /* Get all cool places which belong to a category */
     INSERT #tempTable 
      SELECT vpPlacesList.URL,vpPlacesList.title,roomUsage,corrUsage,
             vpPlacesList.type,capacity,repCount,placeCategories.category 
        FROM vpPlacesList, persistentPlaces, placeCategories 
        WHERE vpPlacesList.URL NOT LIKE "vpbuddy://%" AND
              serialNumber != -1 AND
              persistentPlaces.type != 2049 AND
              vpPlacesList.URL =  persistentPlaces.URL AND 
              placeCategories.URL = persistentPlaces.URL

     /* Add the cool places with no category specified */
     INSERT #tempTable 
      SELECT vpPlacesList.URL,vpPlacesList.title,roomUsage,corrUsage,
             vpPlacesList.type,capacity,repCount, NULL
        FROM vpPlacesList, persistentPlaces 
        WHERE vpPlacesList.URL NOT LIKE "vpbuddy://%" AND
              serialNumber != -1 AND
              persistentPlaces.type != 2049 AND
              vpPlacesList.URL =  persistentPlaces.URL AND 
              vpPlacesList.URL NOT IN (SELECT URL FROM #tempTable)
   END
   ELSE      
      /* Get only persistent places which belong to the category
         if specified */
     INSERT #tempTable 
      SELECT vpPlacesList.URL,vpPlacesList.title,roomUsage,corrUsage,
             vpPlacesList.type,capacity,repCount,placeCategories.category 
        FROM vpPlacesList, persistentPlaces, placeCategories
        WHERE vpPlacesList.URL NOT LIKE "vpbuddy://%" AND
              serialNumber != -1 AND
              persistentPlaces.type != 2049 AND
              vpPlacesList.URL =  persistentPlaces.URL AND 
              placeCategories.URL = persistentPlaces.URL AND
              placeCategories.category = @categoryId 
  END  
  ELSE
  IF @placeType = 1		/* Auditorium Places */
  BEGIN
    IF @categoryId = NULL 
    BEGIN
      /* Get all auditoriums which belong to a category */
      INSERT #tempTable
        SELECT vpPlacesList.URL,vpPlacesList.title,roomUsage,corrUsage,
               vpPlacesList.type,capacity,repCount,placeCategories.category 
          FROM vpPlacesList, persistentPlaces, placeCategories 
          WHERE vpPlacesList.URL NOT LIKE "vpbuddy://%" AND
              serialNumber != -1 AND
              persistentPlaces.type = 2049 AND
              vpPlacesList.URL =  persistentPlaces.URL AND 
              placeCategories.URL = persistentPlaces.URL

     /* Add the auditoriums with no category specified */
     INSERT #tempTable 
      SELECT vpPlacesList.URL,vpPlacesList.title,roomUsage,corrUsage,
             vpPlacesList.type,capacity,repCount, NULL
        FROM vpPlacesList, persistentPlaces 
        WHERE vpPlacesList.URL NOT LIKE "vpbuddy://%" AND
              serialNumber != -1 AND
              persistentPlaces.type = 2049 AND
              vpPlacesList.URL =  persistentPlaces.URL AND 
              vpPlacesList.URL NOT IN (SELECT URL FROM #tempTable)
    END
    ELSE
      /* Get only auditoriums which belong to the category
         if specified:  */  
      INSERT #tempTable
        SELECT vpPlacesList.URL,vpPlacesList.title,roomUsage,corrUsage,
               vpPlacesList.type,capacity,repCount,placeCategories.category 
          FROM vpPlacesList, persistentPlaces, placeCategories
          WHERE vpPlacesList.URL NOT LIKE "vpbuddy://%" AND
              serialNumber != -1 AND
              persistentPlaces.type = 2049 AND
              vpPlacesList.URL =  persistentPlaces.URL AND 
              placeCategories.URL = persistentPlaces.URL AND
              placeCategories.category = @categoryId 

    SELECT @lastError = @@error
    IF @lastError != 0
      RETURN @lastError
    /* For auditoriums, capacity is the audience capacity, not the stage */
    UPDATE #tempTable
      SET capacity = rowSize * numberOfRows
      FROM #tempTable, persistentPlaces
      WHERE #tempTable.URL = persistentPlaces.URL
  END  
  ELSE

  IF @placeType = 2		/* All Places */
  BEGIN
    IF @categoryId = NULL 
    BEGIN
      /* First, get the places which belong to a category  */
      INSERT #tempTable
        SELECT vpPlacesList.URL,title,roomUsage,corrUsage,type,capacity,repCount,category
          FROM vpPlacesList, placeCategories
          WHERE vpPlacesList.URL NOT LIKE "vpbuddy://%" AND
                serialNumber != -1 AND
                ((vpPlacesList.URL = placeCategories.URL) OR
                 (vpPlacesList.URL LIKE (placeCategories.URL + "%") AND
                  placeCategories.domainFlag = 1))

      SELECT @lastError = @@error
      IF @lastError != 0
        RETURN @lastError

      /* Next, get the places wich do not fit under any category */
      INSERT #tempTable
        SELECT vpPlacesList.URL,title,roomUsage,corrUsage,type,capacity,repCount,NULL
          FROM vpPlacesList
          WHERE URL NOT LIKE "vpbuddy://%" AND
                serialNumber != -1 AND
                URL NOT IN (SELECT URL FROM #tempTable)
    END
    ELSE
    BEGIN
     /* Get the places which belong to the given category  */
     INSERT #tempTable
        SELECT vpPlacesList.URL,title,roomUsage,corrUsage,type,capacity,repCount,category
          FROM vpPlacesList, placeCategories
          WHERE vpPlacesList.URL NOT LIKE "vpbuddy://%" AND
                serialNumber != -1 AND
                ((vpPlacesList.URL = placeCategories.URL) OR
                 (vpPlacesList.URL LIKE (placeCategories.URL + "%") AND
                  placeCategories.domainFlag = 1)) AND
              placeCategories.category = @categoryId 
    END
  END

  SELECT @lastError = @@error
  IF @lastError != 0
    RETURN @lastError

  IF @exclShadow = 1
  BEGIN
    IF @unifyRepl = 1
      INSERT #sortTable
       SELECT DISTINCT URL, title, sum(roomUsage), sum(corrUsage), 
             type, max(capacity), count(repCount), category
        FROM #tempTable
        WHERE URL NOT IN 
          (SELECT #tempTable.URL 
             FROM #tempTable, shadowPlaces
             WHERE #tempTable.URL LIKE (shadowPlaces.URL + "%"))
        GROUP BY URL
        HAVING sum(roomUsage) + sum(corrUsage) >= @minPeople
    ELSE
      INSERT #sortTable
       SELECT *
        FROM #tempTable
        WHERE (roomUsage + corrUsage)>= @minPeople AND
              URL NOT IN 
              (SELECT #tempTable.URL 
                 FROM #tempTable, shadowPlaces
                 WHERE #tempTable.URL LIKE (shadowPlaces.URL + "%"))
  END
  ELSE 		/* Do not exclude shadow places */
  BEGIN
    IF @unifyRepl = 1
      INSERT #sortTable
       SELECT DISTINCT URL, title, sum(roomUsage), sum(corrUsage), 
             type, max(capacity), count(repCount), category
        FROM #tempTable
        GROUP BY URL
        HAVING sum(roomUsage) + sum(corrUsage) >= @minPeople
    ELSE
      INSERT #sortTable
       SELECT *
        FROM #tempTable
        WHERE (roomUsage + corrUsage)>= @minPeople 
  END

  /* Now sort the resulting table and return only the requested number of Places*/
  IF (@sortOrder = 0)
    DECLARE placesCursor CURSOR
      FOR SELECT *
          FROM #sortTable
          ORDER BY  roomUsage DESC,corrUsage DESC
  ELSE
  IF @sortOrder = 1
    DECLARE placesCursor CURSOR
      FOR SELECT * 
          FROM #sortTable
          ORDER BY title

    DECLARE @count integer
    DECLARE @URL varchar(255)
    DECLARE @title varchar(255)
    DECLARE @room integer
    DECLARE @corr integer
    DECLARE @type integer
    DECLARE @capacity integer
    DECLARE @rep integer
    DECLARE @category numeric(6,0)

    OPEN placesCursor

    /* Skip 'startindex' records */
    SELECT @count = 0
    WHILE ((@@sqlstatus = 0) AND (@startIndex > @count))
    BEGIN
         FETCH placesCursor INTO @URL, @title, @room, @corr, @type, @capacity, @rep, @category
         SELECT @count = @count + 1
    END
 
    /* Get only the requested block of places...*/
    IF ((@@sqlstatus = 0) AND (@numPlaces > 0)) 
    BEGIN
      SET CURSOR ROWS @numPlaces FOR placesCursor
      FETCH placesCursor
    END
    ELSE 
    IF @numPlaces = -1
    /* Fetch all remaining records from cursor */
    WHILE (@@sqlstatus = 0)
      FETCH placesCursor

    CLOSE placesCursor
END

go
IF OBJECT_ID('dbo.getPlaces') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getPlaces >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getPlaces >>>'
go

/* find all shadow places */
CREATE PROC getShadowPlaces
AS
  SELECT URL
    FROM shadowPlaces


go
IF OBJECT_ID('dbo.getShadowPlaces') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getShadowPlaces >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getShadowPlaces >>>'
go

/* delete a category - related data will be 
   removed by the delCategoryData trigger */
/*
  INPUT  : parentCategory or NULL for root categories
  OUTPUT : list of sub-categories for that category,
           stating for each - category, description
*/
CREATE PROC getSubCategories
(
  @parentCategory categoryIdentifier = NULL
)
AS
  SELECT category, description
    FROM categories
    WHERE ( parentCategeory = @parentCategory )
    ORDER BY description

go
IF OBJECT_ID('dbo.getSubCategories') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getSubCategories >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getSubCategories >>>'
go

/* get the usage statistics for a given period of time, by week
   NOTE: dailyUsage is used, so statistics are good only
         up to the previous day

  INPUT  : startTime, endTime
  OUTPUT : time, 
           summary values - ( all users, chat users, Buddy list users ) X 
                            (average)

           e.g. if summary is desired for period starting on 
           January 1st 1997, and ending on December 31st 1997, values will look like this:

           1996 12 29 00:00 <all-avg> <chat-avg> <bl-avg>
           1997 1 5 00:00 <all-avg> <chat-avg> <bl-avg>
           1997 1 12 00:00 <all-avg> <chat-avg> <bl-avg>
            .   . . .       .        .
            .   . . .       .        .
            .   . . .       .        .
            .   . . .       .        .
            .   . . .       .        .
           1997 12 28 00:00 <all-avg> <chat-avg> <bl-avg>

           where each <braced value> is a 4-byte-representable integer.
           note that the starting days for the respective weeks are used,
           so that the data is correct for all of the regarded week. Therefore, in this
           example, the first week used is the one starting on Dec 29, 1996, which includes
           Jan 1, 1997.
*/
CREATE PROC getWeeklyAvgStatistics
(
  @startTime VpTime,
  @endTime VpTime
)
AS
BEGIN
  /* first fix times to include each possible entry from the given weeks */
  /* make @startTime be 00:00 of the first day on the week which @startTime belongs to */
  SELECT @startTime = dateadd( day, 1 - datepart(weekday,@startTime), @startTime )
  SELECT @startTime = dateadd( hour, (-1) * datepart(hour,@startTime), @startTime )
  SELECT @startTime = dateadd( minute, (-1) * datepart(minute,@startTime), @startTime )
  
  /* make @endTime be 23:59 of the last day on the week which @endTime belongs to */
  SELECT @endTime = dateadd( day, 7 - datepart(weekday,@endTime), @endTime )
  SELECT @endTime = dateadd( hour, 23 - datepart(hour,@endTime), @endTime )
  SELECT @endTime = dateadd( minute, 59 - datepart(minute,@endTime), @endTime )
  
  SELECT DISTINCT
         year=datepart( year, dateadd( day, (-1) * (datepart(weekday,d1.time)-1), d1.time ) ),
         month=datepart( month, dateadd( day, (-1) * (datepart(weekday,d1.time)-1), d1.time ) ),
         day=datepart( day, dateadd( day, (-1) * (datepart(weekday,d1.time)-1), d1.time ) ),
         hour=0, /* weekly summary, so hour is meaningless */
         allAvg=avg(d1.value),
         chatAvg=avg(d2.value),
         BlAvg=avg(d3.value)
  FROM
         dailyUsage d1,
         dailyUsage d2,
         dailyUsage d3
  WHERE	    
         ( datepart( year, dateadd( day, 1 - datepart(weekday,d1.time), d1.time ) ) =
             datepart( year, dateadd( day, 1 - datepart(weekday,d2.time), d2.time ) ) ) AND
         ( datepart( week, dateadd( day, 1 - datepart(weekday,d1.time), d1.time ) ) =
             datepart( week, dateadd( day, 1 - datepart(weekday,d2.time), d2.time ) ) ) AND
         
         ( datepart( year, dateadd( day, 1 - datepart(weekday,d2.time), d2.time ) ) =
             datepart( year, dateadd( day, 1 - datepart(weekday,d3.time), d3.time ) ) ) AND
         ( datepart( week, dateadd( day, 1 - datepart(weekday,d2.time), d2.time ) ) =
             datepart( week, dateadd( day, 1 - datepart(weekday,d3.time), d3.time ) ) ) AND
         
         ( d1.time BETWEEN @startTime AND @endTime ) AND
         ( d2.time BETWEEN @startTime AND @endTime ) AND
         ( d3.time BETWEEN @startTime AND @endTime ) AND
         (d1.userType=0) AND (d1.valueType=0) AND
         (d2.userType=1) AND (d2.valueType=0) AND
         (d3.userType=2) AND (d3.valueType=0)

  GROUP BY datepart( year, dateadd( day, 1 - datepart(weekday,d1.time), d1.time ) ), 
           datepart( week, dateadd( day, 1 - datepart(weekday,d1.time), d1.time ) )
  ORDER BY year, month, day


END

go
IF OBJECT_ID('dbo.getWeeklyAvgStatistics') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getWeeklyAvgStatistics >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getWeeklyAvgStatistics >>>'
go

/* get the usage statistics for a given period of time, by week
   NOTE: dailyUsage is used, so statistics are good only
         up to the previous day

  INPUT  : startTime, endTime
  OUTPUT : time, 
           summary values - ( all users, chat users, Buddy list users ) X 
                            (average)

           e.g. if summary is desired for period starting on 
           January 1st 1997, and ending on December 31st 1997, values will look like this:

           1996 12 29 00:00 <all-max> <chat-max> <bl-max>
           1997 1 5 00:00 <all-max> <chat-max> <bl-max>
           1997 1 12 00:00 <all-max> <chat-max> <bl-max>
            .   . . .       .        .
            .   . . .       .        .
            .   . . .       .        .
            .   . . .       .        .
            .   . . .       .        .
           1997 12 28 00:00 <all-max> <chat-max> <bl-max>

           where each <braced value> is a 4-byte-representable integer.
           note that the starting days for the respective weeks are used,
           so that the data is correct for all of the regarded week. Therefore, in this
           example, the first week used is the one starting on Dec 29, 1996, which includes
           Jan 1, 1997.
*/
CREATE PROC getWeeklyMaxStatistics
(
  @startTime VpTime,
  @endTime VpTime
)
AS
BEGIN
  /* first fix times to include each possible entry from the given weeks */
  /* make @startTime be 00:00 of the first day on the week which @startTime belongs to */
  SELECT @startTime = dateadd( day, 1 - datepart(weekday,@startTime), @startTime )
  SELECT @startTime = dateadd( hour, (-1) * datepart(hour,@startTime), @startTime )
  SELECT @startTime = dateadd( minute, (-1) * datepart(minute,@startTime), @startTime )
  
  /* make @endTime be 23:59 of the last day on the week which @endTime belongs to */
  SELECT @endTime = dateadd( day, 7 - datepart(weekday,@endTime), @endTime )
  SELECT @endTime = dateadd( hour, 23 - datepart(hour,@endTime), @endTime )
  SELECT @endTime = dateadd( minute, 59 - datepart(minute,@endTime), @endTime )
  
  SELECT DISTINCT
         year=datepart( year, dateadd( day, 1 - datepart(weekday,d1.time), d1.time ) ),
         month=datepart( month, dateadd( day, 1 - datepart(weekday,d1.time), d1.time ) ),
         day=datepart( day, dateadd( day, 1 - datepart(weekday,d1.time), d1.time ) ),
         hour=0, /* weekly summary, so hour is meaningless */
         allMax=max(d1.value),
         chatMax=max(d2.value),
         BlMax=max(d3.value)
  FROM
         dailyUsage d1,
         dailyUsage d2,
         dailyUsage d3
  WHERE	    
         ( datepart( year, dateadd( day, 1 - datepart(weekday,d1.time), d1.time ) ) =
             datepart( year, dateadd( day, 1 - datepart(weekday,d2.time), d2.time ) ) ) AND
         ( datepart( week, dateadd( day, 1 - datepart(weekday,d1.time), d1.time ) ) =
             datepart( week, dateadd( day, 1 - datepart(weekday,d2.time), d2.time ) ) ) AND
         
         ( datepart( year, dateadd( day, 1 - datepart(weekday,d2.time), d2.time ) ) =
             datepart( year, dateadd( day, 1 - datepart(weekday,d3.time), d3.time ) ) ) AND
         ( datepart( week, dateadd( day, 1 - datepart(weekday,d2.time), d2.time ) ) =
             datepart( week, dateadd( day, 1 - datepart(weekday,d3.time), d3.time ) ) ) AND
         
         ( d1.time BETWEEN @startTime AND @endTime ) AND
         ( d2.time BETWEEN @startTime AND @endTime ) AND
         ( d3.time BETWEEN @startTime AND @endTime ) AND
         (d1.userType=0) AND (d1.valueType=2) AND
         (d2.userType=1) AND (d2.valueType=2) AND
         (d3.userType=2) AND (d3.valueType=2)

  GROUP BY datepart( year, dateadd( day, 1 - datepart(weekday,d1.time), d1.time ) ), 
           datepart( week, dateadd( day, 1 - datepart(weekday,d1.time), d1.time ) )
  ORDER BY year, month, day


END

go
IF OBJECT_ID('dbo.getWeeklyMaxStatistics') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getWeeklyMaxStatistics >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getWeeklyMaxStatistics >>>'
go

/* get the usage statistics for a given period of time, by week
   NOTE: dailyUsage is used, so statistics are good only
         up to the previous day

  INPUT  : startTime, endTime
  OUTPUT : time, 
           summary values - ( all users, chat users, Buddy list users ) X 
                            (average)

           e.g. if summary is desired for period starting on 
           January 1st 1997, and ending on December 31st 1997, values will look like this:

           1996 12 29 00:00 <all-min> <chat-min> <bl-min>
           1997 1 5 00:00 <all-min> <chat-min> <bl-min>
           1997 1 12 00:00 <all-min> <chat-min> <bl-min>
            .   . . .       .        .
            .   . . .       .        .
            .   . . .       .        .
            .   . . .       .        .
            .   . . .       .        .
           1997 12 28 00:00 <all-min> <chat-min> <bl-min>

           where each <braced value> is a 4-byte-representable integer.
           note that the starting days for the respective weeks are used,
           so that the data is correct for all of the regarded week. Therefore, in this
           example, the first week used is the one starting on Dec 29, 1996, which includes
           Jan 1, 1997.
*/
CREATE PROC getWeeklyMinStatistics
(
  @startTime VpTime,
  @endTime VpTime
)
AS
BEGIN
  /* first fix times to include each possible entry from the given weeks */
  /* make @startTime be 00:00 of the first day on the week which @startTime belongs to */
  SELECT @startTime = dateadd( day, 1 - datepart(weekday,@startTime), @startTime )
  SELECT @startTime = dateadd( hour, (-1) * datepart(hour,@startTime), @startTime )
  SELECT @startTime = dateadd( minute, (-1) * datepart(minute,@startTime), @startTime )
  
  /* make @endTime be 23:59 of the last day on the week which @endTime belongs to */
  SELECT @endTime = dateadd( day, 7 - datepart(weekday,@endTime), @endTime )
  SELECT @endTime = dateadd( hour, 23 - datepart(hour,@endTime), @endTime )
  SELECT @endTime = dateadd( minute, 59 - datepart(minute,@endTime), @endTime )
  
  SELECT DISTINCT
         year=datepart( year, dateadd( day, (-1) * (datepart(weekday,d1.time)-1), d1.time ) ),
         month=datepart( month, dateadd( day, (-1) * (datepart(weekday,d1.time)-1), d1.time ) ),
         day=datepart( day, dateadd( day, (-1) * (datepart(weekday,d1.time)-1), d1.time ) ),
         hour=0, /* weekly summary, so hour is meaningless */
         allMin=min(d1.value),
         chatMin=min(d2.value),
         BlMin=min(d3.value)
  FROM
         dailyUsage d1,
         dailyUsage d2,
         dailyUsage d3
  WHERE	    
         ( datepart( year, dateadd( day, 1 - datepart(weekday,d1.time), d1.time ) ) =
             datepart( year, dateadd( day, 1 - datepart(weekday,d2.time), d2.time ) ) ) AND
         ( datepart( week, dateadd( day, 1 - datepart(weekday,d1.time), d1.time ) ) =
             datepart( week, dateadd( day, 1 - datepart(weekday,d2.time), d2.time ) ) ) AND
         
         ( datepart( year, dateadd( day, 1 - datepart(weekday,d2.time), d2.time ) ) =
             datepart( year, dateadd( day, 1 - datepart(weekday,d3.time), d3.time ) ) ) AND
         ( datepart( week, dateadd( day, 1 - datepart(weekday,d2.time), d2.time ) ) =
             datepart( week, dateadd( day, 1 - datepart(weekday,d3.time), d3.time ) ) ) AND
         
         ( d1.time BETWEEN @startTime AND @endTime ) AND
         ( d2.time BETWEEN @startTime AND @endTime ) AND
         ( d3.time BETWEEN @startTime AND @endTime ) AND
         (d1.userType=0) AND (d1.valueType=1) AND
         (d2.userType=1) AND (d2.valueType=1) AND
         (d3.userType=2) AND (d3.valueType=1)

  GROUP BY datepart( year, dateadd( day, 1 - datepart(weekday,d1.time), d1.time ) ), 
           datepart( week, dateadd( day, 1 - datepart(weekday,d1.time), d1.time ) )
  ORDER BY year, month, day


END

go
IF OBJECT_ID('dbo.getWeeklyMinStatistics') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getWeeklyMinStatistics >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getWeeklyMinStatistics >>>'
go

/* Get a persistent place with a specific URL. Used by 
   audset STP addAuditorium to avoid defining a persistent place 
   as an auditorium */
/* input: URL
   output: URL of givent persistent place
*/
CREATE PROC persistentPlaceExists
(
  @URL		varchar(255),
  @result	int output
)
AS
BEGIN  
    IF EXISTS (SELECT URL 
          FROM persistentPlaces
          WHERE  URL = @URL)
      SELECT @result =  1 /* Non zero value returned if URL exists */
    ELSE
      SELECT @result = 0
END

go
IF OBJECT_ID('dbo.persistentPlaceExists') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.persistentPlaceExists >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.persistentPlaceExists >>>'
go

/* rename an existing category */
/*
  INPUT  : category id, new category description (name)
  OUTPUT : return value - 0 if successful
                          20001 if category does not exist
                          20002 if category with the same name is 
                                already defined for that parent category
                          20003 if new description is same as old
*/
CREATE PROC renameCategory
(
  @categoryToChange categoryIdentifier,
  @description varchar(30)
)
AS
BEGIN
  DECLARE @lastError int
  DECLARE @thisCategory categoryIdentifier
  DECLARE @parentCategory categoryIdentifier
  DECLARE @categoryUsingName categoryIdentifier
  DECLARE @oldDescription varchar(30)
  
  BEGIN TRAN renameCategory
    /* check if the given parent category exists */
    SELECT @thisCategory = category,
           @parentCategory = parentCategeory,
           @oldDescription = description
      FROM categories
      WHERE ( category = @categoryToChange )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN renameCategory
      RETURN @lastError
    END
    
    IF ( @thisCategory IS NULL )
    BEGIN
      /* category to be changed does not exist */
      ROLLBACK TRAN renameCategory
      RETURN 20001
    END
    
    IF ( @oldDescription = @description )
    BEGIN
      /* new category description is same as the old one */
      ROLLBACK TRAN renameCategory
      RETURN 20003
    END
    
    SELECT @categoryUsingName = category
      FROM categories
      WHERE ( parentCategeory = @parentCategory ) AND
            ( description = @description )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN renameCategory
      RETURN @lastError
    END
    
    IF ( @categoryUsingName IS NOT NULL )
    BEGIN
      /* new category description is in use by another category */
      ROLLBACK TRAN renameCategory
      RETURN 20002
    END
    
    UPDATE categories
      SET description = @description
      WHERE ( category = @categoryToChange )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN renameCategory
      RETURN @lastError
    END
    
  COMMIT TRAN renameCategory
END

go
IF OBJECT_ID('dbo.renameCategory') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.renameCategory >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.renameCategory >>>'
go

/* updates a places type in the database */
/* input:  place type, 
           min people for showing places, sort order,
           unify replicates, exclude shadow places
   output: return value is 20001 if place type does not exist,
           0 otherwise
*/
CREATE PROC updPlaceType
(
  @placeType    integer,
  @minPeople    integer,
  @sortOrder    integer,
  @unifyReplicated  bit,
  @excludeShadow    bit
)
AS
BEGIN
  
  DECLARE @lastError            int

  BEGIN TRAN
    
    SELECT type 
      FROM placeTypes
      WHERE type = @placeType
    IF @@rowCount = 0
    BEGIN
      /* node not found */
      ROLLBACK TRAN
      RETURN 20001
    END
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
   
    UPDATE placeTypes
    SET minPeople = @minPeople, sortOrder = @sortOrder,
        unifyReplicates = @unifyReplicated, excludeShadow = @excludeShadow
    WHERE type = @placeType
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
    
  COMMIT TRAN

END

go
IF OBJECT_ID('dbo.updPlaceType') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.updPlaceType >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.updPlaceType >>>'
go

/* input:  old URL, new URL
   output: NONE
*/
CREATE PROC updatePPlace
(
  @oldURL longName,
  @newURL longName
)
AS
  UPDATE persistentPlaces
    SET URL = @newURL
    WHERE URL = @oldURL

go
IF OBJECT_ID('dbo.updatePPlace') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.updatePPlace >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.updatePPlace >>>'
go


--
-- CREATE TRIGGERS
--
/* upon adding a record of total usage to PTGlist,
   copy it to totalUsage table */
/*
NOTE : Because most of the time PTGlist records
       are only updated, except for the one time
       when a record with the matching serial
       number is created, only an UPDATE trigger
       will be created
*/
CREATE TRIGGER addDailyUsageRecord
  ON totalUsage
  FOR INSERT
AS
BEGIN
  DECLARE @lastError int
  DECLARE @diffFromGMT int
  DECLARE @currentTime VpTime
  DECLARE @localTime VpTime
  DECLARE @yesterdayStartLocalTime VpTime
  DECLARE @yesterdayEndLocalTime VpTime
  
  DECLARE @minuteTotalRecordsForDay int
  DECLARE @dailyTotalRecordsForDay int
  DECLARE @dayToSummarize VpTime
  DECLARE @yesterdayStartGMT VpTime
  DECLARE @yesterdayEndGMT VpTime
  DECLARE @doDailySummary bit
  
  DECLARE @minAll INTEGER, @maxAll INTEGER, @avgAll INTEGER
  DECLARE @minChat INTEGER, @maxChat INTEGER, @avgChat INTEGER
  DECLARE @minBl INTEGER, @maxBl INTEGER, @avgBl INTEGER
  
  SELECT @diffFromGMT = gmt
    FROM vpusers..getGMT
  
  SELECT @lastError = @@error
  IF @lastError != 0
  BEGIN
    ROLLBACK TRIGGER
  END
  IF @diffFromGMT IS NULL
    SELECT @diffFromGMT = 0
  
  SELECT @localTime = time
    FROM inserted
  SELECT @currentTime = @localTime

  /* get convert from GMT to local time */
  SELECT @localTime = dateadd( hour, @diffFromGMT, @localTime )
  
  SELECT @yesterdayStartLocalTime = dateadd( day, -1, @localTime )
  SELECT @yesterdayStartLocalTime = dateadd( hour, 
                                             0 - datepart( hour, @yesterdayStartLocalTime ), 
                                             @yesterdayStartLocalTime )
  SELECT @yesterdayStartLocalTime = dateadd( minute, 
                                             0 - datepart( minute, @yesterdayStartLocalTime ), 
                                             @yesterdayStartLocalTime )
  SELECT @yesterdayEndLocalTime = dateadd( day, 1, @yesterdayStartLocalTime )
  SELECT @yesterdayEndLocalTime = dateadd( minute, -1, @yesterdayEndLocalTime )

  SELECT @yesterdayStartGMT = dateadd( hour, -1 * @diffFromGMT, @yesterdayStartLocalTime )
  SELECT @yesterdayEndGMT = dateadd( hour, -1 * @diffFromGMT, @yesterdayEndLocalTime )
  
  /* do summary for previous day only if there are no records in the
     dailyUsage table for this day, but records in totalUsage for 
     this day exist.
  */
  /* note: summaries for day are done by local time, so 
     "Day" will match the time when the local day starts and ends.
     The summaries are kept in dailyUsage in local time values, too,
     Therefore @yestardayStartLocalTime and @yesterdayEndLocalTime
     are used here.
  */
  

  SELECT @doDailySummary = 0
  SELECT @dailyTotalRecordsForDay = 0
  SELECT @dailyTotalRecordsForDay = count(*)
    FROM dailyUsage
    WHERE ( time BETWEEN @yesterdayStartLocalTime AND @yesterdayEndLocalTime )

  SELECT @lastError = @@error
  IF @lastError != 0
  BEGIN
    ROLLBACK TRIGGER
  END
  
  IF ( @dailyTotalRecordsForDay IS NULL )
    SELECT @dailyTotalRecordsForDay = 0
  IF ( @dailyTotalRecordsForDay <= 0 )
  BEGIN
    SELECT @minuteTotalRecordsForDay = 0
    SELECT @minuteTotalRecordsForDay = count(*)
      FROM totalUsage
      WHERE ( time BETWEEN @yesterdayStartGMT AND @yesterdayEndGMT )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRIGGER
    END
    
    IF @minuteTotalRecordsForDay > 0
    BEGIN
      SELECT @doDailySummary = 1
    END
    ELSE
      SELECT @doDailySummary = 0
    END
  ELSE
  BEGIN
    SELECT @doDailySummary = 0
  END

  IF ( @doDailySummary = 1 )
  BEGIN
    /* do summary for the preceding day */
    SELECT 
           @minAll = min(totalUsage),
           @maxAll = max(totalUsage),
           @avgAll = avg(totalUsage),
           @minChat = min(roomUsage+corrUsage),
           @maxChat = max(roomUsage+corrUsage),
           @avgChat = avg(roomUsage+corrUsage),
           @minBl = min(BLUsage),
           @maxBl = max(BLUsage),
           @avgBl = avg(BLUsage)
      FROM totalUsage
        WHERE ( time BETWEEN @yesterdayStartGMT AND @yesterdayEndGMT )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRIGGER
    END
    
    INSERT dailyUsage
      VALUES ( @yesterdayStartLocalTime, 0, 0, @avgAll )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRIGGER
    END
    
    IF ( @minAll = @maxAll )
    BEGIN
      INSERT dailyUsage
        VALUES ( @yesterdayStartLocalTime, 0, 1, @minAll )
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRIGGER
      END
      
      INSERT dailyUsage
        VALUES ( @yesterdayStartLocalTime, 0, 2, @minAll )
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRIGGER
      END
    END
    ELSE /* @minAll != @maxAll */
    BEGIN
      INSERT dailyUsage
        SELECT dateadd( hour, @diffFromGMT,time ), 0, 1, @minAll
          FROM totalUsage
          WHERE ( time BETWEEN @yesterdayStartGMT AND @yesterdayEndGMT ) AND
                ( totalUsage = @minAll )
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRIGGER
      END
      
      INSERT dailyUsage
        SELECT dateadd( hour, @diffFromGMT,time ), 0, 2, @maxAll
          FROM totalUsage
          WHERE ( time BETWEEN @yesterdayStartGMT AND @yesterdayEndGMT ) AND
                ( totalUsage = @maxAll )
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRIGGER
      END
    END
    
    INSERT dailyUsage
      VALUES ( @yesterdayStartLocalTime, 1, 0, @avgChat )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRIGGER
    END
    
    IF ( @minChat = @maxChat )
    BEGIN
      INSERT dailyUsage
        VALUES ( @yesterdayStartLocalTime, 0, 1, @minChat )
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRIGGER
      END
      
      INSERT dailyUsage
        VALUES ( @yesterdayStartLocalTime, 0, 2, @minChat )
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRIGGER
      END
    END
    ELSE /* @minChat != @maxChat */
    BEGIN
      INSERT dailyUsage
        SELECT dateadd( hour, @diffFromGMT,time ), 1, 1, @minChat
          FROM totalUsage
          WHERE ( time BETWEEN @yesterdayStartGMT AND @yesterdayEndGMT ) AND
                ( roomUsage+corrUsage = @minChat )
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRIGGER
      END
      
      INSERT dailyUsage
        SELECT dateadd( hour, @diffFromGMT,time ), 1, 2, @maxChat
          FROM totalUsage
          WHERE ( time BETWEEN @yesterdayStartGMT AND @yesterdayEndGMT ) AND
                ( roomUsage+corrUsage = @maxChat )
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRIGGER
      END
    END
    
    INSERT dailyUsage
      VALUES ( @yesterdayStartLocalTime, 2, 0, @avgBl )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRIGGER
    END
    
    IF ( @minBl = @maxBl )
    BEGIN
      INSERT dailyUsage
        VALUES ( @yesterdayStartLocalTime, 2, 1, @minBl )
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRIGGER
      END
      
      INSERT dailyUsage
        VALUES ( @yesterdayStartLocalTime, 2, 2, @minBl )
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRIGGER
      END
    END
    ELSE /* @minBl != @maxBl */
    BEGIN
      INSERT dailyUsage
        SELECT dateadd( hour, @diffFromGMT,time ), 2, 1, @minBl
          FROM totalUsage
          WHERE ( time BETWEEN @yesterdayStartGMT AND @yesterdayEndGMT ) AND
                ( BLUsage = @minBl )
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRIGGER
      END
      
      INSERT dailyUsage
        SELECT dateadd( hour, @diffFromGMT,time ), 2, 2, @maxBl
          FROM totalUsage
          WHERE ( time BETWEEN @yesterdayStartGMT AND @yesterdayEndGMT ) AND
                ( BLUsage = @maxBl )
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRIGGER
      END
    END
  END /* IF ( @doDailySummary = 1 ) */
    
END

go
IF OBJECT_ID('addDailyUsageRecord') IS NOT NULL
    PRINT '<<< CREATED TRIGGER addDailyUsageRecord >>>'
ELSE
    PRINT '<<< FAILED CREATING TRIGGER addDailyUsageRecord >>>'
go

/* upon adding a record of total usage to PTGlist,
   copy it to totalUsage table */
/*
NOTE : Because most of the time PTGlist records
       are only updated, except for the one time
       when a record with the matching serial
       number is created, only an UPDATE trigger
       will be created
*/
CREATE TRIGGER addTotalUsageRecord
  ON PTGlist
  FOR UPDATE
AS
BEGIN
  DECLARE @lastError int
  DECLARE @totalUsage int
  DECLARE @roomUsage int
  DECLARE @corrUsage int
  DECLARE @BLUsage int
  DECLARE @diffFromGMT int
  DECLARE @currentTime VpTime
  DECLARE @localTime VpTime
  DECLARE @deleteTime VpTime
  
  SELECT @roomUsage = roomUsage,
         @corrUsage = corrUsage
    FROM inserted
    WHERE inserted.serialNumber = -1
  
  SELECT @lastError = @@error
  IF @lastError != 0
  BEGIN
    ROLLBACK TRIGGER
  END
  ELSE
  BEGIN
    IF ( @roomUsage IS NOT NULL )
    BEGIN
      /* insert record to totalUsage table */
      SELECT @totalUsage = @roomUsage + @corrUsage
      
      SELECT @diffFromGMT = gmt
        FROM vpusers..getGMT
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRIGGER
      END
      IF @diffFromGMT IS NULL
        SELECT @diffFromGMT = 0
  
      SELECT @localTime = getdate()
      SELECT @currentTime = dateadd( hour, (-1) * @diffFromGMT, @localTime )
      SELECT @deleteTime = dateadd( day, (-1) * 180, @currentTime )
            
      DELETE totalUsage
        WHERE time < @deleteTime
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRIGGER
      END
      
      SELECT @BLUsage = sum(corrUsage)
      FROM PTGlist
      WHERE ( PTGlist.URL LIKE "%vpbuddy://%" )
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRIGGER
      END
      
      IF @BLUsage IS NULL
        SELECT @BLUsage = 0
      
      INSERT totalUsage
        VALUES ( @currentTime, @totalUsage, @roomUsage, @corrUsage-@BLUsage, @BLUsage )
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRIGGER
      END
      
    END /* IF ( @roomUsage IS NOT NULL ) */
  END
    
END

go
IF OBJECT_ID('addTotalUsageRecord') IS NOT NULL
    PRINT '<<< CREATED TRIGGER addTotalUsageRecord >>>'
ELSE
    PRINT '<<< FAILED CREATING TRIGGER addTotalUsageRecord >>>'
go

GRANT EXECUTE ON dbo.addPersistentPlace TO audset
go
GRANT EXECUTE ON dbo.delPersistentPlace TO audset
go
GRANT EXECUTE ON dbo.persistentPlaceExists TO audset
go

GRANT EXECUTE ON dbo.getPPlaces TO vpusr
go
GRANT EXECUTE ON dbo.getPPlacesChanges TO vpusr
go
GRANT EXECUTE ON dbo.delPPlace TO vpusr
go
GRANT EXECUTE ON dbo.updatePPlace TO vpusr
go

GRANT REFERENCES ON dbo.persistentPlacesChange TO public
go
GRANT REFERENCES ON dbo.categories TO public
go
GRANT REFERENCES ON dbo.PTGlist TO public
go
GRANT REFERENCES ON dbo.PersistentPTGlist TO public
go
GRANT REFERENCES ON dbo.persistentPlaces TO public
go
GRANT REFERENCES ON dbo.placeCategories TO public
go
GRANT REFERENCES ON dbo.placeUsage TO public
go
GRANT REFERENCES ON dbo.shadowPlaces TO public
go
GRANT REFERENCES ON dbo.dailyUsage TO public
go
GRANT REFERENCES ON dbo.placeTypes TO public
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
GRANT SELECT ON dbo.persistentPlacesChange TO public
go
GRANT SELECT ON dbo.categories TO public
go
GRANT SELECT ON dbo.PTGlist TO public
go
GRANT SELECT ON dbo.PersistentPTGlist TO public
go
GRANT SELECT ON dbo.persistentPlaces TO public
go
GRANT SELECT ON dbo.placeCategories TO public
go
GRANT SELECT ON dbo.placeUsage TO public
go
GRANT SELECT ON dbo.shadowPlaces TO public
go
GRANT SELECT ON dbo.dailyUsage TO public
go
GRANT SELECT ON dbo.placeTypes TO public
go
GRANT SELECT ON dbo.usagePeaksView TO public
go
GRANT SELECT ON dbo.usagePeaksWithTimeView TO public
go
GRANT INSERT ON dbo.persistentPlacesChange TO public
go
GRANT INSERT ON dbo.categories TO public
go
GRANT INSERT ON dbo.PTGlist TO public
go
GRANT INSERT ON dbo.PersistentPTGlist TO public
go
GRANT INSERT ON dbo.persistentPlaces TO public
go
GRANT INSERT ON dbo.placeCategories TO public
go
GRANT INSERT ON dbo.placeUsage TO public
go
GRANT INSERT ON dbo.shadowPlaces TO public
go
GRANT INSERT ON dbo.dailyUsage TO public
go
GRANT INSERT ON dbo.placeTypes TO public
go
GRANT INSERT ON dbo.usagePeaksView TO public
go
GRANT INSERT ON dbo.usagePeaksWithTimeView TO public
go
GRANT DELETE ON dbo.persistentPlacesChange TO public
go
GRANT DELETE ON dbo.categories TO public
go
GRANT DELETE ON dbo.PTGlist TO public
go
GRANT DELETE ON dbo.PersistentPTGlist TO public
go
GRANT DELETE ON dbo.persistentPlaces TO public
go
GRANT DELETE ON dbo.placeCategories TO public
go
GRANT DELETE ON dbo.placeUsage TO public
go
GRANT DELETE ON dbo.shadowPlaces TO public
go
GRANT DELETE ON dbo.dailyUsage TO public
go
GRANT DELETE ON dbo.placeTypes TO public
go
GRANT DELETE ON dbo.usagePeaksView TO public
go
GRANT DELETE ON dbo.usagePeaksWithTimeView TO public
go
GRANT UPDATE ON dbo.persistentPlacesChange TO public
go
GRANT UPDATE ON dbo.categories TO public
go
GRANT UPDATE ON dbo.PTGlist TO public
go
GRANT UPDATE ON dbo.PersistentPTGlist TO public
go
GRANT UPDATE ON dbo.persistentPlaces TO public
go
GRANT UPDATE ON dbo.placeCategories TO public
go
GRANT UPDATE ON dbo.placeUsage TO public
go
GRANT UPDATE ON dbo.shadowPlaces TO public
go
GRANT UPDATE ON dbo.dailyUsage TO public
go
GRANT UPDATE ON dbo.placeTypes TO public
go
GRANT UPDATE ON dbo.usagePeaksView TO public
go
GRANT UPDATE ON dbo.usagePeaksWithTimeView TO public
go
