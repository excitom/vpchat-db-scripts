USE master
go
IF DB_ID('audset') IS NOT NULL
BEGIN
    DROP DATABASE audset
    IF DB_ID('audset') IS NOT NULL
        PRINT '<<< FAILED DROPPING DATABASE audset >>>'
    ELSE
        PRINT '<<< DROPPED DATABASE audset >>>'
END
go
USE master
go
IF DB_ID('vpplaces') IS NOT NULL
BEGIN
    DROP DATABASE vpplaces
    IF DB_ID('vpplaces') IS NOT NULL
        PRINT '<<< FAILED DROPPING DATABASE vpplaces >>>'
    ELSE
        PRINT '<<< DROPPED DATABASE vpplaces >>>'
END
go
USE master
go
IF DB_ID('vpusers') IS NOT NULL
BEGIN
    DROP DATABASE vpusers
    IF DB_ID('vpusers') IS NOT NULL
        PRINT '<<< FAILED DROPPING DATABASE vpusers >>>'
    ELSE
        PRINT '<<< DROPPED DATABASE vpusers >>>'
END
go

