USE master
go
IF EXISTS (SELECT * FROM master.dbo.sysdevices WHERE name='Audsets')
BEGIN
    EXEC sp_dropdevice 'Audsets' 
    IF EXISTS (SELECT * FROM master.dbo.sysdevices WHERE name='Audsets')
        PRINT '<<< FAILED DROPPING DEVICE Audsets >>>'
    ELSE
        PRINT '<<< DROPPED DEVICE Audsets >>>'
END
go
USE master
go
IF EXISTS (SELECT * FROM master.dbo.sysdevices WHERE name='Audsets_log')
BEGIN
    EXEC sp_dropdevice 'Audsets_log' 
    IF EXISTS (SELECT * FROM master.dbo.sysdevices WHERE name='Audsets_log')
        PRINT '<<< FAILED DROPPING DEVICE Audsets_log >>>'
    ELSE
        PRINT '<<< DROPPED DEVICE Audsets_log >>>'
END
go
USE master
go
IF EXISTS (SELECT * FROM master.dbo.sysdevices WHERE name='VpDatabases')
BEGIN
    EXEC sp_dropdevice 'VpDatabases' 
    IF EXISTS (SELECT * FROM master.dbo.sysdevices WHERE name='VpDatabases')
        PRINT '<<< FAILED DROPPING DEVICE VpDatabases >>>'
    ELSE
        PRINT '<<< DROPPED DEVICE VpDatabases >>>'
END
go
USE master
go
IF EXISTS (SELECT * FROM master.dbo.sysdevices WHERE name='VpDatabases_log')
BEGIN
    EXEC sp_dropdevice 'VpDatabases_log' 
    IF EXISTS (SELECT * FROM master.dbo.sysdevices WHERE name='VpDatabases_log')
        PRINT '<<< FAILED DROPPING DEVICE VpDatabases_log >>>'
    ELSE
        PRINT '<<< DROPPED DEVICE VpDatabases_log >>>'
END
go
USE master
go
IF EXISTS (SELECT * FROM master.dbo.sysdevices WHERE name='VpUserDetails')
BEGIN
    EXEC sp_dropdevice 'VpUserDetails' 
    IF EXISTS (SELECT * FROM master.dbo.sysdevices WHERE name='VpUserDetails')
        PRINT '<<< FAILED DROPPING DEVICE VpUserDetails >>>'
    ELSE
        PRINT '<<< DROPPED DEVICE VpUserDetails >>>'
END
go
USE master
go
IF EXISTS (SELECT * FROM master.dbo.sysdevices WHERE name='VpUserDetails_log')
BEGIN
    EXEC sp_dropdevice 'VpUserDetails_log' 
    IF EXISTS (SELECT * FROM master.dbo.sysdevices WHERE name='VpUserDetails_log')
        PRINT '<<< FAILED DROPPING DEVICE VpUserDetails_log >>>'
    ELSE
        PRINT '<<< DROPPED DEVICE VpUserDetails_log >>>'
END
go
USE master
go
IF EXISTS (SELECT * FROM master.dbo.sysdevices WHERE name='temp_data')
BEGIN
    EXEC sp_dropdevice 'temp_data' 
    IF EXISTS (SELECT * FROM master.dbo.sysdevices WHERE name='temp_data')
        PRINT '<<< FAILED DROPPING DEVICE temp_data >>>'
    ELSE
        PRINT '<<< DROPPED DEVICE temp_data >>>'
END
go
USE master
go
IF EXISTS (SELECT * FROM master.dbo.sysdevices WHERE name='temp_log')
BEGIN
    EXEC sp_dropdevice 'temp_log' 
    IF EXISTS (SELECT * FROM master.dbo.sysdevices WHERE name='temp_log')
        PRINT '<<< FAILED DROPPING DEVICE temp_log >>>'
    ELSE
        PRINT '<<< DROPPED DEVICE temp_log >>>'
END
go

