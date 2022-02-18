--------------------------------------------------------------------------------
-- DBArtisan Schema Extraction
-- TARGET DB:
-- 	audset
--------------------------------------------------------------------------------

--
-- Target Database: audset
--

USE audset
go

--
-- DROP INDEXES
--
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.auditoriumChanges') AND name='audChangesIdx')
BEGIN
    DROP INDEX auditoriumChanges.audChangesIdx
    IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.auditoriumChanges') AND name='audChangesIdx')
        PRINT '<<< FAILED DROPPING INDEX auditoriumChanges.audChangesIdx >>>'
    ELSE
        PRINT '<<< DROPPED INDEX auditoriumChanges.audChangesIdx >>>'
END
go

IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.eventInteractions') AND name='interactionsByEventIdx')
BEGIN
    DROP INDEX eventInteractions.interactionsByEventIdx
    IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.eventInteractions') AND name='interactionsByEventIdx')
        PRINT '<<< FAILED DROPPING INDEX eventInteractions.interactionsByEventIdx >>>'
    ELSE
        PRINT '<<< DROPPED INDEX eventInteractions.interactionsByEventIdx >>>'
END
go

IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.eventInteractions') AND name='interactionsByStatusIdx')
BEGIN
    DROP INDEX eventInteractions.interactionsByStatusIdx
    IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.eventInteractions') AND name='interactionsByStatusIdx')
        PRINT '<<< FAILED DROPPING INDEX eventInteractions.interactionsByStatusIdx >>>'
    ELSE
        PRINT '<<< DROPPED INDEX eventInteractions.interactionsByStatusIdx >>>'
END
go

IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.userVotes') AND name='userVotesIdx')
BEGIN
    DROP INDEX userVotes.userVotesIdx
    IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.userVotes') AND name='userVotesIdx')
        PRINT '<<< FAILED DROPPING INDEX userVotes.userVotesIdx >>>'
    ELSE
        PRINT '<<< DROPPED INDEX userVotes.userVotesIdx >>>'
END
go


--
-- DROP PROCEDURES
--
IF OBJECT_ID('dbo.addAnswer') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.addAnswer
    IF OBJECT_ID('dbo.addAnswer') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.addAnswer >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.addAnswer >>>'
END
go

IF OBJECT_ID('dbo.addAuditorium') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.addAuditorium
    IF OBJECT_ID('dbo.addAuditorium') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.addAuditorium >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.addAuditorium >>>'
END
go

IF OBJECT_ID('dbo.addEvent') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.addEvent
    IF OBJECT_ID('dbo.addEvent') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.addEvent >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.addEvent >>>'
END
go

IF OBJECT_ID('dbo.addEventVote') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.addEventVote
    IF OBJECT_ID('dbo.addEventVote') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.addEventVote >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.addEventVote >>>'
END
go

IF OBJECT_ID('dbo.addInteraction') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.addInteraction
    IF OBJECT_ID('dbo.addInteraction') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.addInteraction >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.addInteraction >>>'
END
go

IF OBJECT_ID('dbo.addInvitee') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.addInvitee
    IF OBJECT_ID('dbo.addInvitee') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.addInvitee >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.addInvitee >>>'
END
go

IF OBJECT_ID('dbo.addUserVote') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.addUserVote
    IF OBJECT_ID('dbo.addUserVote') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.addUserVote >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.addUserVote >>>'
END
go

IF OBJECT_ID('dbo.addVoteOption') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.addVoteOption
    IF OBJECT_ID('dbo.addVoteOption') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.addVoteOption >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.addVoteOption >>>'
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

IF OBJECT_ID('dbo.blockInteractions') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.blockInteractions
    IF OBJECT_ID('dbo.blockInteractions') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.blockInteractions >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.blockInteractions >>>'
END
go

IF OBJECT_ID('dbo.changeAnswerStatus') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.changeAnswerStatus
    IF OBJECT_ID('dbo.changeAnswerStatus') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.changeAnswerStatus >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.changeAnswerStatus >>>'
END
go

IF OBJECT_ID('dbo.changeInteractionStatus') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.changeInteractionStatus
    IF OBJECT_ID('dbo.changeInteractionStatus') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.changeInteractionStatus >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.changeInteractionStatus >>>'
END
go

IF OBJECT_ID('dbo.changeVoteStatus') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.changeVoteStatus
    IF OBJECT_ID('dbo.changeVoteStatus') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.changeVoteStatus >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.changeVoteStatus >>>'
END
go

IF OBJECT_ID('dbo.clearAuditoriumChanges') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.clearAuditoriumChanges
    IF OBJECT_ID('dbo.clearAuditoriumChanges') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.clearAuditoriumChanges >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.clearAuditoriumChanges >>>'
END
go

IF OBJECT_ID('dbo.clearAuditoriums') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.clearAuditoriums
    IF OBJECT_ID('dbo.clearAuditoriums') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.clearAuditoriums >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.clearAuditoriums >>>'
END
go

IF OBJECT_ID('dbo.clearEventChanges') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.clearEventChanges
    IF OBJECT_ID('dbo.clearEventChanges') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.clearEventChanges >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.clearEventChanges >>>'
END
go

IF OBJECT_ID('dbo.clearEvents') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.clearEvents
    IF OBJECT_ID('dbo.clearEvents') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.clearEvents >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.clearEvents >>>'
END
go

IF OBJECT_ID('dbo.clearInteractions') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.clearInteractions
    IF OBJECT_ID('dbo.clearInteractions') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.clearInteractions >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.clearInteractions >>>'
END
go

IF OBJECT_ID('dbo.clearNewInteractions') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.clearNewInteractions
    IF OBJECT_ID('dbo.clearNewInteractions') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.clearNewInteractions >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.clearNewInteractions >>>'
END
go

IF OBJECT_ID('dbo.clearOldEvents') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.clearOldEvents
    IF OBJECT_ID('dbo.clearOldEvents') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.clearOldEvents >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.clearOldEvents >>>'
END
go

IF OBJECT_ID('dbo.delAuditorium') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.delAuditorium
    IF OBJECT_ID('dbo.delAuditorium') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.delAuditorium >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.delAuditorium >>>'
END
go

IF OBJECT_ID('dbo.delDuplAud') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.delDuplAud
    IF OBJECT_ID('dbo.delDuplAud') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.delDuplAud >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.delDuplAud >>>'
END
go

IF OBJECT_ID('dbo.delEvent') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.delEvent
    IF OBJECT_ID('dbo.delEvent') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.delEvent >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.delEvent >>>'
END
go

IF OBJECT_ID('dbo.delEventUserVotes') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.delEventUserVotes
    IF OBJECT_ID('dbo.delEventUserVotes') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.delEventUserVotes >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.delEventUserVotes >>>'
END
go

IF OBJECT_ID('dbo.delEventVote') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.delEventVote
    IF OBJECT_ID('dbo.delEventVote') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.delEventVote >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.delEventVote >>>'
END
go

IF OBJECT_ID('dbo.delInvitee') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.delInvitee
    IF OBJECT_ID('dbo.delInvitee') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.delInvitee >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.delInvitee >>>'
END
go

IF OBJECT_ID('dbo.delUserVotes') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.delUserVotes
    IF OBJECT_ID('dbo.delUserVotes') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.delUserVotes >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.delUserVotes >>>'
END
go

IF OBJECT_ID('dbo.delVoteOption') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.delVoteOption
    IF OBJECT_ID('dbo.delVoteOption') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.delVoteOption >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.delVoteOption >>>'
END
go

IF OBJECT_ID('dbo.editInteraction') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.editInteraction
    IF OBJECT_ID('dbo.editInteraction') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.editInteraction >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.editInteraction >>>'
END
go

IF OBJECT_ID('dbo.getActiveEvents') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getActiveEvents
    IF OBJECT_ID('dbo.getActiveEvents') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getActiveEvents >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getActiveEvents >>>'
END
go

IF OBJECT_ID('dbo.getAllAuditoriums') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getAllAuditoriums
    IF OBJECT_ID('dbo.getAllAuditoriums') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getAllAuditoriums >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getAllAuditoriums >>>'
END
go

IF OBJECT_ID('dbo.getAnswers') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getAnswers
    IF OBJECT_ID('dbo.getAnswers') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getAnswers >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getAnswers >>>'
END
go

IF OBJECT_ID('dbo.getAuditorium') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getAuditorium
    IF OBJECT_ID('dbo.getAuditorium') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getAuditorium >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getAuditorium >>>'
END
go

IF OBJECT_ID('dbo.getAuditoriumID') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getAuditoriumID
    IF OBJECT_ID('dbo.getAuditoriumID') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getAuditoriumID >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getAuditoriumID >>>'
END
go

IF OBJECT_ID('dbo.getAuditoriumImage') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getAuditoriumImage
    IF OBJECT_ID('dbo.getAuditoriumImage') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getAuditoriumImage >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getAuditoriumImage >>>'
END
go

IF OBJECT_ID('dbo.getAuditoriumInfo') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getAuditoriumInfo
    IF OBJECT_ID('dbo.getAuditoriumInfo') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getAuditoriumInfo >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getAuditoriumInfo >>>'
END
go

IF OBJECT_ID('dbo.getAuditoriumList') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getAuditoriumList
    IF OBJECT_ID('dbo.getAuditoriumList') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getAuditoriumList >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getAuditoriumList >>>'
END
go

IF OBJECT_ID('dbo.getAuditoriumsUpdates') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getAuditoriumsUpdates
    IF OBJECT_ID('dbo.getAuditoriumsUpdates') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getAuditoriumsUpdates >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getAuditoriumsUpdates >>>'
END
go

IF OBJECT_ID('dbo.getEvent') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getEvent
    IF OBJECT_ID('dbo.getEvent') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getEvent >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getEvent >>>'
END
go

IF OBJECT_ID('dbo.getEventHeader') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getEventHeader
    IF OBJECT_ID('dbo.getEventHeader') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getEventHeader >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getEventHeader >>>'
END
go

IF OBJECT_ID('dbo.getEventImage') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getEventImage
    IF OBJECT_ID('dbo.getEventImage') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getEventImage >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getEventImage >>>'
END
go

IF OBJECT_ID('dbo.getEventInfo') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getEventInfo
    IF OBJECT_ID('dbo.getEventInfo') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getEventInfo >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getEventInfo >>>'
END
go

IF OBJECT_ID('dbo.getEventInteractionTypes') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getEventInteractionTypes
    IF OBJECT_ID('dbo.getEventInteractionTypes') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getEventInteractionTypes >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getEventInteractionTypes >>>'
END
go

IF OBJECT_ID('dbo.getEventList') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getEventList
    IF OBJECT_ID('dbo.getEventList') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getEventList >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getEventList >>>'
END
go

IF OBJECT_ID('dbo.getEventStateInfo') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getEventStateInfo
    IF OBJECT_ID('dbo.getEventStateInfo') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getEventStateInfo >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getEventStateInfo >>>'
END
go

IF OBJECT_ID('dbo.getEventVotesList') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getEventVotesList
    IF OBJECT_ID('dbo.getEventVotesList') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getEventVotesList >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getEventVotesList >>>'
END
go

IF OBJECT_ID('dbo.getEventsUpdates') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getEventsUpdates
    IF OBJECT_ID('dbo.getEventsUpdates') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getEventsUpdates >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getEventsUpdates >>>'
END
go

IF OBJECT_ID('dbo.getInteractionInfo') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getInteractionInfo
    IF OBJECT_ID('dbo.getInteractionInfo') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getInteractionInfo >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getInteractionInfo >>>'
END
go

IF OBJECT_ID('dbo.getInteractions') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getInteractions
    IF OBJECT_ID('dbo.getInteractions') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getInteractions >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getInteractions >>>'
END
go

IF OBJECT_ID('dbo.getInteractionsNum') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getInteractionsNum
    IF OBJECT_ID('dbo.getInteractionsNum') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getInteractionsNum >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getInteractionsNum >>>'
END
go

IF OBJECT_ID('dbo.getInvitees') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getInvitees
    IF OBJECT_ID('dbo.getInvitees') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getInvitees >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getInvitees >>>'
END
go

IF OBJECT_ID('dbo.getMasterHostList') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getMasterHostList
    IF OBJECT_ID('dbo.getMasterHostList') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getMasterHostList >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getMasterHostList >>>'
END
go

IF OBJECT_ID('dbo.getNewEventStates') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getNewEventStates
    IF OBJECT_ID('dbo.getNewEventStates') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getNewEventStates >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getNewEventStates >>>'
END
go

IF OBJECT_ID('dbo.getVoteHdr') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getVoteHdr
    IF OBJECT_ID('dbo.getVoteHdr') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getVoteHdr >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getVoteHdr >>>'
END
go

IF OBJECT_ID('dbo.getVoteOptionsList') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getVoteOptionsList
    IF OBJECT_ID('dbo.getVoteOptionsList') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getVoteOptionsList >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getVoteOptionsList >>>'
END
go

IF OBJECT_ID('dbo.getVoteResults') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.getVoteResults
    IF OBJECT_ID('dbo.getVoteResults') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.getVoteResults >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.getVoteResults >>>'
END
go

IF OBJECT_ID('dbo.setEventState') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.setEventState
    IF OBJECT_ID('dbo.setEventState') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.setEventState >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.setEventState >>>'
END
go

IF OBJECT_ID('dbo.updAudURL') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.updAudURL
    IF OBJECT_ID('dbo.updAudURL') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.updAudURL >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.updAudURL >>>'
END
go

IF OBJECT_ID('dbo.updateAuditorium') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.updateAuditorium
    IF OBJECT_ID('dbo.updateAuditorium') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.updateAuditorium >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.updateAuditorium >>>'
END
go

IF OBJECT_ID('dbo.updateEvent') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.updateEvent
    IF OBJECT_ID('dbo.updateEvent') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.updateEvent >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.updateEvent >>>'
END
go

IF OBJECT_ID('dbo.updateEventVote') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.updateEventVote
    IF OBJECT_ID('dbo.updateEventVote') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.updateEventVote >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.updateEventVote >>>'
END
go

IF OBJECT_ID('dbo.updateVoteOption') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.updateVoteOption
    IF OBJECT_ID('dbo.updateVoteOption') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.updateVoteOption >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.updateVoteOption >>>'
END
go


--
-- DROP TRIGGERS
--
IF OBJECT_ID('delAuditoriumData') IS NOT NULL
BEGIN
    DROP TRIGGER delAuditoriumData
    IF OBJECT_ID('delAuditoriumData') IS NOT NULL
        PRINT '<<< FAILED DROPPING TRIGGER delAuditoriumData >>>'
    ELSE
        PRINT '<<< DROPPED TRIGGER delAuditoriumData >>>'
END
go

IF OBJECT_ID('delEventData') IS NOT NULL
BEGIN
    DROP TRIGGER delEventData
    IF OBJECT_ID('delEventData') IS NOT NULL
        PRINT '<<< FAILED DROPPING TRIGGER delEventData >>>'
    ELSE
        PRINT '<<< DROPPED TRIGGER delEventData >>>'
END
go


--
-- DROP VIEWS
--
IF OBJECT_ID('dbo.correctStates') IS NOT NULL
BEGIN
    DROP VIEW dbo.correctStates
    IF OBJECT_ID('dbo.correctStates') IS NOT NULL
        PRINT '<<< FAILED DROPPING VIEW dbo.correctStates >>>'
    ELSE
        PRINT '<<< DROPPED VIEW dbo.correctStates >>>'
END
go

IF OBJECT_ID('dbo.eventTimes') IS NOT NULL
BEGIN
    DROP VIEW dbo.eventTimes
    IF OBJECT_ID('dbo.eventTimes') IS NOT NULL
        PRINT '<<< FAILED DROPPING VIEW dbo.eventTimes >>>'
    ELSE
        PRINT '<<< DROPPED VIEW dbo.eventTimes >>>'
END
go

IF OBJECT_ID('dbo.eventsList') IS NOT NULL
BEGIN
    DROP VIEW dbo.eventsList
    IF OBJECT_ID('dbo.eventsList') IS NOT NULL
        PRINT '<<< FAILED DROPPING VIEW dbo.eventsList >>>'
    ELSE
        PRINT '<<< DROPPED VIEW dbo.eventsList >>>'
END
go

IF OBJECT_ID('dbo.lastStateChanges') IS NOT NULL
BEGIN
    DROP VIEW dbo.lastStateChanges
    IF OBJECT_ID('dbo.lastStateChanges') IS NOT NULL
        PRINT '<<< FAILED DROPPING VIEW dbo.lastStateChanges >>>'
    ELSE
        PRINT '<<< DROPPED VIEW dbo.lastStateChanges >>>'
END
go


--
-- DROP TABLES
--
DROP TABLE dbo.answers
go

DROP TABLE dbo.auditoriumChanges
go

DROP TABLE dbo.auditoriums
go

DROP TABLE dbo.eventChanges
go

DROP TABLE dbo.eventInteractions
go

DROP TABLE dbo.eventInvitees
go

DROP TABLE dbo.eventState
go

DROP TABLE dbo.eventVotes
go

DROP TABLE dbo.events
go

DROP TABLE dbo.hosts
go

DROP TABLE dbo.interactionStatus
go

DROP TABLE dbo.interactionsAllowed
go

DROP TABLE dbo.stateTypes
go

DROP TABLE dbo.userVotes
go

DROP TABLE dbo.voteOptions
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


--
-- CREATE USERS
--
EXEC sp_adduser '','audset','public'
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
CREATE TABLE dbo.answers 
(
    interactionID numeric(10,0) NOT NULL,
    time          smalldatetime NOT NULL,
    senderName    VPuserID      NOT NULL,
    text          varchar(255)  NULL,
    status        numeric(2,0)  NOT NULL,
    hostName      VPuserID      NULL,
    CONSTRAINT answers_3840043991 PRIMARY KEY CLUSTERED (interactionID)
)
go
IF OBJECT_ID('dbo.answers') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.answers >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.answers >>>'
go

CREATE TABLE dbo.auditoriumChanges 
(
    auditoriumID numeric(6,0) NOT NULL,
    fieldID      int          NOT NULL
)
go
IF OBJECT_ID('dbo.auditoriumChanges') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.auditoriumChanges >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.auditoriumChanges >>>'
go

CREATE TABLE dbo.auditoriums 
(
    auditoriumID  numeric(6,0) IDENTITY,
    name          varchar(16)  NOT NULL,
    background    varchar(255) NOT NULL,
    title         varchar(255) NOT NULL,
    welcomeMsg1   varchar(255) NULL,
    welcomeMsg2   varchar(255) NULL,
    welcomeImage  image        NULL,
    inPlacesList  bit          DEFAULT 1	 NOT NULL,
    stageCapacity int          NOT NULL,
    rowSize       int          NOT NULL,
    numberOfRows  int          NOT NULL,
    rowNamePrefix varchar(10)  DEFAULT "Row "	 NOT NULL,
    client        varchar(16)  NULL,
    CONSTRAINT isPrimary PRIMARY KEY CLUSTERED (auditoriumID)
)
go
IF OBJECT_ID('dbo.auditoriums') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.auditoriums >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.auditoriums >>>'
go

CREATE TABLE dbo.eventChanges 
(
    eventID numeric(10,0) NOT NULL,
    stateID numeric(4,0)  NOT NULL,
    fieldID int           NOT NULL,
    CONSTRAINT eventChang_1120034301 PRIMARY KEY CLUSTERED (eventID,stateID)
)
go
IF OBJECT_ID('dbo.eventChanges') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.eventChanges >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.eventChanges >>>'
go

CREATE TABLE dbo.eventInteractions 
(
    interactionID   numeric(10,0) IDENTITY,
    eventID         numeric(10,0) NOT NULL,
    interactionType numeric(2,0)  NOT NULL,
    time            smalldatetime NOT NULL,
    senderName      VPuserID      NOT NULL,
    text            varchar(255)  NULL,
    status          numeric(2,0)  NOT NULL,
    category        varchar(16)   NULL,
    hostName        VPuserID      NULL,
    CONSTRAINT isPrimary PRIMARY KEY CLUSTERED (interactionID)
)
go
IF OBJECT_ID('dbo.eventInteractions') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.eventInteractions >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.eventInteractions >>>'
go

CREATE TABLE dbo.eventInvitees 
(
    eventID     eventIdentifier NOT NULL,
    inviteeName VPuserID        NOT NULL,
    regMode     VpRegMode       NOT NULL,
    CONSTRAINT eventInvit_4160045131 PRIMARY KEY CLUSTERED (eventID,inviteeName)
)
go
IF OBJECT_ID('dbo.eventInvitees') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.eventInvitees >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.eventInvitees >>>'
go

CREATE TABLE dbo.eventState 
(
    eventID     eventIdentifier NOT NULL,
    stateID     stateIdentifier NOT NULL,
    name        varchar(16)     NOT NULL,
    time        VpTime          NOT NULL,
    welcomeMsg1 longName        NULL,
    welcomeMsg2 longName        NULL,
    PTGtitle    longName        NULL,
    CONSTRAINT eventState_1760036581 PRIMARY KEY CLUSTERED (eventID,stateID)
)
go
IF OBJECT_ID('dbo.eventState') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.eventState >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.eventState >>>'
go

CREATE TABLE dbo.eventVotes 
(
    voteID      numeric(10,0)   IDENTITY,
    eventID     eventIdentifier NOT NULL,
    title       varchar(50)     NOT NULL,
    description varchar(200)    NOT NULL,
    numChoices  int             NOT NULL,
    status      int             NULL,
    CONSTRAINT isPrimary PRIMARY KEY CLUSTERED (voteID)
)
go
IF OBJECT_ID('dbo.eventVotes') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.eventVotes >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.eventVotes >>>'
go

CREATE TABLE dbo.events 
(
    eventID         eventIdentifier      IDENTITY,
    auditorium      auditoriumIdentifier NOT NULL,
    date            VpTime               NOT NULL,
    currentState    numeric(4,0)         DEFAULT 0	 NOT NULL,
    title           longName             NOT NULL,
    client          varchar(16)          NULL,
    rowSize         int                  NOT NULL,
    rowNamePrefix   varchar(10)          DEFAULT "Row "	 NOT NULL,
    welcomeImage    image                NULL,
    stageBackground longName             NOT NULL,
    CONSTRAINT isPrimary PRIMARY KEY CLUSTERED (eventID)
)
go
IF OBJECT_ID('dbo.events') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.events >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.events >>>'
go

CREATE TABLE dbo.hosts 
(
    userID       userIdentifier NOT NULL,
    auditoriumID numeric(6,0)   NULL,
    eventID      numeric(10,0)  NULL
)
go
IF OBJECT_ID('dbo.hosts') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.hosts >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.hosts >>>'
go

CREATE TABLE dbo.interactionStatus 
(
    statusID numeric(2,0) NOT NULL,
    name     varchar(16)  NOT NULL,
    CONSTRAINT interactio_4800047411 PRIMARY KEY CLUSTERED (statusID)
)
go
IF OBJECT_ID('dbo.interactionStatus') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.interactionStatus >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.interactionStatus >>>'
go

CREATE TABLE dbo.interactionsAllowed 
(
    eventID         numeric(10,0) NOT NULL,
    interactionType numeric(2,0)  NOT NULL,
    name            varchar(16)   NOT NULL,
    interactBlocked bit           DEFAULT 0	 NOT NULL,
    CONSTRAINT interactio_3040041141 PRIMARY KEY CLUSTERED (eventID,interactionType)
)
go
IF OBJECT_ID('dbo.interactionsAllowed') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.interactionsAllowed >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.interactionsAllowed >>>'
go

CREATE TABLE dbo.stateTypes 
(
    typeID numeric(4,0) IDENTITY,
    title  varchar(16)  NOT NULL,
    CONSTRAINT isPrimary PRIMARY KEY CLUSTERED (typeID)
)
go
IF OBJECT_ID('dbo.stateTypes') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.stateTypes >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.stateTypes >>>'
go

CREATE TABLE dbo.userVotes 
(
    voteID   numeric(10,0) NOT NULL,
    optionID int           NOT NULL,
    name     VPuserID      NULL,
    time     smalldatetime NOT NULL
)
go
IF OBJECT_ID('dbo.userVotes') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.userVotes >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.userVotes >>>'
go

CREATE TABLE dbo.voteOptions 
(
    voteID          numeric(10,0) NOT NULL,
    optionID        numeric(2,0)  NOT NULL,
    label           varchar(10)   NOT NULL,
    description     varchar(50)   NULL,
    totalSelections int           NULL,
    CONSTRAINT voteOption_5440049691 PRIMARY KEY CLUSTERED (voteID,optionID)
)
go
IF OBJECT_ID('dbo.voteOptions') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.voteOptions >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.voteOptions >>>'
go


--
-- CREATE INDEXES
--
CREATE NONCLUSTERED INDEX audChangesIdx
    ON dbo.auditoriumChanges(auditoriumID)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.auditoriumChanges') AND name='audChangesIdx')
    PRINT '<<< CREATED INDEX dbo.auditoriumChanges.audChangesIdx >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.auditoriumChanges.audChangesIdx >>>'
go

CREATE NONCLUSTERED INDEX interactionsByEventIdx
    ON dbo.eventInteractions(eventID,interactionType,status,hostName)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.eventInteractions') AND name='interactionsByEventIdx')
    PRINT '<<< CREATED INDEX dbo.eventInteractions.interactionsByEventIdx >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.eventInteractions.interactionsByEventIdx >>>'
go

CREATE NONCLUSTERED INDEX interactionsByStatusIdx
    ON dbo.eventInteractions(status,hostName)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.eventInteractions') AND name='interactionsByStatusIdx')
    PRINT '<<< CREATED INDEX dbo.eventInteractions.interactionsByStatusIdx >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.eventInteractions.interactionsByStatusIdx >>>'
go

CREATE NONCLUSTERED INDEX userVotesIdx
    ON dbo.userVotes(voteID,optionID)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.userVotes') AND name='userVotesIdx')
    PRINT '<<< CREATED INDEX dbo.userVotes.userVotesIdx >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.userVotes.userVotesIdx >>>'
go


--
-- CREATE VIEWS
--

CREATE VIEW lastStateChanges
AS
  SELECT eventID, max(time) AS changeTime
    FROM eventState, vpusers..getGMT
    WHERE time <= dateadd( hour, (-1) * gmt, getdate() )
    GROUP BY eventID

go
IF OBJECT_ID('dbo.lastStateChanges') IS NOT NULL
    PRINT '<<< CREATED VIEW dbo.lastStateChanges >>>'
ELSE
    PRINT '<<< FAILED CREATING VIEW dbo.lastStateChanges >>>'
go

CREATE VIEW correctStates
AS
  SELECT eventState.eventID, stateID
    FROM eventState, lastStateChanges
  WHERE eventState.eventID = lastStateChanges.eventID AND
        eventState.time = lastStateChanges.changeTime

go
IF OBJECT_ID('dbo.correctStates') IS NOT NULL
    PRINT '<<< CREATED VIEW dbo.correctStates >>>'
ELSE
    PRINT '<<< FAILED CREATING VIEW dbo.correctStates >>>'
go

CREATE VIEW eventTimes
AS
  SELECT DISTINCT events.eventID,
         min(eventState.time) AS startTime,
         max(eventState.time) AS endTime
    FROM events, eventState
    WHERE events.eventID = eventState.eventID
    GROUP BY events.eventID

go
IF OBJECT_ID('dbo.eventTimes') IS NOT NULL
    PRINT '<<< CREATED VIEW dbo.eventTimes >>>'
ELSE
    PRINT '<<< FAILED CREATING VIEW dbo.eventTimes >>>'
go

CREATE VIEW eventsList
AS
  SELECT DISTINCT events.eventID, events.title,
         startTime, endTime,
         auditoriums.name AS auditoriumName 
    FROM events, auditoriums, eventTimes
    WHERE events.auditorium = auditoriums.auditoriumID AND
          events.eventID = eventTimes.eventID

go
IF OBJECT_ID('dbo.eventsList') IS NOT NULL
    PRINT '<<< CREATED VIEW dbo.eventsList >>>'
ELSE
    PRINT '<<< FAILED CREATING VIEW dbo.eventsList >>>'
go



--
-- CREATE PROCEDURES
--
/* add one guest answer to a specific interaction */
/* input:  interaction id, guest name, text
   output: Returns 20001 if original interaction's status is not ATGUEST,
                   20002 if /* sender not a predefined invitee */
*/
CREATE PROC addAnswer
(
  @interactionID	numeric(10,0),
  @senderName		VPuserID,
  @text                 varchar(255)
)
AS
BEGIN
  DECLARE @diffFromGMT int
  DECLARE @currentDate VpTime
  DECLARE @lastError int
  DECLARE @ready int
  DECLARE @atguest int
  DECLARE @interactionStatus int
  DECLARE @eventID eventIdentifier
  DECLARE @regMode int

    SELECT @ready = statusID
    FROM interactionStatus
    WHERE name = "READY"
    SELECT @lastError = @@error
    IF @lastError != 0
     RETURN @lastError
 
    SELECT @atguest = statusID
    FROM interactionStatus
    WHERE name = "ATGUEST"
    SELECT @lastError = @@error
    IF @lastError != 0
      RETURN @lastError
 
    /* Check that the original interaction exists and its status is
       "ATGUEST" */  
    SELECT @interactionStatus = status, @eventID = eventID
    FROM eventInteractions ( INDEX isPrimary )
    WHERE interactionID = @interactionID
    SELECT @lastError = @@error
    IF @lastError != 0
      RETURN @lastError
    IF @interactionStatus != @atguest
      RETURN 20001
 
    /* Check that the guest is in the list of event guests, and add "@aol"
       to his/her name if its reg mode is AOL ie. 3 */
    SELECT @regMode = regMode
      FROM eventInvitees
      WHERE inviteeName = @senderName
    SELECT @lastError = @@error
    IF @lastError != 0
      RETURN @lastError
    IF @regMode IS NULL 		/* sender not a predefined invitee */
      RETURN 20002
    ELSE IF @regMode = 3
     SELECT @senderName = @senderName + "@aol"
 
    /* Get current GMT time */
    SELECT @diffFromGMT = gmt
    FROM vpusers..getGMT
    SELECT @lastError = @@error
    IF @lastError != 0
      RETURN @lastError
    
   /* Add the Guest Answer to the database */
   INSERT INTO answers 
      ( interactionID, time, senderName, text, status)
    VALUES ( @interactionID, 
  	     dateadd( hour, (-1) * @diffFromGMT, getdate() ), 
             @senderName, @text, @ready )
    
    SELECT @lastError = @@error
    IF @lastError != 0
      RETURN @lastError
    
END

go
IF OBJECT_ID('dbo.addAnswer') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.addAnswer >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.addAnswer >>>'
go

/* add a new definition of an auditorium to the database */
/* input:  auditorium name, client name,
           background URL, default title, show on PTG flag,
           default welcome msg, row size, num. of rows
   output: return value is 20001 if name is already used,
                           20002 if URL is already used,
                           20003 if auditorium already in persistent places table
           0 otherwise
*/
CREATE PROC addAuditorium
(
  @auditoriumName	varchar(16),
  @clientName		varchar(16),
  @background		varchar(255),
  @title		varchar(255),
  @showOnPTG		bit,
  @welcomeMsg1		varchar(255),
  @welcomeMsg2		varchar(255),
  @stageCapacity	integer,
  @rowSize		integer,
  @numberOfRows		integer
)
AS
BEGIN
  
  DECLARE @lastError int
  DECLARE @exists    int

  BEGIN TRAN
    
    IF EXISTS
      ( SELECT auditoriumID
	  FROM auditoriums
  	  WHERE name = @auditoriumName )
    BEGIN
      /* name is already used */
      ROLLBACK TRAN
      RETURN 20001
    END
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
    
    IF EXISTS
      ( SELECT auditoriumID
	  FROM auditoriums
  	  WHERE background = @background )
    BEGIN
      /* URL is already used */
      ROLLBACK TRAN
      RETURN 20002
    END
  
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
    
    EXEC vpplaces..persistentPlaceExists @background, @exists output
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
 
    IF @exists = 1
    BEGIN
      /* URL is already used in persistentPlaces*/
      ROLLBACK TRAN
      RETURN 20003
    END

    INSERT auditoriums
      ( name, background, title, 
        welcomeMsg1, welcomeMsg2, inPlacesList, 
        stageCapacity, rowSize, numberOfRows, client )
      VALUES 
      ( @auditoriumName, @background, @title, 
        @welcomeMsg1, @welcomeMsg2, @showOnPTG, 
        @stageCapacity, @rowSize, @numberOfRows, @clientName )
  
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
    
    /* add a change record, 0=new auditorium */
    INSERT auditoriumChanges
      VALUES(@@identity, 0)
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END

    /* add the auditorium to the list of persistent places */
    EXEC vpplaces..addPersistentPlace @background, 2049, @title, @stageCapacity, 1,
                             @numberOfRows, @rowSize, "Row "
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END

  COMMIT TRAN

END

go
IF OBJECT_ID('dbo.addAuditorium') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.addAuditorium >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.addAuditorium >>>'
go

/* add a new definition of an event to the database */
/* input:  event title, auditorium name, client name,
           time, background URL, 
           open time, open title, open welcome msg,
           start time, start title, start welcome msg,
           start time, start title, start welcome msg,
           end time,
           event interactions list
   output: return value - 0 if successfull,
                          20001 if auditorium does not exist
                          20002 if event overlaps other event(s)
*/
CREATE PROC addEvent
(
  @title		longName,
  @auditoriumName	varchar(16),
  @clientName		varchar(16),
  @time			VpTime,
  @background		longName,
  @openTime		VpTime,
  @openTitle		longName,
  @openWelcomeMsg1	longName,
  @openWelcomeMsg2	longName,
  @startTime		VpTime,
  @startTitle		longName,
  @startWelcomeMsg1	longName,
  @startWelcomeMsg2	longName,
  @endTime		VpTime,
  @eventInteractions	longName
)
AS
BEGIN
  CREATE TABLE #eventInteractions ( id integer, description varchar(16) )
  DECLARE @description varchar(16)
  DECLARE @commaPos integer
  DECLARE @counter integer
  DECLARE @lastError integer

  DECLARE @eventID int
  DECLARE @auditoriumID integer
  SELECT @counter = 1

  BEGIN TRAN addEvent

    /* find auditorium where the event is held */
    SELECT @auditoriumID = auditoriumID
      FROM auditoriums
      WHERE name = @auditoriumName
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      RAISERROR @lastError
      ROLLBACK TRAN addEvent
      RETURN @lastError
    END
    
    IF @auditoriumID IS NULL
      /* auditorium must exist to proceed */
    BEGIN
      ROLLBACK TRAN addEvent
      RETURN 20001
    END

    /* find if the time frame asked for is not booked already */
    IF EXISTS 
      ( SELECT events.eventID
        FROM eventTimes, events
         WHERE eventTimes.eventID = events.eventID AND
               events.auditorium = @auditoriumID   AND
               ( ( @openTime BETWEEN startTime AND endTime ) OR
                 ( @endTime BETWEEN startTime AND endTime )  OR
		 ( (@openTime < startTime) AND (@endTime > endTime))  ) )
    BEGIN
      /* event overlaps other event(s) */
      ROLLBACK TRAN addEvent
      RETURN 20002
    END
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      RAISERROR @lastError
      ROLLBACK TRAN addEvent
      RETURN @lastError
    END
    
    /* create event record */
    INSERT events
      ( auditorium, date, title, client, rowSize, stageBackground )
      VALUES ( @auditoriumID, @time, @title,
               @clientName, 0, @background )
    SELECT @eventID = @@identity

    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      RAISERROR @lastError
      ROLLBACK TRAN addEvent
      RETURN @lastError
    END
        
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      RAISERROR @lastError
      ROLLBACK TRAN addEvent
      RETURN @lastError
    END
    
    INSERT eventState
      VALUES ( @eventID, 1, "open", @openTime, 
               @openWelcomeMsg1, @openWelcomeMsg2, @openTitle )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      RAISERROR @lastError
      ROLLBACK TRAN addEvent
      RETURN @lastError
    END
    
    INSERT eventState
      VALUES ( @eventID, 2, "start", @startTime, 
               @startWelcomeMsg1, @startWelcomeMsg2, @startTitle )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      RAISERROR @lastError
      ROLLBACK TRAN addEvent
      RETURN @lastError
    END
    
    INSERT eventState
      VALUES ( @eventID, 3, "end", @endTime, "", "", "" )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      RAISERROR @lastError
      ROLLBACK TRAN addEvent
      RETURN @lastError
    END
    
    /* parse list of interaction types */
    WHILE ( ascii( rtrim(ltrim(@eventInteractions ))) > 32 ) BEGIN
      SELECT @commaPos = patindex( "%,%", @eventInteractions )
      IF @commaPos = 0 BEGIN
        SELECT @description = rtrim(ltrim(@eventInteractions))
        SELECT @eventInteractions = ""
      END
      ELSE BEGIN
        SELECT @description = 
                 rtrim( ltrim( substring( @eventInteractions, 1, @commaPos-1 ) ) )
        SELECT @eventInteractions = 
                 substring( @eventInteractions, 
                            @commaPos+1, 
                            char_length( @eventInteractions ) - @commaPos )
      END
      INSERT interactionsAllowed 
        ( eventID, interactionType, name )
        VALUES ( @eventID, @counter, @description )
    
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        RAISERROR @lastError
        ROLLBACK TRAN addEvent
        RETURN @lastError
      END
    
      SELECT @counter = @counter+1
    END /* of while */

  COMMIT TRAN addEvent
  SELECT @eventID

END

go
IF OBJECT_ID('dbo.addEvent') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.addEvent >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.addEvent >>>'
go

/* Adds an event vote description to the eventVotes table */
/* input:  eventId, vote title, vote description, number of choices allowed. 
   output: the id assigned to this vote
*/
CREATE PROC addEventVote
(
  @eventID		eventIdentifier,
  @title		varchar(50),
  @description          varchar(200),
  @numChoices		integer
)
AS
BEGIN
  INSERT INTO eventVotes 
      ( eventID, title, description, numChoices, status)
    VALUES ( @eventID, @title, @description, @numChoices, 0)

  SELECT @@identity
END    

go
IF OBJECT_ID('dbo.addEventVote') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.addEventVote >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.addEventVote >>>'
go

/* add one user interaction for a specific event */
/* input:  event id, interaction type, sender name, text, anonymous flag
   output: error 20001 if interaction type blocked.
*/
CREATE PROC addInteraction
(
  @eventID		numeric(10,0),
  @interactionType	numeric(2,0),
  @sender		varchar(16),
  @text                 varchar(255)
)
AS
BEGIN
  DECLARE @diffFromGMT int
  DECLARE @currentDate VpTime
  DECLARE @lastError int
  DECLARE @idle int
  DECLARE @blocked int

  BEGIN TRAN addInteraction

    /* Check if interaction type is blocked */
    SELECT @blocked = interactBlocked
      FROM interactionsAllowed
      WHERE eventID = @eventID AND
            interactionType = @interactionType
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN addInteraction
      RETURN @lastError
    END
    IF @blocked = 1
    BEGIN
      ROLLBACK TRAN addInteraction
      RETURN 20001
    END


    SELECT @diffFromGMT = gmt
    FROM vpusers..getGMT
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN addInteraction
      RAISERROR @lastError
      RETURN @lastError
    END
    
    SELECT @idle = statusID
    FROM interactionStatus
    WHERE name = "IDLE"
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN addInteraction
      RAISERROR @lastError
      RETURN @lastError
    END
 
    INSERT eventInteractions 
      ( eventID, interactionType, time, senderName, text, status)
    VALUES ( @eventID, @interactionType, 
  	   dateadd( hour, (-1) * @diffFromGMT, getdate() ), 
             @sender, @text, @idle )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN addInteraction
      RAISERROR @lastError
      RETURN @lastError
    END
    
  COMMIT TRAN addInteraction
END

go
IF OBJECT_ID('dbo.addInteraction') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.addInteraction >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.addInteraction >>>'
go

/* Adds an invited guest to the invitees table */
/* input:  eventId, invited guest name, registration mode 
   output: returns 20001 - if registration mode not 2(local) or 3(aol),
                   20002 - if user not registered locally when local registration is used
                           or if aux. registration is not allowed but aux. reg. mode was specified
                   20003 - if user already invited for that event
   18/6/97: Fix -- no check is made that the guest is registered.
   19/8/97 Yaron : Fix - check of user reg. mode is done so aux. user is
                         added to database with aux. reg mode if aux DB is allowed
                   Fix - put inside transaction, added more error handling
*/
CREATE PROC addInvitee
(
  @eventID		eventIdentifier,
  @name             	VPuserID,
  @regMode		VpRegMode
)
AS
BEGIN
  DECLARE @lastError   int
  DECLARE @retVal int
  DECLARE @isRegistered int
  DECLARE @nameExists  VPuserID
  DECLARE @auxDbAllowed bit

  IF @regMode != 2 AND @regMode != 3 
    RETURN 20001	

  BEGIN TRAN addInvitee
    SELECT @auxDbAllowed = intValue
      FROM vpusers..configurationKeys
      WHERE ( keyName = "auxDbAllowed" )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN addInvitee
      RETURN @lastError
    END
    
    /* check if the user is registered in the given registration mode */
      
    EXEC @retVal = vpusers..isRegistered @name, @regMode, @isRegistered output
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN addInvitee
      RETURN @lastError
    END
    
    IF @retVal != 0
    BEGIN
      ROLLBACK TRAN addInvitee
      RETURN @retVal
    END
    
    IF ( @isRegistered = 0 ) AND
       ( @auxDbAllowed = 0 )
    BEGIN
      /* assumption - the reg.mode that is passed is ALWAYS 2 = local */
      /* if user is not registered and local reg.mode is used,
         and aux. registration is not allowed,
         return with error code 20002 
         Note - when aux. registration IS allowed, we accept even if the
                the user is not registered */
      ROLLBACK TRAN addInvitee
      RETURN 20002
    END
    
    SELECT @nameExists = inviteeName 
      FROM eventInvitees
      WHERE inviteeName = @name AND
            eventID = @eventID
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN addInvitee
      RETURN @lastError
    END
    
    IF @nameExists = @name
    BEGIN
      ROLLBACK TRAN addInvitee
      RETURN 20003
    END
    
    /* Add this event invited guest to the table */
    INSERT INTO eventInvitees 
        ( eventID, inviteeName, regMode)
      VALUES ( @eventID, @name, @regMode )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN addInvitee
      RETURN @lastError
    END
    
  COMMIT TRAN addInvitee
    
END

go
IF OBJECT_ID('dbo.addInvitee') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.addInvitee >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.addInvitee >>>'
go

/* Adds a user vote selection to the userVotes table */
/* input:  eventId, vote option id, user name. 
   output: error codes:
           - 20001: Vote not active,
           - 20002: Invalid option id,
           - 20003: Too many options selected,
*/
CREATE PROC addUserVote
(
  @voteID		numeric(10,0),
  @optionID		integer,
  @userName             VPuserID = NULL
)
AS
BEGIN
  DECLARE @diffFromGMT int
  DECLARE @currentDate VpTime
  DECLARE @numChoices  int
  DECLARE @lastSelection int
  DECLARE @lastError   int
  DECLARE @status      int

  /* Get the event's active vote id */
  SELECT @status = status, @numChoices = numChoices 
    FROM eventVotes
    WHERE voteID = @voteID 
  SELECT @lastError = @@error
  IF @lastError != 0
    RETURN @lastError
 
  IF @status != 1 
    return 20001	/* Vote not active */
  
  /* Check that the option is valid */
  SELECT optionID 
    FROM voteOptions
    WHERE voteID = @voteID AND
          optionID = @optionID
  IF @@rowCount = 0 
    RETURN 20002    /* Invalid option id */
  SELECT @lastError = @@error
  IF @lastError != 0
    RETURN @lastError
  
  /* Check that this user, if identified, has not already voted */ 
  IF @userName IS NOT NULL
  BEGIN
    SELECT @lastSelection = optionID
      FROM userVotes
      WHERE name = @userName AND
            voteID = @voteID
    IF @@rowcount >= @numChoices
      RETURN 20003	/* Too many options selected */
    SELECT @lastError = @@error
    IF @lastError != 0
      RETURN @lastError
  END

  SELECT @diffFromGMT = gmt
  FROM vpusers..getGMT
    
  SELECT @lastError = @@error
  IF @lastError != 0
    RETURN @lastError
    
  /* Add this user vote to the table */
  INSERT INTO userVotes 
      ( voteID, optionID, name, time)
    VALUES ( @voteID, @optionID, @userName, 
 	     dateadd( hour, (-1) * @diffFromGMT, getdate() ) )
    
END

go
IF OBJECT_ID('dbo.addUserVote') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.addUserVote >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.addUserVote >>>'
go

/* Adds an event vote option to the voteOptions table */
/* input:  voteId, vote option, vote option description. 
   output: Errors: 
            - 20001: Vote is active, cannot delete options
            - 20002: Vote has already 10 vote options.
*/
CREATE PROC addVoteOption
(
  @voteID		numeric(10,0),
  @option		varchar(10),
  @description          varchar(50)
)
AS
BEGIN
  DECLARE @lastOptionID int
  DECLARE @lastError    int
  DECLARE @status int

  BEGIN TRAN
  /* Check that vote is not active */
  SELECT @status = status
    FROM eventVotes
    WHERE voteID = @voteID
  SELECT @lastError = @@error
  IF @lastError != 0
  BEGIN
    ROLLBACK TRAN
    RETURN @lastError
  END 

  IF @status = 1 
  BEGIN
    ROLLBACK TRAN
    RETURN 20001   /* Vote is active, cannot delete options */
  END 

  /* Get the last option id used for this vote */
  SELECT @lastOptionID = max(optionID)
    FROM voteOptions
    WHERE voteID = @voteID
  SELECT @lastError = @@error
  IF @lastError != 0 
  BEGIN
    ROLLBACK TRAN
    RETURN @lastError
  END

  /* Set this option id to the next available id, up to 10 */
  IF @lastOptionID IS NULL 
    SELECT @lastOptionID = 1
  ELSE
  BEGIN
    IF @lastOptionID >= 10 
    BEGIN
      ROLLBACK TRAN
      RETURN 20002
    END

    SELECT @lastOptionID = @lastOptionID + 1
  END

  /* Add this option to the table */
  INSERT INTO voteOptions 
      ( voteID, optionID, label, description, totalSelections)
    VALUES ( @voteID, @lastOptionID, @option, @description, 0)
  SELECT @lastError = @@error
  IF @lastError != 0 
  BEGIN
    ROLLBACK TRAN
    RETURN @lastError
  END
  
  COMMIT TRAN    
END

go
IF OBJECT_ID('dbo.addVoteOption') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.addVoteOption >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.addVoteOption >>>'
go

CREATE PROCEDURE autobackup
AS
BEGIN
  DUMP TRAN audset WITH TRUNCATE_ONLY
END
go
IF OBJECT_ID('dbo.autobackup') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.autobackup >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.autobackup >>>'
go

/* --- Block/UnBlock all interactions
       for a given event and interaction type,
*/
/* input:  event id, interactionTypes, block flag (1= block, 0=unblock)
   output: error 20001 if too many interaction types are given.
*/
CREATE PROC blockInteractions
(
  @eventID		numeric(10,0),
  @interactionTypes	longName,
  @blockFlag		bit
)
AS
BEGIN
/* Get Interaction Types requested ... */
/* ------------------------------------*/
DECLARE @iType    integer
DECLARE @iType1   integer
DECLARE @iType2   integer 
DECLARE @iType3   integer 
DECLARE @iType4   integer 
DECLARE @iType5   integer 
DECLARE @iType6   integer 
DECLARE @counter  integer
DECLARE @commaPos integer
DECLARE @IName    varchar(16)
DECLARE @lastError integer

/* Parse list of interaction types */
/* --------------------------------*/
SELECT @counter = 1
WHILE ( ascii( rtrim(ltrim(@interactionTypes))) > 32 )
BEGIN
  SELECT @commaPos = patindex( "%,%", @interactionTypes )
  IF @commaPos = 0 BEGIN
    /* Last Interaction Type in list */
    SELECT @IName = rtrim(ltrim(@interactionTypes))
    SELECT @interactionTypes = ""
  END
  ELSE BEGIN
    SELECT @IName = rtrim( ltrim( substring( @interactionTypes, 1, @commaPos-1)) )
    SELECT @interactionTypes = substring( @interactionTypes, 
                                          @commaPos+1, 
                                          char_length( @interactionTypes ) - @commaPos )
  END

  /* Get the Interaction Type for the current Interaction Name */
  SELECT @iType = interactionType
  FROM interactionsAllowed
  WHERE eventID = @eventID AND 
        name = @IName
  SELECT @lastError = @@error
  IF @lastError != 0
  BEGIN
    RAISERROR @lastError
    RETURN @lastError
  END
  
  IF @counter = 1 
     SELECT @iType1 = @iType
  ELSE IF @counter = 2 
     SELECT @iType2 = @iType
  ELSE IF @counter = 3 
     SELECT @iType3 = @iType
  ELSE IF @counter = 4 
     SELECT @iType4 = @iType
  ELSE IF @counter = 5 
     SELECT @iType5 = @iType
  ELSE IF @counter = 6 
     SELECT @iType6 = @iType
  ELSE 
    RETURN 20001 /* Too many Interaction Types */

  SELECT @counter = @counter + 1

END /* of while */

/* Set zero in unused iTypes variables */
WHILE @counter <= 6
BEGIN
  IF @counter = 1 
     SELECT @iType1 = 0
   ELSE IF @counter = 2 
     SELECT @iType2 = 0
  ELSE IF @counter = 3 
     SELECT @iType3 = 0
  ELSE IF @counter = 4 
     SELECT @iType4 = 0
  ELSE IF @counter = 5 
     SELECT @iType5 = 0
  ELSE IF @counter = 6 
     SELECT @iType6 = 0
  SELECT @counter = @counter + 1
END

/* Now block/unblock appropriate interactions */
  UPDATE interactionsAllowed
    SET interactBlocked = @blockFlag
    WHERE eventID = @eventID AND
        interactionType IN(@iType1, @iType2, @iType3, @iType4, @iType5, @iType6)
 
END

go
IF OBJECT_ID('dbo.blockInteractions') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.blockInteractions >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.blockInteractions >>>'
go

/* Change the current status of a set of guest answers and associated interactions */
/* input:  interactions list - ids separated by commas,
           new status - id for status "DELETED" or "BROADCASTED"
           host name - name of host 
   output: If the new status is BROADCASTED, then the interactions/answers 
           for which the status is been changed are returned with the following columns:
           interaction type, sender name, interaction text, guest name, answer text.
           Returns 20001 if the new status is not DELETED or BROADCASTED,
           0 otherwise.
*/
CREATE PROC changeAnswerStatus( 
               @interactions  longName,
               @newStatus     numeric(2,0) ,
               @hostName      VPuserID      )
AS
BEGIN
  DECLARE @newStatusName varchar(16)
  DECLARE @lastError   integer
  DECLARE @id varchar(15)
  DECLARE @commaPos integer
  DECLARE @broadcasted integer
  DECLARE @saveInter integer
  DECLARE @iType varchar(16)
  DECLARE @sender VPuserID
  DECLARE @iText longName
  DECLARE @guest VPuserID
  DECLARE @answer longName

  SELECT @newStatusName = name
  FROM interactionStatus
  WHERE statusID = @newStatus
  SELECT @lastError = @@error
  IF @lastError != 0
  BEGIN
    RAISERROR @lastError
    RETURN @lastError
  END

  IF @newStatusName != "DELETED" AND @newStatusName != "BROADCASTED"
    RETURN 20001
 
  CREATE TABLE #answers ( id numeric(10,0), itype varchar(16), 
                          sender varchar(20), text varchar(255), guest varchar(20), answer varchar(255) )
 
  SELECT @broadcasted = statusID 
    FROM interactionStatus
    WHERE name = "BROADCASTED"
  SELECT @lastError = @@error
  IF @lastError != 0
     RETURN @lastError

  IF  (@newStatus = @broadcasted)
    SELECT @saveInter = 1
  ELSE
    SELECT @saveInter = 0
     
  BEGIN TRAN changeStatus
  /* parse list of interaction ids */
  WHILE ( ascii( rtrim(ltrim(@interactions ))) > 32 ) BEGIN
    SELECT @commaPos = patindex( "%,%", @interactions )
    IF @commaPos = 0 BEGIN
      SELECT @id = rtrim(ltrim(@interactions))
      SELECT @interactions = ""
    END
    ELSE BEGIN
      SELECT @id = rtrim( ltrim( substring( @interactions, 1, @commaPos-1 ) ) )
      SELECT @interactions = substring( @interactions, @commaPos+1, 
                                        char_length( @interactions ) - @commaPos )
    END
  
    UPDATE eventInteractions 
    SET status = @newStatus, hostName = @hostName
    FROM eventInteractions ( INDEX isPrimary )
    WHERE interactionID = convert(numeric(10,0),@id)  
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN changeStatus
      RETURN @lastError
    END

    UPDATE answers
    SET status = @newStatus, hostName = @hostName
    WHERE interactionID = convert(numeric(10,0),@id) 
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN changeStatus
      RETURN @lastError
    END

    /* Status is Broadcast, save the interaction/answer in a temporary table */
    IF @saveInter = 1 
    BEGIN 
      SELECT @iType = name, @sender = eventInteractions.senderName, @iText = eventInteractions.text, 
             @guest = answers.senderName, @answer = answers.text 
      FROM eventInteractions ( INDEX isPrimary ), interactionsAllowed, answers
      WHERE eventInteractions.interactionID = convert(numeric(10,0),@id) AND
            answers.interactionID = convert(numeric(10,0),@id) AND
            interactionsAllowed.eventID = eventInteractions.eventID AND
            interactionsAllowed.interactionType = eventInteractions.interactionType 
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRAN
        RETURN @lastError
      END
  
      INSERT #answers 
       ( id, itype, sender, text, guest, answer)
      VALUES ( convert(numeric(10,0),@id) , @iType, @sender, @iText, @guest, @answer)
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRAN
        RETURN @lastError
      END
    END

  END /* of while */

  IF @saveInter = 1
  BEGIN
    SELECT * FROM #answers
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
  END
  
  COMMIT TRAN changeStatus
END

go
IF OBJECT_ID('dbo.changeAnswerStatus') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.changeAnswerStatus >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.changeAnswerStatus >>>'
go

/* Change the current status of a set of event interactions */
/* input:  interactions list - ids separated by commas, 
           new status - id for one of the statuses "DELETED","BROADCASTED","FORWARDED",
                        "ATGUEST","READY" or "IDLE",
           host name - name of host or guest if new status is "ATGUEST"
   output: If the new status is BROADCASTED or ATGUEST, then the interactions 
           for which the status is been changed are returned with the following columns:
           interaction id, interaction type, sender name, text.
           RETURNS 20001 if status is not in range 1..7, 
                   20002 if the host given when forwarding is not a host, 
                   0 otherwise.
   16/06/97: Fix: when new status is FORWARDED, checks that the hostName 
             has the appropriate privilege.
*/
CREATE PROC changeInteractionStatus( 
               @interactions  longName,
               @newStatus     numeric(2,0) ,
               @hostName      VPuserID      )
AS
BEGIN
  DECLARE @id varchar(15)
  DECLARE @commaPos integer
  DECLARE @lastError integer
  DECLARE @atguest integer
  DECLARE @broadcasted integer
  DECLARE @forwarded integer
  DECLARE @saveInter integer
  DECLARE @iType varchar(16)
  DECLARE @sender VPuserID
  DECLARE @text longName

  CREATE TABLE #interactions ( id numeric(10,0), itype varchar(16), sender varchar(20), text varchar(255) )

  IF @newStatus < 1 OR @newStatus > 7 
     RETURN 20001

  SELECT @atguest = statusID 
    FROM interactionStatus
    WHERE name = "ATGUEST"
  SELECT @lastError = @@error
  IF @lastError != 0
    RETURN @lastError

  SELECT @broadcasted = statusID 
    FROM interactionStatus
    WHERE name = "BROADCASTED"
  SELECT @lastError = @@error
  IF @lastError != 0
     RETURN @lastError

  SELECT @forwarded = statusID 
    FROM interactionStatus
    WHERE name = "FORWARDED"
  SELECT @lastError = @@error
  IF @lastError != 0
     RETURN @lastError

  IF  (@newStatus = @atguest) OR (@newStatus = @broadcasted)
    SELECT @saveInter = 1
  ELSE
    SELECT @saveInter = 0
     
  IF (@newStatus = @forwarded) 
  BEGIN
    DECLARE @hostPriv  privType 
    DECLARE @isHost    int
    SELECT @hostPriv = 273
    EXEC vpusers..isPrivileged @hostName, @hostPriv, @isHost output
    IF @isHost = 0 
      RETURN 20002
  END

  BEGIN TRAN
  /* parse list of interaction ids */
  WHILE ( ascii( rtrim(ltrim(@interactions ))) > 32 ) BEGIN
    SELECT @commaPos = patindex( "%,%", @interactions )
    IF @commaPos = 0 BEGIN
      SELECT @id = rtrim(ltrim(@interactions))
      SELECT @interactions = ""
    END
    ELSE BEGIN
      SELECT @id = rtrim( ltrim( substring( @interactions, 1, @commaPos-1 ) ) )
      SELECT @interactions = substring( @interactions, @commaPos+1, 
                                        char_length( @interactions ) - @commaPos )
    END
  
    UPDATE eventInteractions
      SET status = @newStatus, hostName = @hostName
      FROM eventInteractions ( INDEX isPrimary )
      WHERE interactionID = convert(numeric(10,0),@id)  
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
        ROLLBACK TRAN
        RETURN @lastError
    END
    
    IF @saveInter = 1 
    BEGIN 
      SELECT @iType = name, @sender = senderName, @text = text
      FROM eventInteractions ( INDEX isPrimary ), interactionsAllowed
      WHERE interactionID = convert(numeric(10,0),@id) AND
            interactionsAllowed.interactionType = eventInteractions.interactionType
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRAN
        RETURN @lastError
      END
  
      INSERT #interactions 
       ( id, itype,sender, text)
      VALUES ( convert(numeric(10,0),@id) , @iType, @sender, @text )
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRAN
        RETURN @lastError
      END
    END

  END /* of while */

  IF @saveInter = 1
  BEGIN
    SELECT * FROM #interactions
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
  END
  
  COMMIT TRAN
  
  DROP TABLE #interactions

END

go
IF OBJECT_ID('dbo.changeInteractionStatus') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.changeInteractionStatus >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.changeInteractionStatus >>>'
go

/* start or stop a given vote  */
/* input:  vote ID, status ( 1 = start, 2 = over )
   output: error values - 
            20001: status unchanged,
            20002: another vote is active for this event,
                           
*/
CREATE PROC changeVoteStatus(
        @voteID 	numeric(10,0),
        @status	 	int
)
AS
BEGIN

  DECLARE @currentStatus int
  DECLARE @eventID       eventIdentifier
  DECLARE @otherVote     numeric(10,0)
  DECLARE @lastError	 int

  SELECT @currentStatus = status
    FROM eventVotes
    WHERE voteID = @voteID
  SELECT @lastError = @@error
  IF @lastError != 0
    RETURN @lastError

  IF @status = @currentStatus
    RETURN 20001

  IF @status = 1 /* start vote */
  BEGIN
    SELECT @eventID = eventID
      FROM eventVotes
      WHERE eventVotes.voteID = @voteID
    SELECT @lastError = @@error
    IF @lastError != 0
      RETURN @lastError

    SELECT @otherVote = voteID
      FROM eventVotes
      WHERE eventID = @eventID AND status = 1
    SELECT @lastError = @@error
    IF @lastError != 0
      RETURN @lastError

    IF @otherVote IS NOT NULL
      RETURN 20002	/* Another vote is active for this event */
  END

  UPDATE eventVotes
   SET status = @status
   WHERE voteID = @voteID

  SELECT @status

END

go
IF OBJECT_ID('dbo.changeVoteStatus') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.changeVoteStatus >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.changeVoteStatus >>>'
go

/* delete all records from the auditorium changes table */
/* input:  NONE
   output: NONE
*/
CREATE PROC clearAuditoriumChanges
AS
BEGIN
  DELETE FROM auditoriumChanges
END

go
IF OBJECT_ID('dbo.clearAuditoriumChanges') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.clearAuditoriumChanges >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.clearAuditoriumChanges >>>'
go

/* Clear from database all records for all auditoriums */
CREATE PROC clearAuditoriums
AS
BEGIN
  
  /* delete events and tables depending on events */
  EXEC clearEvents

  TRUNCATE TABLE auditoriums
END

go
IF OBJECT_ID('dbo.clearAuditoriums') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.clearAuditoriums >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.clearAuditoriums >>>'
go

/* delete all records from the event changes table */
/* input:  NONE
   output: NONE
*/
CREATE PROC clearEventChanges
AS
BEGIN
  BEGIN TRAN

  DELETE FROM eventChanges

  COMMIT TRAN
END

go
IF OBJECT_ID('dbo.clearEventChanges') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.clearEventChanges >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.clearEventChanges >>>'
go

/* Clear from database all records for all events */
CREATE PROC clearEvents
AS
BEGIN
  
  /* tables depending on eventVotes */
  TRUNCATE TABLE userVotes
  TRUNCATE TABLE voteOptions
  
  /* tables depending on eventInteractions */
  TRUNCATE TABLE answers
  
  /* tables depending on events */
  TRUNCATE TABLE interactionsAllowed
  TRUNCATE TABLE eventInteractions
  TRUNCATE TABLE hosts
  TRUNCATE TABLE eventInvitees
  TRUNCATE TABLE eventState
  
  TRUNCATE TABLE events
END

go
IF OBJECT_ID('dbo.clearEvents') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.clearEvents >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.clearEvents >>>'
go

/* --- Clear, for a given event and interaction type,
       all the interactions of that type that are 
       in the eventInteractions table.
*/
/* input:  event id, interactionType
   output: error 20001 if too many interaction types are given.
   21/07/97: Fix - clear only answers for THIS event!
*/
CREATE PROC clearInteractions
(
  @eventID		numeric(10,0),
  @interactionTypes	longName
)
AS
BEGIN
/* Get Interaction Types requested ... */
/* ------------------------------------*/
DECLARE @iType    integer
DECLARE @iType1   integer
DECLARE @iType2   integer 
DECLARE @iType3   integer 
DECLARE @iType4   integer 
DECLARE @iType5   integer 
DECLARE @iType6   integer 
DECLARE @counter  integer
DECLARE @commaPos integer
DECLARE @IName    varchar(16)
DECLARE @lastError integer

/* Parse list of interaction types */
/* --------------------------------*/
SELECT @counter = 1
WHILE ( ascii( rtrim(ltrim(@interactionTypes))) > 32 )
BEGIN
  SELECT @commaPos = patindex( "%,%", @interactionTypes )
  IF @commaPos = 0 BEGIN
    /* Last Interaction Type in list */
    SELECT @IName = rtrim(ltrim(@interactionTypes))
    SELECT @interactionTypes = ""
  END
  ELSE BEGIN
    SELECT @IName = rtrim( ltrim( substring( @interactionTypes, 1, @commaPos-1)) )
    SELECT @interactionTypes = substring( @interactionTypes, 
                                          @commaPos+1, 
                                          char_length( @interactionTypes ) - @commaPos )
  END

  /* Get the Interaction Type for the current Interaction Name */
  SELECT @iType = interactionType
  FROM interactionsAllowed
  WHERE eventID = @eventID AND 
        name = @IName
  SELECT @lastError = @@error
  IF @lastError != 0
  BEGIN
    RAISERROR @lastError
    RETURN @lastError
  END
  
  IF @counter = 1 
     SELECT @iType1 = @iType
  ELSE IF @counter = 2 
     SELECT @iType2 = @iType
  ELSE IF @counter = 3 
     SELECT @iType3 = @iType
  ELSE IF @counter = 4 
     SELECT @iType4 = @iType
  ELSE IF @counter = 5 
     SELECT @iType5 = @iType
  ELSE IF @counter = 6 
     SELECT @iType6 = @iType
  ELSE 
    RETURN 20001 /* Too many Interaction Types */

  SELECT @counter = @counter + 1

END /* of while */

/* Set zero in unused iTypes variables */
WHILE @counter <= 6
BEGIN
  IF @counter = 1 
     SELECT @iType1 = 0
   ELSE IF @counter = 2 
     SELECT @iType2 = 0
  ELSE IF @counter = 3 
     SELECT @iType3 = 0
  ELSE IF @counter = 4 
     SELECT @iType4 = 0
  ELSE IF @counter = 5 
     SELECT @iType5 = 0
  ELSE IF @counter = 6 
     SELECT @iType6 = 0
  SELECT @counter = @counter + 1
END

/* Now delete appropriate interactions */
BEGIN TRAN clearInteractions
  DELETE answers
  WHERE interactionID IN 
    (SELECT interactionID 
     FROM eventInteractions ( INDEX interactionsByEventIdx )
     WHERE eventID = @eventID AND
           interactionType IN (@iType1, @iType2, @iType3, @iType4, @iType5, @iType6))
  SELECT @lastError = @@error
  IF @lastError != 0
  BEGIN
    ROLLBACK TRAN clearInteractions
    RAISERROR @lastError
    RETURN @lastError
  END
  
  DELETE eventInteractions
  FROM eventInteractions ( INDEX interactionsByEventIdx )
  WHERE eventID = @eventID AND
        interactionType IN(@iType1, @iType2, @iType3, @iType4, @iType5, @iType6)
  SELECT @lastError = @@error
  IF @lastError != 0
  BEGIN
    ROLLBACK TRAN clearInteractions
    RAISERROR @lastError
    RETURN @lastError
  END
COMMIT TRAN clearInteractions

END

go
IF OBJECT_ID('dbo.clearInteractions') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.clearInteractions >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.clearInteractions >>>'
go

/* --- Clear, for a given event and interaction type,
       all the interactions of that type that are 
       in the eventInteractions table.
*/
/* input:  event id, interactionType
   output: error 20001 if too many interaction types are given.
*/
CREATE PROC clearNewInteractions
(
  @eventID		numeric(10,0),
  @interactionTypes	longName
)
AS
BEGIN
/* Get Interaction Types requested ... */
/* ------------------------------------*/
DECLARE @iType    integer
DECLARE @iType1   integer
DECLARE @iType2   integer 
DECLARE @iType3   integer 
DECLARE @iType4   integer 
DECLARE @iType5   integer 
DECLARE @iType6   integer 
DECLARE @counter  integer
DECLARE @commaPos integer
DECLARE @IName    varchar(16)
DECLARE @lastError integer
DECLARE @ready    integer
DECLARE @atGuest  integer

/* Parse list of interaction types */
/* --------------------------------*/
SELECT @counter = 1
WHILE ( ascii( rtrim(ltrim(@interactionTypes))) > 32 )
BEGIN
  SELECT @commaPos = patindex( "%,%", @interactionTypes )
  IF @commaPos = 0 BEGIN
    /* Last Interaction Type in list */
    SELECT @IName = rtrim(ltrim(@interactionTypes))
    SELECT @interactionTypes = ""
  END
  ELSE BEGIN
    SELECT @IName = rtrim( ltrim( substring( @interactionTypes, 1, @commaPos-1)) )
    SELECT @interactionTypes = substring( @interactionTypes, 
                                          @commaPos+1, 
                                          char_length( @interactionTypes ) - @commaPos )
  END

  /* Get the Interaction Type for the current Interaction Name */
  SELECT @iType = interactionType
  FROM interactionsAllowed
  WHERE eventID = @eventID AND 
        name = @IName
  SELECT @lastError = @@error
  IF @lastError != 0
  BEGIN
    RAISERROR @lastError
    RETURN @lastError
  END
  
  IF @counter = 1 
     SELECT @iType1 = @iType
  ELSE IF @counter = 2 
     SELECT @iType2 = @iType
  ELSE IF @counter = 3 
     SELECT @iType3 = @iType
  ELSE IF @counter = 4 
     SELECT @iType4 = @iType
  ELSE IF @counter = 5 
     SELECT @iType5 = @iType
  ELSE IF @counter = 6 
     SELECT @iType6 = @iType
  ELSE 
    RETURN 20001 /* Too many Interaction Types */

  SELECT @counter = @counter + 1

END /* of while */

/* Set zero in unused iTypes variables */
WHILE @counter <= 6
BEGIN
  IF @counter = 1 
     SELECT @iType1 = 0
   ELSE IF @counter = 2 
     SELECT @iType2 = 0
  ELSE IF @counter = 3 
     SELECT @iType3 = 0
  ELSE IF @counter = 4 
     SELECT @iType4 = 0
  ELSE IF @counter = 5 
     SELECT @iType5 = 0
  ELSE IF @counter = 6 
     SELECT @iType6 = 0
  SELECT @counter = @counter + 1
END

/* Now delete appropriate interactions */
SELECT @ready = statusID
  FROM interactionStatus
  WHERE name = "READY"
SELECT @lastError = @@error
  IF @lastError != 0
    RETURN @lastError

SELECT @atGuest = statusID
  FROM interactionStatus
  WHERE name = "ATGUEST"
SELECT @lastError = @@error
  IF @lastError != 0
    RETURN @lastError

BEGIN TRAN clearInteractions
  DELETE eventInteractions
  FROM eventInteractions ( INDEX interactionsByEventIdx )
  WHERE eventID = @eventID AND
        status != @ready AND
        status != @atGuest AND
        interactionType IN(@iType1, @iType2, @iType3, @iType4, @iType5, @iType6)
  SELECT @lastError = @@error
  IF @lastError != 0
  BEGIN
    ROLLBACK TRAN clearInteractions
    RAISERROR @lastError
    RETURN @lastError
  END
COMMIT TRAN clearInteractions

END

go
IF OBJECT_ID('dbo.clearNewInteractions') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.clearNewInteractions >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.clearNewInteractions >>>'
go

/* Delete events older then the number of days
   we must keep them. Deletes records from the
   event table, other tables are cleaned up via
   a trigger */
CREATE PROCEDURE clearOldEvents
(
  @daysToKeep int
)
AS
BEGIN
  DECLARE @lastError  int
  DECLARE @diffFromGMT int
  DECLARE @currentDate VpTime
  DECLARE @deleteBeforeDate VpTime
  SELECT @diffFromGMT = gmt
    FROM vpusers..getGMT
  SELECT @lastError = @@error
  IF @lastError != 0
    RETURN @lastError
  IF @diffFromGMT IS NULL
    SELECT @diffFromGMT = 0
  SELECT @currentDate = dateadd( hour, (-1) * @diffFromGMT, getdate() )
  SELECT @deleteBeforeDate = dateadd( day, (-1) * @daysToKeep, @currentDate )
  DELETE events
    WHERE date <= @deleteBeforeDate
END

go
IF OBJECT_ID('dbo.clearOldEvents') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.clearOldEvents >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.clearOldEvents >>>'
go

/* delete an auditorium -
   related data will be deleted through the 
   delAuditoriumData trigger. Also, add a record in the auditorium
   changes table. */
/* input:  auditorium id
   output: name, client name, background, title,
   welcome message, show on PTG flag, row size, # of rows
*/
CREATE PROC delAuditorium ( @auditoriumID numeric(6,0) )
AS
BEGIN
  DECLARE @audURL    longName
  DECLARE @lastError int 
  BEGIN TRAN
    SELECT @audURL = background
      FROM auditoriums
      WHERE auditoriumID = @auditoriumID
    SELECT @lastError = @@error
    IF @lastError != 0 
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END

    EXEC vpplaces..delPersistentPlace @audURL
    SELECT @lastError = @@error
    IF @lastError != 0 
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END

    DELETE auditoriums
      WHERE auditoriumID = @auditoriumID
    SELECT @lastError = @@error
    IF @lastError != 0 
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
  
    INSERT auditoriumChanges
      VALUES ( @auditoriumID, -1 )
    SELECT @lastError = @@error
    IF @lastError != 0 
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
  COMMIT TRAN
  
END

go
IF OBJECT_ID('dbo.delAuditorium') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.delAuditorium >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.delAuditorium >>>'
go

/* Delete a duplicate auditorium -
   related data will be deleted through the 
   delAuditoriumData trigger. 
   Used by audset after canonicalization of the URL.. if the URL
   is already used, the auditorium is deleted.
*/
/* input:  auditorium id
   output: None
*/
CREATE PROC delDuplAud ( @audID numeric(6,0) )
AS
BEGIN
  DECLARE @lastError int 
  BEGIN TRAN
    DELETE auditoriums
      WHERE auditoriumID = @audID
    SELECT @lastError = @@error
    IF @lastError != 0 
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
  COMMIT TRAN
  
END

go
IF OBJECT_ID('dbo.delDuplAud') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.delDuplAud >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.delDuplAud >>>'
go

/* delete an event from the database, with all related data */
/* NOTE: event must NOT be active */
/* input:  event id
   output: error 20001 if event is active
*/
CREATE PROC delEvent ( @eventID numeric(10,0) )
AS
BEGIN
  DECLARE @currentState integer
  BEGIN TRAN
    SELECT @currentState = currentState
      FROM events
      WHERE eventID = @eventID
    
    IF ( @currentState IS NOT NULL ) AND
       ( @currentState <> 3 ) AND ( @currentState <> 0 )
    BEGIN
      /* can't delete active event */
      ROLLBACK TRAN
      RETURN 20001
    END

    /* NOTE: deletion of event will fire a trigger
             that will delete related data */
    DELETE events
      WHERE eventID = @eventID

  COMMIT TRAN
END

go
IF OBJECT_ID('dbo.delEvent') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.delEvent >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.delEvent >>>'
go

/* Deletes all user votes from the userVotes table (at the end of an event).
   Keeps the totals in the voteOptions table. */
/* input:  eventID. 
   output: None
*/
CREATE PROC delEventUserVotes
(
  @eventID		numeric(6,0)
)
AS
BEGIN
  DECLARE @lastError int
  DECLARE @voteID numeric(10,0)

  BEGIN TRAN
 
  DECLARE eventVotesC CURSOR
  FOR 
  SELECT voteID 
    FROM eventVotes
    WHERE eventID = @eventID
  SELECT @lastError = @@error
  IF @lastError != 0
  BEGIN
    ROLLBACK TRAN
    RETURN @lastError
  END
 
  OPEN eventVotesC
  FETCH eventVotesC INTO @voteID
  WHILE ( @@sqlstatus = 0 ) 
  BEGIN
    EXEC delUserVotes @voteID
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
    FETCH eventVotesC INTO @voteID
  END
  CLOSE eventVotesC
  
  COMMIT TRAN  
END

go
IF OBJECT_ID('dbo.delEventUserVotes') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.delEventUserVotes >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.delEventUserVotes >>>'
go

/* Deletes an event vote from the eventVotes tables. A trigger will
   delete associated information in the voteOptions and userVotes tables*/
/* input:  voteId. 
   output: NONE
*/
CREATE PROC delEventVote
(
  @voteID	numeric(10,0)
)
AS

  DELETE eventVotes 
    WHERE voteID = @voteID
   

go
IF OBJECT_ID('dbo.delEventVote') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.delEventVote >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.delEventVote >>>'
go

/* Deletes an invited guest from the invitees table */
/* input:  eventId, invited guest name, registration mode 
   output: none
*/
CREATE PROC delInvitee
(
  @eventID		eventIdentifier,
  @name             	VPuserID,
  @regMode		VpRegMode
)
AS
BEGIN
  /* Delete given invited guest from the table */
  DELETE eventInvitees 
  WHERE eventID = @eventID AND inviteeName = @name AND regMode = @regMode
    
END

go
IF OBJECT_ID('dbo.delInvitee') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.delInvitee >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.delInvitee >>>'
go

/* Deletes all user votes from the userVotes table (at the end of an event).
   Keeps the totals in the voteOptions table. */
/* input:  voteID. 
   output: None
*/
CREATE PROC delUserVotes
(
  @voteID		numeric(10,0)
)
AS
BEGIN
  DECLARE @total int
  DECLARE @optionID int
  DECLARE @lastError int
 
  DECLARE voteOptionsCursor CURSOR
  FOR 
  SELECT optionID 
    FROM voteOptions
    WHERE voteID = @voteID
  FOR UPDATE 
  SELECT @lastError = @@error
  IF @lastError != 0
  BEGIN
    ROLLBACK TRAN
    RETURN @lastError
  END
 
  OPEN voteOptionsCursor
  FETCH voteOptionsCursor INTO @optionID
  WHILE ( @@sqlstatus = 0 ) 
  BEGIN
    SELECT @total = count(*)
      FROM userVotes
      WHERE voteID = @voteID AND
            optionID = @optionID
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END

    /* Set the total number of user votes */
    UPDATE voteOptions
      SET totalSelections = @total
      WHERE CURRENT OF voteOptionsCursor
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
    FETCH voteOptionsCursor INTO @optionID
  END
  CLOSE voteOptionsCursor
  
  DELETE userVotes
  WHERE voteID = @voteID
  SELECT @lastError = @@error
  IF @lastError != 0
  BEGIN
    ROLLBACK TRAN
    RETURN @lastError
  END

END

go
IF OBJECT_ID('dbo.delUserVotes') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.delUserVotes >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.delUserVotes >>>'
go

/* Deletes an event vote option from the voteOptions table */
/* input:  voteId, vote option id 
   output: Errors:
           - 20001: Vote is active, cannot delete options,
*/
CREATE PROC delVoteOption
(
  @voteID		numeric(10,0),
  @voteOptionID		integer
)
AS
BEGIN
  DECLARE @status int
  DECLARE @lastError int

  BEGIN TRAN
  /* Check that vote is not active */
  SELECT @status = status
    FROM eventVotes
    WHERE voteID = @voteID
  SELECT @lastError = @@error
  IF @lastError != 0
  BEGIN
    ROLLBACK TRAN
    RETURN @lastError
  END 

  IF @status = 1 
  BEGIN
    ROLLBACK TRAN
    RETURN 20001   /* Vote is active, cannot delete options */
  END 

  /* Delete this option from the table */
  DELETE voteOptions 
    WHERE voteID = @voteID AND optionID = @voteOptionID
  SELECT @lastError = @@error
  IF @lastError != 0
  BEGIN
    ROLLBACK TRAN
    RETURN @lastError
  END 
 
  /* Option Ids should always be in the range 1..num of options */
  UPDATE voteOptions
    SET optionID = optionID - 1
    WHERE voteID = @voteID AND
          optionID > @voteOptionID   
  SELECT @lastError = @@error
  IF @lastError != 0
  BEGIN
    ROLLBACK TRAN
    RETURN @lastError
  END 

  COMMIT TRAN

END

go
IF OBJECT_ID('dbo.delVoteOption') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.delVoteOption >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.delVoteOption >>>'
go

/* Edit the details of one event interaction */
/* input:  interaction id, text, category
   output: None
*/
CREATE PROC editInteraction( 
               @interactionID numeric(10,0),
               @text	      longName,
               @category      varchar(16) )
AS
BEGIN
    UPDATE eventInteractions
    SET text = @text, category = @category
    FROM eventInteractions ( INDEX primaryKey )
    WHERE interactionID = @interactionID
END

go
IF OBJECT_ID('dbo.editInteraction') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.editInteraction >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.editInteraction >>>'
go

/* get details of all events that are active right now */
/* input:  NONE
   output: list of events, stating for each event -
   event id, auditorium name, stage URL, 
   current state, current state welcome msg, state title
   NOTE: ACTIVE events are defined by being at OPEN state or
   at STARTED state.
*/
CREATE PROC getActiveEvents
AS
  SELECT 
	events.eventID, events.auditorium, stageBackground,
        events.currentState, correctStates.stateID AS correctState,
        eventState.welcomeMsg1, eventState.welcomeMsg2, 
        eventState.PTGtitle
    FROM events, eventState, correctStates
    WHERE events.eventID = eventState.eventID AND
          events.currentState = eventState.stateID AND
          events.eventID = correctStates.eventID AND
	  events.currentState IN (1,2)

go
IF OBJECT_ID('dbo.getActiveEvents') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getActiveEvents >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getActiveEvents >>>'
go

/* get details of all auditoriums */
/* input:  NONE
   output: list of auditoriums, stating -
   id, name, URL, default title, 
   default welcome msg, row size, number of rows,
   stage capacity
*/
CREATE PROC getAllAuditoriums
AS
BEGIN
  SELECT auditoriumID, name, background, title,
         welcomeMsg1, welcomeMsg2, rowSize,
         numberOfRows, stageCapacity
    FROM auditoriums
    ORDER BY name
END

go
IF OBJECT_ID('dbo.getAllAuditoriums') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getAllAuditoriums >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getAllAuditoriums >>>'
go

/* getAnswers - returns a list of all guest answers for the 
                     requested event. 
   Inputs - eventId: id of the event for which to get interactions/answers pairs
            orderBy: "InteractionType", "Category", "GuestName", "None"
   Output - a list of interactions/answers pairs with the following fields: 
            interaction Id, interaction type name, category, 
            sender,interaction text, guest, answer text
   Processing - scans the guest answers table, and returns the requested
                interactions/answers pairs.  
*/
CREATE PROC getAnswers (
              @eventID	 eventIdentifier,
              @orderBy varchar(20)
       )
AS
BEGIN

DECLARE @lastError integer
DECLARE @ready    integer
 
/* Get all answers which status is "READY" */
/*-----------------------------------------*/  
SELECT @ready = statusID 
FROM interactionStatus
WHERE name = "READY"
SELECT @lastError = @@error
IF @lastError != 0
BEGIN
  RAISERROR @lastError
  RETURN @lastError
END

IF @orderBy = "InteractionType"
BEGIN
  SELECT answers.interactionID, name, category, eventInteractions.senderName, eventInteractions.text, answers.senderName, answers.text
  FROM answers, eventInteractions ( INDEX isPrimary ), interactionsAllowed
  WHERE   answers.status = @ready AND 
        answers.interactionID = eventInteractions.interactionID AND
        eventInteractions.eventID = @eventID AND
        interactionsAllowed.eventID = @eventID AND
        interactionsAllowed.interactionType = eventInteractions.interactionType 
  ORDER BY name
  SELECT @lastError = @@error
  IF @lastError != 0
    RETURN @lastError
END
ELSE 
  IF @orderBy = "Category"
  BEGIN
    SELECT answers.interactionID, name, category, eventInteractions.senderName, eventInteractions.text, answers.senderName, answers.text
    FROM answers, eventInteractions ( INDEX isPrimary ), interactionsAllowed
    WHERE   answers.status = @ready AND 
        answers.interactionID = eventInteractions.interactionID AND
        eventInteractions.eventID = @eventID AND
        interactionsAllowed.eventID = @eventID AND
        interactionsAllowed.interactionType = eventInteractions.interactionType 
    ORDER BY category
    SELECT @lastError = @@error
    IF @lastError != 0
      RETURN @lastError
  END
  ELSE  
    IF @orderBy = "GuestName"
    BEGIN
      SELECT answers.interactionID, name, category, eventInteractions.senderName, eventInteractions.text, answers.senderName, answers.text
      FROM answers, eventInteractions ( INDEX isPrimary ), interactionsAllowed
      WHERE   answers.status = @ready AND 
        answers.interactionID = eventInteractions.interactionID AND
        eventInteractions.eventID = @eventID AND
        interactionsAllowed.eventID = @eventID AND
        interactionsAllowed.interactionType = eventInteractions.interactionType 
      ORDER BY answers.senderName
      SELECT @lastError = @@error
      IF @lastError != 0
        RETURN @lastError
    END
  ELSE /* No sorting */
    BEGIN
      SELECT answers.interactionID, name, category, eventInteractions.senderName, eventInteractions.text, answers.senderName, answers.text
      FROM answers, eventInteractions( INDEX isPrimary ), interactionsAllowed
      WHERE   answers.status = @ready AND 
        answers.interactionID = eventInteractions.interactionID AND
        eventInteractions.eventID = @eventID AND
        interactionsAllowed.eventID = @eventID AND
        interactionsAllowed.interactionType = eventInteractions.interactionType 
      SELECT @lastError = @@error
      IF @lastError != 0
        RETURN @lastError
    END

END

go
IF OBJECT_ID('dbo.getAnswers') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getAnswers >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getAnswers >>>'
go

/* get details for a specific auditorium:
   name, client name, background, 
   title, welcome message, show on PTG flag, 
   stage capacity, row size, # of rows */
/* input:  auditorium id
   output: name, client name, background, title,
   welcome message, show on PTG flag, 
   stage capacity, row size, # of rows
*/
CREATE PROC getAuditorium ( @auditoriumID numeric(6,0) )
AS
  SELECT name, client, background,
         title, welcomeMsg1, welcomeMsg2,
         inPlacesList, 
         stageCapacity, rowSize, numberOfRows
    FROM auditoriums
    WHERE auditoriumID = @auditoriumID

go
IF OBJECT_ID('dbo.getAuditorium') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getAuditorium >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getAuditorium >>>'
go

CREATE PROC getAuditoriumID 
(
  @background longName
)
AS
  SELECT auditoriumID
    FROM auditoriums
    WHERE @background = background

go
IF OBJECT_ID('dbo.getAuditoriumID') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getAuditoriumID >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getAuditoriumID >>>'
go

/* get welcome image for a specific auditorium */
/* input:  auditorium id
   output: image
*/
CREATE PROC getAuditoriumImage ( @auditoriumID numeric(6,0) )
AS
BEGIN
  SELECT welcomeImage
    FROM auditoriums
    WHERE auditoriumID = @auditoriumID
END

go
IF OBJECT_ID('dbo.getAuditoriumImage') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getAuditoriumImage >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getAuditoriumImage >>>'
go

/* get welcome message, title and stage URL for a specific auditorium */
/* input:  auditorium id
   output: welcome message, title and stage URL
*/
CREATE PROC getAuditoriumInfo ( @auditoriumID numeric(6,0) )
AS
BEGIN
  SELECT welcomeMsg1, welcomeMsg2, 
         title, background
    FROM auditoriums
    WHERE auditoriumID = @auditoriumID
END

go
IF OBJECT_ID('dbo.getAuditoriumInfo') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getAuditoriumInfo >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getAuditoriumInfo >>>'
go

/* get list of auditoriums, giving id, name, client, background  */
/* input:  NONE
   output: list of auditoriums, stating for each - 
           id, name, client, background
*/
CREATE PROC getAuditoriumList
AS
  SELECT auditoriumID, name, client, background
    FROM auditoriums
    ORDER BY name

go
IF OBJECT_ID('dbo.getAuditoriumList') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getAuditoriumList >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getAuditoriumList >>>'
go

/* get update notifications for latest 
   editing changes done on auditoriums */
/* input:  NONE
   output: list of auditorium changes, stating -
   auditorium id, field id
*/
CREATE PROC getAuditoriumsUpdates
AS
BEGIN
  DECLARE @lastError int
  BEGIN TRAN
    SELECT auditoriumID, fieldID
      FROM auditoriumChanges
      ORDER BY auditoriumID
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
    
    DELETE FROM auditoriumChanges
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
    
  COMMIT TRAN
END
go
IF OBJECT_ID('dbo.getAuditoriumsUpdates') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getAuditoriumsUpdates >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getAuditoriumsUpdates >>>'
go

/* get details for one event */
/* input:  event id
   output: event title, auditorium name, client name, date, 
           stage background, current state,
	   open time,  open welcome message 1, open welcome 2, open title,
	   start time,  start welcome message 1, start welcome 2, start title,
	   end time, interactions

           The output is returned in 3 result sets to simplify the SELECTs
*/
CREATE PROC getEvent ( @eventID eventIdentifier )
AS
BEGIN
  DECLARE @lastError int
  BEGIN TRAN
    
    SELECT stateID, time, welcomeMsg1, welcomeMsg2, PTGtitle
      FROM eventState
      WHERE eventID = @eventID
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
    
    SELECT name
      FROM interactionsAllowed
      WHERE eventID = @eventID
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
    
    SELECT events.title, auditoriums.name, events.client,
           date, stageBackground, currentState
      FROM events, auditoriums
      WHERE events.eventID = @eventID AND
            events.auditorium = auditoriums.auditoriumID
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
    
  COMMIT TRAN
END

go
IF OBJECT_ID('dbo.getEvent') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getEvent >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getEvent >>>'
go

/* get details for one event */
/* input:  event id
   output: event title, auditorium name
*/
CREATE PROC getEventHeader ( @eventID eventIdentifier )
AS

    SELECT events.title, auditoriums.name
      FROM events, auditoriums
      WHERE events.eventID = @eventID AND
            events.auditorium = auditoriums.auditoriumID


go
IF OBJECT_ID('dbo.getEventHeader') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getEventHeader >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getEventHeader >>>'
go

/* get welcome image for a specific event */
/* input:  event id
   output: image
*/
CREATE PROC getEventImage ( @eventID numeric(10,0) )
AS
BEGIN
  SELECT welcomeImage
    FROM events
    WHERE eventID = @eventID
END

go
IF OBJECT_ID('dbo.getEventImage') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getEventImage >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getEventImage >>>'
go

/* get details for one event */
/* input:  event id
   output: auditorium id, stage URL
*/
CREATE PROC getEventInfo ( @eventID numeric(10,0) )
AS
BEGIN
  SELECT auditorium, stageBackground
    FROM events
    WHERE eventID = @eventID
END

go
IF OBJECT_ID('dbo.getEventInfo') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getEventInfo >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getEventInfo >>>'
go

/* get allowed interactions for a specified event */
/* input:  event id
   output: list of allowed event types for that event
*/
CREATE PROC getEventInteractionTypes ( @eventID eventIdentifier )
AS
  SELECT interactionType, name, interactBlocked
    FROM interactionsAllowed
    WHERE eventID = @eventID

go
IF OBJECT_ID('dbo.getEventInteractionTypes') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getEventInteractionTypes >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getEventInteractionTypes >>>'
go

/* get details of events, for the events specified */
/* input: 
     auditorium name - (optional) name of auditorium for
                which to get the events. NOTE: "*" has 
                special meaning - show all auditoriums.
     show past flag - whether to show events that have ended
     open flag - whether to show events that have just opened
     in progress flag - whether to show events that are in progress (started)
     future flag - whether to show events that have been defined
                   but have not opened yet
       (all this sorting by time will be done by the event's 
        currentState field)
   output: list of events, stating for each -
   id, start time, end time, title, auditorium name
   21/07/97: Added current event state in returned columns
*/
CREATE PROC getEventList
(
  @auditoriumName varchar(16),
  @showPast       bit,
  @showOpen       bit,
  @showPresent    bit,
  @showFuture     bit
)
AS
BEGIN
  IF ( @auditoriumName = "*" )
    SELECT @auditoriumName = "%"
  SELECT events.eventID, 
         startState.time AS startTime, 
         endState.time AS endTime, 
         events.title, auditoriums.name AS auditoriumName,
         events.currentState AS status
    FROM events, auditoriums,
         eventState startState, eventState endState
    WHERE auditoriums.name LIKE @auditoriumName AND
          events.auditorium = auditoriums.auditoriumID AND
          events.eventID = startState.eventID AND
          events.eventID = endState.eventID AND
          startState.stateID = 2 AND
          endState.stateID   = 3 AND
          (
            ( ( @showFuture = 1 ) AND ( events.currentState = 0 ) ) OR
            ( ( @showPast = 1 ) AND ( events.currentState = 3 ) ) OR
            ( ( @showOpen = 1 ) AND ( events.currentState = 1 ) ) OR
            ( ( @showPresent = 1 ) AND ( events.currentState = 2 ) )
          )
    ORDER BY startState.time
END
go
IF OBJECT_ID('dbo.getEventList') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getEventList >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getEventList >>>'
go

/* for a specific state for one specific event,
   get welcome message and title */
/* input:  event id, state id
   output: image
*/
CREATE PROC getEventStateInfo
(
  @eventID numeric(10,0),
  @stateID numeric(4,0)
)
AS
BEGIN
  SELECT welcomeMsg1, welcomeMsg2, PTGtitle
    FROM eventState
    WHERE eventID = @eventID AND
          stateID = @stateID
END

go
IF OBJECT_ID('dbo.getEventStateInfo') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getEventStateInfo >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getEventStateInfo >>>'
go

/* get list of votes for a given event  */
/* input:  event ID
   output: list of votes, stating for each - 
           id, title, status
*/
CREATE PROC getEventVotesList(
        @eventID 	eventIdentifier
)
AS
  SELECT voteID, title, status
    FROM eventVotes
    WHERE eventID = @eventID

go
IF OBJECT_ID('dbo.getEventVotesList') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getEventVotesList >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getEventVotesList >>>'
go

/* get update notifications for latest 
   editing changes done on events */
/* input:  NONE
   output: list of event changes, stating -
   event id, field id
*/
CREATE PROC getEventsUpdates
AS
BEGIN
  DECLARE @lastError int
  BEGIN TRAN getEventsUpdates
    SELECT eventID, fieldID
      FROM eventChanges
      ORDER BY eventID
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
    
    DELETE FROM eventChanges
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRAN
      RETURN @lastError
    END
    
  COMMIT TRAN getEventsUpdates
END
go
IF OBJECT_ID('dbo.getEventsUpdates') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getEventsUpdates >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getEventsUpdates >>>'
go

/* get details for one event interaction*/
/* input:  interaction id
   output: name, time, sender, text, status, category
*/
CREATE PROC getInteractionInfo ( @interactionID numeric(10,0) )
AS
BEGIN
  SELECT name, time, senderName, text, status, category
    FROM eventInteractions ( INDEX interactionsByEventIdx ), interactionsAllowed
    WHERE interactionID = @interactionID AND
          eventInteractions.eventID = interactionsAllowed.eventID AND
          eventInteractions.interactionType = interactionsAllowed.interactionType
END

go
IF OBJECT_ID('dbo.getInteractionInfo') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getInteractionInfo >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getInteractionInfo >>>'
go

/* getInteractions - returns a list of up to 100 interactions for the 
                     requested event, of the requested type. 
   Inputs - eventId: id of the event for which to get interactions
            host name: name of host which is getting interactions
            interactionType: list of interactions types to get
            fetchType: one of "NEW"    - to get interactions which status is "IDLE" or "LOCKED" by the host
                              "MINE"   - to get interactions which status is "READY" or 
                                         "FORWARDED", with my name on them,
                              "LOCKED" - to get interactions which status is "LOCKED"
                                         by the host - for refreshes of tables.
            orderBy: "InteractionType", "Category", "SenderName", "None"
   Output - a list of interactions with the following fields: interaction Id, interaction name,
            sender, text, category, status
   Processing - scans the interactions table, and returns the requested interactions. If NEW 
                interactions are requested, all interactions fetched are 
                set to LOCKED by the host. 
   Returns - 20001 - if too many interaction types were given
*/
CREATE PROC getInteractions (
              @eventID	 eventIdentifier,
              @hostName  VPuserID,
              @interactionTypes longName,
              @fetchType varchar(10), 
              @orderBy varchar(20)
       )
AS
BEGIN

DECLARE @lastError integer

/* Get Interaction Types requested ... */
/* ------------------------------------*/
DECLARE @iType    integer
DECLARE @iType1   integer
DECLARE @iType2   integer 
DECLARE @iType3   integer 
DECLARE @iType4   integer 
DECLARE @iType5   integer 
DECLARE @iType6   integer 
DECLARE @counter  integer
DECLARE @commaPos integer
DECLARE @IName    varchar(16)
DECLARE @fetchedCounter integer
DECLARE @locked   integer
DECLARE @idle     integer
DECLARE @ready    integer
DECLARE @forwarded integer
DECLARE @status   integer

/* Parse list of interaction types */
/* --------------------------------*/
SELECT @counter = 1
WHILE ( ascii( rtrim(ltrim(@interactionTypes))) > 32 )
BEGIN
  SELECT @commaPos = patindex( "%,%", @interactionTypes )
  IF @commaPos = 0 BEGIN
    /* Last Interaction Type in list */
    SELECT @IName = rtrim(ltrim(@interactionTypes))
    SELECT @interactionTypes = ""
  END
  ELSE BEGIN
    SELECT @IName = rtrim( ltrim( substring( @interactionTypes, 1, @commaPos-1)) )
    SELECT @interactionTypes = substring( @interactionTypes, 
                                          @commaPos+1, 
                                          char_length( @interactionTypes ) - @commaPos )
  END

  /* Get the Interaction Type for the current Interaction Name */
  SELECT @iType = interactionType
  FROM interactionsAllowed
  WHERE eventID = @eventID AND
        name = @IName
  SELECT @lastError = @@error
  IF @lastError != 0
    RETURN @lastError
  
  IF @counter = 1 
     SELECT @iType1 = @iType
  ELSE IF @counter = 2 
     SELECT @iType2 = @iType
  ELSE IF @counter = 3 
     SELECT @iType3 = @iType
  ELSE IF @counter = 4 
     SELECT @iType4 = @iType
  ELSE IF @counter = 5 
     SELECT @iType5 = @iType
  ELSE IF @counter = 6 
     SELECT @iType6 = @iType
  ELSE 
    RETURN 20001 /* Too many Interaction Types */

  SELECT @counter = @counter + 1

END /* of while */

/* Set zero in unused iTypes variables */
WHILE @counter <= 6
BEGIN
  IF @counter = 1 
     SELECT @iType1 = 0
   ELSE IF @counter = 2 
     SELECT @iType2 = 0
  ELSE IF @counter = 3 
     SELECT @iType3 = 0
  ELSE IF @counter = 4 
     SELECT @iType4 = 0
  ELSE IF @counter = 5 
     SELECT @iType5 = 0
  ELSE IF @counter = 6 
     SELECT @iType6 = 0
  SELECT @counter = @counter + 1
END
 
  
/* Get interaction status values */ 
SELECT @locked = statusID 
FROM interactionStatus
WHERE name = "LOCKED"
SELECT @lastError = @@error
IF @lastError != 0
  RETURN @lastError

SELECT @idle = statusID  
FROM interactionStatus
WHERE name = "IDLE"
SELECT @lastError = @@error
IF @lastError != 0
  RETURN @lastError

SELECT @ready = statusID
FROM interactionStatus
WHERE name = "READY"
SELECT @lastError = @@error
IF @lastError != 0
  RETURN @lastError
  
SELECT @forwarded = statusID  
FROM interactionStatus
WHERE name = "FORWARDED"
SELECT @lastError = @@error
IF @lastError != 0
  RETURN @lastError
 
BEGIN TRAN

/* Get New interactions */
/* ---------------------*/
IF @fetchType = "NEW" 
BEGIN
  /* Unlock any interactions which has been locked previously by this host */
  UPDATE eventInteractions
    SET status = @idle 
    FROM eventInteractions
    ( INDEX interactionsByStatusIdx )
    WHERE status = @locked AND hostName = @hostName
  SELECT @lastError = @@error
  IF @lastError != 0
  BEGIN
    ROLLBACK TRAN
    RETURN @lastError
  END

  /* Mark the first 100 interactions as locked by this user */
  SET ROWCOUNT 100
  UPDATE eventInteractions
    SET status = @locked, hostName = @hostName
    WHERE interactionID IN 
          (SELECT interactionID
           FROM eventInteractions ( INDEX interactionsByEventIdx ), interactionsAllowed
           WHERE interactionsAllowed.eventID = @eventID AND
                 eventInteractions.eventID = @eventID AND
                 interactionsAllowed.interactionType = eventInteractions.interactionType AND
                 eventInteractions.status = @idle AND 
                 eventInteractions.interactionType in (@iType1, @iType2, @iType3, @iType4, @iType5, @iType6)
          ) 
  SELECT @lastError = @@error
  IF @lastError != 0
  BEGIN
    ROLLBACK TRAN
    RETURN @lastError
  END

  /*Now select the locked interactions */
  SELECT @fetchType = "LOCKED"
END

/* Get My interactions */
/* ---------------------*/
IF @fetchType = "MINE" 
BEGIN

  IF @orderBy = "InteractionType"
    SELECT interactionID, name, senderName, text, category, status
    FROM eventInteractions ( INDEX interactionsByEventIdx ), interactionsAllowed
    WHERE interactionsAllowed.eventID = @eventID AND
        eventInteractions.eventID = @eventID AND
        interactionsAllowed.interactionType = eventInteractions.interactionType AND
        eventInteractions.status in (@ready, @forwarded) AND
        eventInteractions.hostName = @hostName AND  
        eventInteractions.interactionType in (@iType1, @iType2, @iType3, @iType4, @iType5, @iType6)
    ORDER BY name
  ELSE  IF @orderBy = "Category"
    SELECT interactionID, name, senderName, text, category, status
    FROM eventInteractions ( INDEX interactionsByEventIdx ), interactionsAllowed
    WHERE interactionsAllowed.eventID = @eventID AND
        eventInteractions.eventID = @eventID AND
        interactionsAllowed.interactionType = eventInteractions.interactionType AND
        eventInteractions.status in (@ready, @forwarded) AND
        eventInteractions.hostName = @hostName AND  
        eventInteractions.interactionType in (@iType1, @iType2, @iType3, @iType4, @iType5, @iType6)
    ORDER BY category
  ELSE IF @orderBy = "SenderName"
    SELECT interactionID, name, senderName, text, category, status
    FROM eventInteractions ( INDEX interactionsByEventIdx ), interactionsAllowed
    WHERE interactionsAllowed.eventID = @eventID AND
        eventInteractions.eventID = @eventID AND
        interactionsAllowed.interactionType = eventInteractions.interactionType AND
        eventInteractions.status in (@ready, @forwarded) AND
        eventInteractions.hostName = @hostName AND  
        eventInteractions.interactionType in (@iType1, @iType2, @iType3, @iType4, @iType5, @iType6)
    ORDER BY senderName
  ELSE /* No sort */
    SELECT interactionID, name, senderName, text, category, status
    FROM eventInteractions ( INDEX interactionsByEventIdx ), interactionsAllowed
    WHERE interactionsAllowed.eventID = @eventID AND
        eventInteractions.eventID = @eventID AND
        interactionsAllowed.interactionType = eventInteractions.interactionType AND
        eventInteractions.status in (@ready, @forwarded) AND
        eventInteractions.hostName = @hostName AND  
        eventInteractions.interactionType in (@iType1, @iType2, @iType3, @iType4, @iType5, @iType6)
 
  SELECT @lastError = @@error
  IF @lastError != 0
  BEGIN
    ROLLBACK TRAN
    RETURN @lastError
  END
  
END

/* Get interactions locked by me */
/* ------------------------------*/
IF @fetchType = "LOCKED" 
BEGIN

  IF @orderBy = "InteractionType"
    SELECT interactionID, name, senderName, text, category, status
    FROM eventInteractions ( INDEX interactionsByEventIdx ), interactionsAllowed
    WHERE interactionsAllowed.eventID = @eventID AND
        eventInteractions.eventID = @eventID AND
        interactionsAllowed.interactionType = eventInteractions.interactionType AND
        eventInteractions.status = @locked AND
        eventInteractions.hostName = @hostName AND  
        eventInteractions.interactionType in (@iType1, @iType2, @iType3, @iType4, @iType5, @iType6)
    ORDER BY name
  ELSE   IF @orderBy = "Category"
    SELECT interactionID, name, senderName, text, category, status
    FROM eventInteractions ( INDEX interactionsByEventIdx ), interactionsAllowed
    WHERE interactionsAllowed.eventID = @eventID AND
        eventInteractions.eventID = @eventID AND
        interactionsAllowed.interactionType = eventInteractions.interactionType AND
        eventInteractions.status = @locked AND
        eventInteractions.hostName = @hostName AND  
        eventInteractions.interactionType in (@iType1, @iType2, @iType3, @iType4, @iType5, @iType6)
    ORDER BY category
  ELSE   IF @orderBy = "SenderName"
    SELECT interactionID, name, senderName, text, category, status
    FROM eventInteractions ( INDEX interactionsByEventIdx ), interactionsAllowed
    WHERE interactionsAllowed.eventID = @eventID AND
        eventInteractions.eventID = @eventID AND
        interactionsAllowed.interactionType = eventInteractions.interactionType AND
        eventInteractions.status = @locked AND
        eventInteractions.hostName = @hostName AND  
        eventInteractions.interactionType in (@iType1, @iType2, @iType3, @iType4, @iType5, @iType6)
    ORDER BY senderName
  ELSE /*No sort */
    SELECT interactionID, name, senderName, text, category, status
    FROM eventInteractions ( INDEX interactionsByEventIdx ), interactionsAllowed
    WHERE interactionsAllowed.eventID = @eventID AND
        eventInteractions.eventID = @eventID AND
        interactionsAllowed.interactionType = eventInteractions.interactionType AND
        eventInteractions.status = @locked AND
        eventInteractions.hostName = @hostName AND  
        eventInteractions.interactionType in (@iType1, @iType2, @iType3, @iType4, @iType5, @iType6)

  SELECT @lastError = @@error
  IF @lastError != 0
  BEGIN
    ROLLBACK TRAN
    RETURN @lastError
  END
  
END

COMMIT TRAN

END

go
IF OBJECT_ID('dbo.getInteractions') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getInteractions >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getInteractions >>>'
go

/* --- For a given event, return for each
   interaction type, the total number of 
   interactions of that type, the number of 
   interactions currently processed by the 
   requesting host and by others, 
   and the number of interactions broadcasted
   by the requesting host and by others.
*/
/* input:  event id, hostName
output: for each interaction type, the following fields:
        interaction name, total#, idle#,
        processed by host, processed by others,
        broadcasted by host, broadcasted by others, blocking status
*/
CREATE PROC getInteractionsNum
(
  @eventID     eventIdentifier,
  @hostName    VPuserID
)
AS
BEGIN
   DECLARE @iType       numeric(2,0)
   DECLARE @iName       varchar(16)
   DECLARE @iCount      integer
   DECLARE @idleCount   integer
   DECLARE @pHostCount  integer
   DECLARE @pOtherCount integer
   DECLARE @bHostCount  integer
   DECLARE @bOtherCount integer
   DECLARE @lastError   integer
   DECLARE @blocked 	bit

   DECLARE @IDLE        integer
   DECLARE @LOCKED      integer
   DECLARE @DELETED 	integer
   DECLARE @FORWARDED   integer
   DECLARE @ATGUEST     integer
   DECLARE @READY	integer
   DECLARE @BROADCASTED integer

   SELECT @IDLE = 1
   SELECT @LOCKED = 2
   SELECT @DELETED = 3
   SELECT @FORWARDED = 4
   SELECT @ATGUEST = 5
   SELECT @READY = 6
   SELECT @BROADCASTED = 7

   CREATE TABLE #Statistics (iName varchar(16), numInt integer, numIdle integer,
                             numProcHost integer, numProcOthers integer,
                             numBroadHost integer, numBroadOthers integer, blocked bit)

   /* Get all interaction types for this event */
   DECLARE interactionTypes CURSOR
   FOR
   SELECT interactionType, name, interactBlocked
   FROM interactionsAllowed
   WHERE eventID = @eventID
   FOR READ ONLY
   SELECT @lastError = @@error
   IF @lastError != 0
      RETURN @lastError
   
   /* For each interaction type, get all the numbers */
   OPEN interactionTypes
   FETCH interactionTypes INTO @iType, @iName, @blocked
   WHILE ( @@sqlstatus = 0 )
   BEGIN
     SELECT @iCount = count(*)
     FROM eventInteractions ( INDEX interactionsByEventIdx )
     WHERE eventID = @eventID AND
           interactionType = @iType AND
           status != @DELETED
     SELECT @lastError = @@error
     IF @lastError != 0
       RETURN @lastError
          
     SELECT @idleCount = count(*)
     FROM eventInteractions ( INDEX interactionsByEventIdx )
     WHERE eventID = @eventID AND
           interactionType = @iType AND
           status IN (@IDLE, @LOCKED)
     SELECT @lastError = @@error
     IF @lastError != 0
       RETURN @lastError
 
     SELECT @pHostCount = count(*)
     FROM eventInteractions ( INDEX interactionsByEventIdx )
     WHERE eventID = @eventID AND
           interactionType = @iType AND
           hostName = @hostName AND
           status IN (@READY, @FORWARDED)
     SELECT @lastError = @@error
     IF @lastError != 0
       RETURN @lastError
 
     SELECT @pOtherCount = count(*)
     FROM eventInteractions ( INDEX interactionsByEventIdx )
     WHERE eventID = @eventID AND
           interactionType = @iType AND
           hostName != @hostName AND
           status IN (@READY, @FORWARDED, @ATGUEST)
     SELECT @lastError = @@error
     IF @lastError != 0
       RETURN @lastError

     SELECT @bHostCount = count(*)
     FROM eventInteractions ( INDEX interactionsByEventIdx )
     WHERE eventID = @eventID AND
           interactionType = @iType AND
           hostName = @hostName AND
           status = @BROADCASTED
     SELECT @lastError = @@error
     IF @lastError != 0
       RETURN @lastError

     SELECT @bOtherCount = count(*)
     FROM eventInteractions ( INDEX interactionsByEventIdx )
     WHERE eventID = @eventID AND
           interactionType = @iType AND
           hostName != @hostName AND
           status = @BROADCASTED
     SELECT @lastError = @@error
     IF @lastError != 0
       RETURN @lastError

     INSERT INTO #Statistics 
     VALUES(@iName, @iCount, @idleCount, @pHostCount, @pOtherCount, 
            @bHostCount, @bOtherCount, @blocked)
     FETCH interactionTypes INTO @iType, @iName, @blocked
   END
   CLOSE interactionTypes
   SELECT * from #Statistics

END

go
IF OBJECT_ID('dbo.getInteractionsNum') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getInteractionsNum >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getInteractionsNum >>>'
go

/* Gets all invited guest for an event from the invitees table */
/* input:  eventId
   output: list of invitees with the fields:
   invited guest name, registration mode 
*/
CREATE PROC getInvitees
(
  @eventID		eventIdentifier
)
AS
  SELECT inviteeName, regMode
    FROM eventInvitees
    WHERE eventID = @eventID


go
IF OBJECT_ID('dbo.getInvitees') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getInvitees >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getInvitees >>>'
go

/* get list of community-wide hosts */
/* input:  NONE
   output: lists of hosts names
*/
CREATE PROC getMasterHostList
AS
BEGIN
  EXEC vpperm..getHosts
END

go
IF OBJECT_ID('dbo.getMasterHostList') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getMasterHostList >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getMasterHostList >>>'
go

/* get the event states that have turned current 
   in the last X minutes */
/* input:  interval length in minutes - take this out when possible
   output: list of states, stating for each
           its event id and state id
*/
CREATE PROC getNewEventStates
AS
BEGIN
  DECLARE @lastError int

      SELECT eventState.eventID, eventState.stateID,
             welcomeMsg1, welcomeMsg2, PTGtitle
        FROM eventState, correctStates, events
        WHERE eventState.eventID = correctStates.eventID AND
              eventState.stateID = correctStates.stateID AND
	      events.eventID = eventState.eventID AND
	      events.currentState < eventState.stateID 
        ORDER BY eventID, time

    
    SELECT @lastError = @@error
    IF @lastError != 0
      RETURN @lastError
    
END

go
IF OBJECT_ID('dbo.getNewEventStates') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getNewEventStates >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getNewEventStates >>>'
go

/* gets the header information for a specific vote */
/* input:  vote id
   output: title, description, numChoices, status
*/
CREATE PROC getVoteHdr ( @voteID numeric(10,0) )
AS
BEGIN
  SELECT title, description, numChoices, status
    FROM eventVotes
    WHERE voteID = @voteID
END

go
IF OBJECT_ID('dbo.getVoteHdr') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getVoteHdr >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getVoteHdr >>>'
go

/* get list of vote options for a given vote  */
/* input:  vote ID
   output: list of vote options, stating for each - 
           id, option, description
*/
CREATE PROC getVoteOptionsList(
        @voteID 	numeric(10,0)
)
AS
  SELECT optionID, label, description
    FROM voteOptions
    WHERE voteID = @voteID

go
IF OBJECT_ID('dbo.getVoteOptionsList') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getVoteOptionsList >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getVoteOptionsList >>>'
go

/* Calculates vote results from the user selectiosn in the userVotes table */
/* input:  voteID. 
   output: a list of option results as follows - 
           option, numSelections, percent 
           + totals.
*/
CREATE PROC getVoteResults
(
  @voteID		numeric(10,0)
)
AS
BEGIN
  DECLARE @total int
  DECLARE @num   int
  DECLARE @eventState int
  DECLARE @lastError int

  /* Check event state: if event is over, get numbers from voteOptions table.
     Otherwise, get numbers from userVotes table */
  SELECT @eventState = currentState
    FROM events, eventVotes
    WHERE voteID = @voteID AND
          events.eventID = eventVotes.eventID
  SELECT @lastError = @@error
  IF @lastError != 0
    RETURN @lastError
  IF @eventState = 3
  BEGIN    /* Get results from voteOptions table */
    SELECT @total = sum(totalSelections)
      FROM voteOptions
      WHERE voteID = @voteID
    IF @total = 0
      SELECT @total = 1 /* To avoid divide by 0, all results should be 0 */
    SELECT label, totalSelections, (convert(real, totalSelections) / @total) * 100
      FROM voteOptions
      WHERE voteID = @voteID
      ORDER BY label
  END
  ELSE BEGIN    /* Get results from userVotes table */
    SELECT @total = count(*)
      FROM userVotes
      WHERE voteID = @voteID
    IF @total = 0
      SELECT @total = 1 /* To avoid divide by 0, all results should be 0 */
    
    SELECT DISTINCT label, optionID
      INTO #voteOptions
      FROM voteOptions
      WHERE voteID = @voteID 
          
     
    SELECT  label, count(userVotes.optionID), 
           (convert(real,count(userVotes.optionID)) / @total) * 100
      FROM userVotes, #voteOptions
      WHERE userVotes.voteID = @voteID AND
            #voteOptions.optionID = userVotes.optionID 
      GROUP BY ALL label
      ORDER BY label
  END

END

go
IF OBJECT_ID('dbo.getVoteResults') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.getVoteResults >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.getVoteResults >>>'
go

/* set the current state of an event */
/* input:  event id, new state id
   output: NONE
*/
CREATE PROC setEventState
(
  @eventID numeric(10,0), 
  @newState numeric(4,0)
)
AS
BEGIN
  UPDATE events
    SET currentState = @newState
    WHERE events.eventID = @eventID
END

go
IF OBJECT_ID('dbo.setEventState') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.setEventState >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.setEventState >>>'
go

/* input:  auditorium id, new URL
   output: NONE
*/
CREATE PROC updAudURL
(
  @audId  numeric(6,0),
  @newURL longName
)
AS
  UPDATE auditoriums
    SET background = @newURL
    WHERE auditoriumID = @audId

go
IF OBJECT_ID('dbo.updAudURL') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.updAudURL >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.updAudURL >>>'
go

/* update the record for an existsing auditorium:
   name, client name, background, 
   title, welcome message, show on PTG flag, 
   stageCapacity, row size, # of rows */
/* input:  auditorium id, name, client name, 
           background, title, welcome message, 
           show on PTG flag, 
           stageCapacity, row size, # of rows
   output: return value 20001 if auditorium Id not found,
                        20003 if name is already used
                        20002 if background URL already used
*/
CREATE PROC updateAuditorium
(
  @auditoriumID numeric(6,0),
  @auditoriumName	varchar(16) = NULL,
  @clientName		varchar(16) = NULL,
  @background		varchar(255) = NULL,
  @title		varchar(255) = NULL,
  @welcomeMsg1		varchar(255) = NULL,
  @welcomeMsg2		varchar(255) = NULL,
  @showOnPTG		bit = 1,
  @stageCapacity	integer = NULL, 
  @rowSize		integer = NULL,
  @numberOfRows		integer = NULL
)
AS
BEGIN
  DECLARE @oldName		varchar(16)
  DECLARE @oldClient		varchar(16)
  DECLARE @oldBackground	varchar(255)
  DECLARE @oldTitle		varchar(255)
  DECLARE @oldWelcomeMsg1	varchar(255)
  DECLARE @oldWelcomeMsg2	varchar(255)
  DECLARE @oldStageCapacity	integer 
  DECLARE @oldRowSize		integer
  DECLARE @oldNumberOfRows	integer
  
  DECLARE @lastError int
  BEGIN TRAN updateAuditorium
    /* first check if the auditorium exists */
    SELECT @oldName = name,
           @oldClient = client,
           @oldBackground = background,
           @oldTitle = title,
           @oldWelcomeMsg1 = welcomeMsg1,
           @oldWelcomeMsg2 = welcomeMsg2,
           @oldStageCapacity = stageCapacity,
           @oldRowSize = rowSize,
           @oldNumberOfRows = numberOfRows
      FROM auditoriums
      WHERE auditoriumID = @auditoriumID
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      raiserror @lastError
      ROLLBACK TRAN updateAuditorium
      RETURN @lastError
    END
    
    IF @oldName IS NULL
    BEGIN
      /* could not find matching auditorium */
      ROLLBACK TRAN updateAuditorium
      RETURN 20001
    END
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      raiserror @lastError
      ROLLBACK TRAN updateAuditorium
      RETURN @lastError
    END
    
    IF @auditoriumName IS NULL
      SELECT @auditoriumName = @oldName
    ELSE
    BEGIN
      IF ( @auditoriumName != @oldName )
      BEGIN
        
        IF EXISTS
          ( SELECT auditoriumID
    	  FROM auditoriums
      	  WHERE name = @auditoriumName )
        BEGIN
          /* name is already used */
          RETURN 20003
          ROLLBACK TRAN
        END
        
        SELECT @lastError = @@error
        IF @lastError != 0
        BEGIN
          ROLLBACK TRAN
          RETURN @lastError
        END
      END
    END

    IF @clientName IS NULL
      SELECT @clientName = @oldClient

    IF @background IS NULL
      SELECT @background = @oldBackground
    ELSE
    BEGIN
      IF ( @background != @oldBackground )
      BEGIN
        IF EXISTS
          ( SELECT auditoriumID
    	  FROM auditoriums
      	  WHERE background = @background )
        BEGIN
          /* name is already used */
          RETURN 20002
          ROLLBACK TRAN
        END
        
        SELECT @lastError = @@error
        IF @lastError != 0
        BEGIN
          ROLLBACK TRAN
          RETURN @lastError
        END
      END
    END

    IF @title IS NULL
      SELECT @title = @oldTitle
    ELSE
    BEGIN
      INSERT auditoriumChanges
       VALUES(@auditoriumID, 3) 
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        raiserror @lastError
        ROLLBACK TRAN updateAuditorium
        RETURN @lastError
      END
    END

    IF NOT (@welcomeMsg1 IS NULL) OR 
       NOT (@welcomeMsg2 IS NULL)
    BEGIN
      INSERT auditoriumChanges
       VALUES(@auditoriumID, 2) 
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        raiserror @lastError
        ROLLBACK TRAN updateAuditorium
        RETURN @lastError
      END
    END

    IF @welcomeMsg1 IS NULL
      SELECT @welcomeMsg1 = @oldWelcomeMsg1
    
    IF @welcomeMsg2 IS NULL
      SELECT @welcomeMsg2 = @oldWelcomeMsg2

    IF @stageCapacity IS NULL
      SELECT @stageCapacity = @oldStageCapacity

    IF @rowSize IS NULL
      SELECT @rowSize = @oldRowSize

    IF @numberOfRows IS NULL
      SELECT @numberOfRows = @oldNumberOfRows
    
    
    UPDATE auditoriums
      SET name = @auditoriumName,
          client = @clientName,
          background = @background,
          title = @title,
          welcomeMsg1 = @welcomeMsg1,
          welcomeMsg2 = @welcomeMsg2,
          inPlacesList = @showOnPTG,
          stageCapacity = @stageCapacity,
          rowSize = @rowSize,
          numberOfRows = @numberOfRows
      FROM auditoriums
      WHERE auditoriumID = @auditoriumID
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      raiserror @lastError
      ROLLBACK TRAN updateAuditorium
      RETURN @lastError
    END
    
  COMMIT TRAN updateAuditorium
END

go
IF OBJECT_ID('dbo.updateAuditorium') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.updateAuditorium >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.updateAuditorium >>>'
go

/* update the record for an existing event:
  name, client name, background, title, 
  welcome message, show on PTG flag, 
  stageCapacity, row size, # of rows */

/* input:  event id, event title, 
           auditorium name, client name,
           time, background URL, 
           open time, open title, open welcome msg,
           start time, start title, start welcome msg,
           start time, start title, start welcome msg,
           end time,
           event interactions list
           output: NONE
*/

CREATE PROC updateEvent
(
  @eventID		eventIdentifier,
  @title		longName = NULL,
  @auditoriumName	varchar(16) = NULL,
  @clientName		varchar(16) = NULL,
  @time			VpTime = NULL,
  @background		longName = NULL,
  @openTime		VpTime = NULL,
  @openTitle		longName = NULL,
  @openWelcomeMsg1	longName = NULL,
  @openWelcomeMsg2	longName = NULL,
  @startTime		VpTime = NULL,
  @startTitle		longName = NULL,
  @startWelcomeMsg1	longName = NULL,
  @startWelcomeMsg2	longName = NULL,
  @endTime		VpTime = NULL,
  @eventInteractions	longName = NULL
)
AS
BEGIN
  DECLARE @oldTitle		 longName
  DECLARE @oldAuditorium	 auditoriumIdentifier
  DECLARE @newAuditorium	 auditoriumIdentifier
  DECLARE @oldClientName	 varchar(16)
  DECLARE @oldTime		 VpTime
  DECLARE @oldBackground	 longName
  DECLARE @currentState		 integer
  DECLARE @oldStateTime		 VpTime
  DECLARE @oldOpenTime		 VpTime
  DECLARE @oldEndTime		 VpTime
  DECLARE @oldStateTitle	 longName
  DECLARE @oldStateWelcomeMsg1	 longName
  DECLARE @oldStateWelcomeMsg2	 longName
  DECLARE @description 		 varchar(16)
  DECLARE @commaPos 		 integer
  DECLARE @counter 		 integer
  DECLARE @canUpdateInteractions bit
  
  DECLARE @lastError int
  BEGIN TRAN updateEvent
             
    /* first check if the event exists */
    SELECT @oldClientName = client,
           @oldTitle = title,
           @oldAuditorium = auditorium,
           @oldTime = date,
           @oldBackground = stageBackground,
           @currentState = currentState
      FROM events
      WHERE eventID = @eventID
      
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      RAISERROR @lastError
      ROLLBACK TRAN updateEvent
      RETURN @lastError
    END
    
    /* If NULL values were passed,
       use the existing values in the update */
    IF @oldTime IS NULL
    BEGIN
      /* could not find matching event */
      ROLLBACK TRAN updateEvent
      RETURN 20001
    END
    
    IF @title IS NULL
      SELECT @title = @oldTitle
    IF @auditoriumName IS NULL
      SELECT @newAuditorium = @oldAuditorium
    ELSE
    BEGIN
      /* verify that we have an auditorium 
         with a matching name */
      SELECT @newAuditorium = auditoriumID
        FROM auditoriums
        WHERE name = @auditoriumName
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        raiserror @lastError
        ROLLBACK TRAN updateEvent
        RETURN @lastError
      END
      IF @newAuditorium IS NULL
      BEGIN
        ROLLBACK TRAN updateEvent
        RETURN 20002
      END
    END
    
    IF @clientName IS NULL
      SELECT @clientName = @oldClientName
    IF @time IS NULL
      SELECT @time = @oldTime
    IF @background IS NULL
      SELECT @background = @oldBackground
    
    UPDATE events
      SET title = @title,
          auditorium = @newAuditorium,
          client = @clientName,
          stageBackground = @background
      WHERE eventID = @eventID
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      RAISERROR @lastError
      ROLLBACK TRAN updateEvent
      RETURN @lastError
    END
    
    /* ----------------------------------------- */
    /* Now continue the update by                */
    /* updating the event's states               */
    /* ----------------------------------------- */
    /* ------------------------ */
    /* do update of Open State  */
    /* ------------------------ */
    SELECT @oldStateTime = time,
           @oldStateTitle = PTGtitle,
           @oldStateWelcomeMsg1 = welcomeMsg1,
           @oldStateWelcomeMsg2 = welcomeMsg2
      FROM eventState
      WHERE eventID = @eventID AND
            stateID = 1  /* OPEN state */
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      raiserror @lastError
      ROLLBACK TRAN updateEvent
      RETURN @lastError
    END
      
    /* can't change event interaction types after event is
       opened */
    IF ( @currentState = 0 )
      SELECT @canUpdateInteractions = 1
    ELSE
      SELECT @canUpdateInteractions = 0
    
    IF ( ( @openTime IS NOT NULL )		OR
         ( @openTitle IS NOT NULL )		OR
         ( @openWelcomeMsg1 IS NOT NULL )	OR
         ( @openWelcomeMsg2 IS NOT NULL )          )
    BEGIN
      /* updates to state after its time has arrived
         are not permitted */
      IF ( @currentState >= 1 ) AND ( @openTime IS NOT NULL )
      BEGIN
        ROLLBACK TRAN updateEvent
        RETURN 20003
      END
      
      /* update the open state */
      /* first, get the current data */
      IF ( @openTime IS NULL )
        SELECT @openTime = @oldStateTime
      IF ( @openTitle IS NULL )
        SELECT @openTitle = @oldStateTitle
      ELSE
      BEGIN
        /* Add event title change record for this state */
        IF @currentState = 1
        INSERT eventChanges
          VALUES(@eventID, @currentState, 3)    /* 3 = title change */
        
        SELECT @lastError = @@error
        IF @lastError != 0
        BEGIN
          raiserror @lastError
          ROLLBACK TRAN updateEvent
          RETURN @lastError
        END
        
      END
      
      IF NOT ( @openWelcomeMsg1 IS NULL ) OR NOT ( @openWelcomeMsg2 IS NULL)
      BEGIN
        IF @currentState = 1
        BEGIN
          /* Add event welcome message change record for this state */
          INSERT eventChanges
            VALUES(@eventID, @currentState, 2)    /* 2 = welcome message change */
          
          SELECT @lastError = @@error
          IF @lastError != 0
          BEGIN
            raiserror @lastError
            ROLLBACK TRAN updateEvent
            RETURN @lastError
          END
          
        END
      END
      
      IF ( @openWelcomeMsg1 IS NULL )
        SELECT @openWelcomeMsg1 = @oldStateWelcomeMsg1
    
      IF ( @openWelcomeMsg2 IS NULL )
        SELECT @openWelcomeMsg2 = @oldStateWelcomeMsg2
    
      UPDATE eventState
        SET time = @openTime,
            PTGtitle = @openTitle,
            welcomeMsg1 = @openWelcomeMsg1,
            welcomeMsg2 = @openWelcomeMsg2
        WHERE eventID = @eventID AND
              stateID = 1
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        RAISERROR @lastError
        ROLLBACK TRAN updateEvent
        RETURN @lastError
      END
    END /* changes to open state */
    IF ( ( @openTime IS NOT NULL ) OR
         ( @endTime IS NOT NULL )     )
    BEGIN
      SELECT @oldOpenTime = @oldStateTime
      IF ( @openTime IS NULL )
      BEGIN
        SELECT @openTime = @oldOpenTime
      END
    END
    
    /* ------------------------ */
    /* do update of Start State */
    /* ------------------------ */
    SELECT @oldStateTime = time,
           @oldStateTitle = PTGtitle,
           @oldStateWelcomeMsg1 = welcomeMsg1,
           @oldStateWelcomeMsg2 = welcomeMsg2
      FROM eventState
      WHERE eventID = @eventID AND
            stateID = 2	/* 2 = Started state */
    IF ( ( @startTime IS NOT NULL )		OR
         ( @startTitle IS NOT NULL )		OR
         ( @startWelcomeMsg1 IS NOT NULL )	OR
         ( @startWelcomeMsg2 IS NOT NULL )          )
    BEGIN
      /* updates to state after its time has arrived
      are not permitted */
      IF ( @currentState >= 2 ) AND ( @startTime IS NOT NULL )
      BEGIN
        ROLLBACK TRAN updateEvent
        RETURN 20003
      END
    
      /* update the start state */
      /* first, get the current data */
      SELECT @oldStateTime = time,
             @oldStateTitle = PTGtitle,
             @oldStateWelcomeMsg1 = welcomeMsg1,
             @oldStateWelcomeMsg2 = welcomeMsg2
        FROM eventState
        WHERE eventID = @eventID AND
              stateID = 2
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        raiserror @lastError
        ROLLBACK TRAN updateEvent
        RETURN @lastError
      END
    
      IF ( @startTime IS NULL )
        SELECT @startTime = @oldStateTime
      IF ( @startTitle IS NULL )
        SELECT @startTitle = @oldStateTitle
      ELSE
      BEGIN
        IF @currentState = 2
        BEGIN
          /* Add event title change record for this state */
          INSERT eventChanges
            VALUES(@eventID, @currentState, 3)    /* 3 = title change */
          
          SELECT @lastError = @@error
          IF @lastError != 0
          BEGIN
            raiserror @lastError
            ROLLBACK TRAN updateEvent
            RETURN @lastError
          END
          
        END
      END
    
      IF NOT( @openWelcomeMsg1 IS NULL ) OR NOT ( @openWelcomeMsg2 IS NULL)
      BEGIN
        IF @currentState = 2
        BEGIN
          /* Add event welcome message change record for this state */
          INSERT eventChanges
            VALUES(@eventID, @currentState, 2)    /* 2 = welcome message change */
          
          SELECT @lastError = @@error
          IF @lastError != 0
          BEGIN
            raiserror @lastError
            ROLLBACK TRAN updateEvent
            RETURN @lastError
          END
          
        END
      END
    
      IF ( @startWelcomeMsg1 IS NULL )
        SELECT @startWelcomeMsg1 = @oldStateWelcomeMsg1
      IF ( @startWelcomeMsg2 IS NULL )
        SELECT @startWelcomeMsg2 = @oldStateWelcomeMsg2
      UPDATE eventState
        SET time = @startTime,
            PTGtitle = @startTitle,
            welcomeMsg1 = @startWelcomeMsg1,
            welcomeMsg2 = @startWelcomeMsg2
        WHERE eventID = @eventID AND
              stateID = 2
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        raiserror @lastError
        ROLLBACK TRAN updateEvent
        RETURN @lastError
      END
    END
    
    /* ------------------------ */
    /* do update of End State   */
    /* ------------------------ */
    IF ( ( @endTime IS NOT NULL ) OR
         ( @openTime IS NOT NULL )   )
    BEGIN
      /* get the current end time */
      SELECT @oldStateTime = time
        FROM eventState
        WHERE eventID = @eventID AND
              stateID = 3
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        raiserror @lastError
        ROLLBACK TRAN updateEvent
        RETURN @lastError
      END
    END
    IF ( @endTime IS NOT NULL )
    BEGIN
      /* update the end state */
      /* updates to state after its time has arrived
         are not permitted */
      IF ( @currentState = 3 )
      BEGIN
        ROLLBACK TRAN updateEvent
        RETURN 20003
      END
    
      IF ( @oldStateTime != @endTime )
      BEGIN
        UPDATE eventState
          SET time = @endTime
          WHERE eventID = @eventID AND
                stateID = 3
        SELECT @lastError = @@error
        IF @lastError != 0
        BEGIN
          raiserror @lastError
          ROLLBACK TRAN updateEvent
          RETURN @lastError
        END
      END
      
      SELECT @oldEndTime = @oldStateTime
    END /* update end state */
    ELSE
    BEGIN
      IF ( @openTime IS NOT NULL )
      BEGIN
        SELECT @endTime = @oldEndTime
      END
    END
    
    /* find if the time frame asked for is not booked already */
    IF ( ( @openTime IS NOT NULL ) AND
         ( ( @openTime != @oldOpenTime ) OR
           ( @endTime != @oldEndTime )      )  )
    BEGIN
      IF EXISTS 
        ( SELECT events.eventID
          FROM eventTimes, events
           WHERE eventTimes.eventID = events.eventID AND
                 events.eventID != @eventID          AND
                 events.auditorium = @newAuditorium  AND
                 ( ( startTime BETWEEN @openTime AND @endTime ) OR
                   ( endTime BETWEEN @openTime AND @endTime )    ) )
      BEGIN
        /* event overlaps other event(s) */
        ROLLBACK TRAN updateEvent
        RETURN 20002
      END
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        RAISERROR @lastError
        ROLLBACK TRAN updateEvent
        RETURN @lastError
      END
    END
    
    /* ------------------------------------ */
    /* do update of event interaction types */
    /* ------------------------------------ */
    IF ( @canUpdateInteractions = 1 )     AND /*Event not opened */
       ( @eventInteractions IS NOT NULL )
    BEGIN
      /* first, delete the current interaction types */
      DELETE interactionsAllowed
        WHERE eventID = @eventID
    
      /* parse list of interaction types */
      SELECT @counter = 1
      WHILE ( ascii( rtrim(ltrim(@eventInteractions ))) > 32 )
      BEGIN
        SELECT @commaPos = patindex( "%,%", @eventInteractions )
        IF @commaPos = 0 BEGIN
          SELECT @description = rtrim(ltrim(@eventInteractions))
          SELECT @eventInteractions = ""
        END
        ELSE BEGIN
          SELECT @description = 
              rtrim( ltrim( substring( @eventInteractions, 1, @commaPos-1) ) )
          SELECT @eventInteractions = 
            substring( @eventInteractions, 
                       @commaPos+1, 
                       char_length( @eventInteractions ) - @commaPos )
        END
    
        INSERT interactionsAllowed 
               ( eventID, interactionType, name )
          VALUES ( @eventID, @counter, @description )
        SELECT @lastError = @@error
        IF @lastError != 0
        BEGIN
          raiserror @lastError
          ROLLBACK TRAN updateEvent
          RETURN @lastError
        END
        SELECT @counter = @counter + 1
      END /* of while */
    END
  COMMIT TRAN updateEvent
END

go
IF OBJECT_ID('dbo.updateEvent') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.updateEvent >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.updateEvent >>>'
go

/* Updates an event vote description in the eventVotes table */
/* input:  voteId, vote title, vote description, number of choices allowed. 
   output: NONE
*/
CREATE PROC updateEventVote
(
  @voteID		numeric(10,0),
  @title		varchar(50),
  @description          varchar(200),
  @numChoices		integer
)
AS

  UPDATE eventVotes 
    SET title = @title, description = @description, numChoices = @numChoices
    WHERE voteID = @voteID
   

go
IF OBJECT_ID('dbo.updateEventVote') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.updateEventVote >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.updateEventVote >>>'
go

/* Updates an event vote option in the voteOptions table */
/* input:  voteId, vote option id, vote option, vote option description. 
   output: Errors:
            - 20001: Vote is active, cannot delete options
*/
CREATE PROC updateVoteOption
(
  @voteID		numeric(10,0),
  @voteOptionID		integer,
  @option		varchar(10),
  @description          varchar(50)
)
AS
BEGIN
  
  DECLARE @lastError    int
  DECLARE @status int

  /* Check that vote is not active */
  SELECT @status = status
    FROM eventVotes
    WHERE voteID = @voteID
  SELECT @lastError = @@error
  IF @lastError != 0
    RETURN @lastError

  IF @status = 1 
    RETURN 20001   /* Vote is active, cannot delete options */

  /* Update this option in the table */
  UPDATE voteOptions 
    SET label = @option, description = @description
    WHERE voteID = @voteID AND optionID = @voteOptionID
    
END

go
IF OBJECT_ID('dbo.updateVoteOption') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.updateVoteOption >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.updateVoteOption >>>'
go


--
-- CREATE TRIGGERS
--
/* delete all data related to an auditorium
   after that auditorium was deleted */
CREATE TRIGGER delAuditoriumData
  ON auditoriums
  FOR DELETE
AS
BEGIN
  DECLARE @lastError int
  
  /* delete related events */
  DELETE events
  FROM events, deleted
  WHERE events.auditorium = deleted.auditoriumID
  
  SELECT @lastError = @@error
  IF @lastError != 0
  BEGIN
    ROLLBACK TRAN
  END
  
  -- ****** hosts table is not in use ***
  -- /* delete related hosts */
  -- DELETE hosts
  -- FROM hosts, deleted
  -- WHERE hosts.auditoriumID = deleted.auditoriumID
  -- 
  -- SELECT @lastError = @@error
  -- IF @lastError != 0
  -- BEGIN
  --   ROLLBACK TRAN
  -- END
  
END

go
IF OBJECT_ID('delAuditoriumData') IS NOT NULL
    PRINT '<<< CREATED TRIGGER delAuditoriumData >>>'
ELSE
    PRINT '<<< FAILED CREATING TRIGGER delAuditoriumData >>>'
go

/* delete all data related to an event 
   after that event was deleted */
CREATE TRIGGER delEventData
  ON events
  FOR DELETE
AS
BEGIN
  /* delete related interaction types */
  DELETE interactionsAllowed
  FROM interactionsAllowed, deleted
  WHERE interactionsAllowed.eventID = deleted.eventID

  /* delete related interactions */
  DELETE eventInteractions
  FROM eventInteractions, deleted
  WHERE eventInteractions.eventID = deleted.eventID

  /* delete related hosts */
  DELETE hosts
  FROM hosts, deleted
  WHERE hosts.eventID = deleted.eventID

  /* delete related invitees */
  DELETE eventInvitees
  FROM eventInvitees, deleted
  WHERE eventInvitees.eventID = deleted.eventID

  /* delete related event states */
  DELETE eventState
  FROM eventState, deleted
  WHERE eventState.eventID = deleted.eventID

END

go
IF OBJECT_ID('delEventData') IS NOT NULL
    PRINT '<<< CREATED TRIGGER delEventData >>>'
ELSE
    PRINT '<<< FAILED CREATING TRIGGER delEventData >>>'
go

GRANT REFERENCES ON dbo.auditoriumChanges TO public
go
GRANT REFERENCES ON dbo.auditoriums TO public
go
GRANT REFERENCES ON dbo.eventChanges TO public
go
GRANT REFERENCES ON dbo.eventInteractions TO public
go
GRANT REFERENCES ON dbo.eventState TO public
go
GRANT REFERENCES ON dbo.events TO public
go
GRANT REFERENCES ON dbo.hosts TO public
go
GRANT REFERENCES ON dbo.interactionsAllowed TO public
go
GRANT REFERENCES ON dbo.stateTypes TO public
go
GRANT REFERENCES ON dbo.answers TO public
go
GRANT REFERENCES ON dbo.eventInvitees TO public
go
GRANT REFERENCES ON dbo.eventVotes TO public
go
GRANT REFERENCES ON dbo.interactionStatus TO public
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
GRANT SELECT ON dbo.auditoriumChanges TO public
go
GRANT SELECT ON dbo.auditoriums TO public
go
GRANT SELECT ON dbo.eventChanges TO public
go
GRANT SELECT ON dbo.eventInteractions TO public
go
GRANT SELECT ON dbo.eventState TO public
go
GRANT SELECT ON dbo.events TO public
go
GRANT SELECT ON dbo.hosts TO public
go
GRANT SELECT ON dbo.interactionsAllowed TO public
go
GRANT SELECT ON dbo.stateTypes TO public
go
GRANT SELECT ON dbo.answers TO public
go
GRANT SELECT ON dbo.eventInvitees TO public
go
GRANT SELECT ON dbo.eventVotes TO public
go
GRANT SELECT ON dbo.interactionStatus TO public
go
GRANT SELECT ON dbo.eventTimes TO public
go
GRANT SELECT ON dbo.eventsList TO public
go
GRANT SELECT ON dbo.lastStateChanges TO public
go
GRANT SELECT ON dbo.correctStates TO public
go
GRANT INSERT ON dbo.auditoriumChanges TO public
go
GRANT INSERT ON dbo.auditoriums TO public
go
GRANT INSERT ON dbo.eventChanges TO public
go
GRANT INSERT ON dbo.eventInteractions TO public
go
GRANT INSERT ON dbo.eventState TO public
go
GRANT INSERT ON dbo.events TO public
go
GRANT INSERT ON dbo.hosts TO public
go
GRANT INSERT ON dbo.interactionsAllowed TO public
go
GRANT INSERT ON dbo.stateTypes TO public
go
GRANT INSERT ON dbo.answers TO public
go
GRANT INSERT ON dbo.eventInvitees TO public
go
GRANT INSERT ON dbo.eventVotes TO public
go
GRANT INSERT ON dbo.interactionStatus TO public
go
GRANT INSERT ON dbo.eventTimes TO public
go
GRANT INSERT ON dbo.eventsList TO public
go
GRANT INSERT ON dbo.lastStateChanges TO public
go
GRANT INSERT ON dbo.correctStates TO public
go
GRANT DELETE ON dbo.auditoriumChanges TO public
go
GRANT DELETE ON dbo.auditoriums TO public
go
GRANT DELETE ON dbo.eventChanges TO public
go
GRANT DELETE ON dbo.eventInteractions TO public
go
GRANT DELETE ON dbo.eventState TO public
go
GRANT DELETE ON dbo.events TO public
go
GRANT DELETE ON dbo.hosts TO public
go
GRANT DELETE ON dbo.interactionsAllowed TO public
go
GRANT DELETE ON dbo.stateTypes TO public
go
GRANT DELETE ON dbo.answers TO public
go
GRANT DELETE ON dbo.eventInvitees TO public
go
GRANT DELETE ON dbo.eventVotes TO public
go
GRANT DELETE ON dbo.interactionStatus TO public
go
GRANT DELETE ON dbo.eventTimes TO public
go
GRANT DELETE ON dbo.eventsList TO public
go
GRANT DELETE ON dbo.lastStateChanges TO public
go
GRANT DELETE ON dbo.correctStates TO public
go
GRANT UPDATE ON dbo.auditoriumChanges TO public
go
GRANT UPDATE ON dbo.auditoriums TO public
go
GRANT UPDATE ON dbo.eventChanges TO public
go
GRANT UPDATE ON dbo.eventInteractions TO public
go
GRANT UPDATE ON dbo.eventState TO public
go
GRANT UPDATE ON dbo.events TO public
go
GRANT UPDATE ON dbo.hosts TO public
go
GRANT UPDATE ON dbo.interactionsAllowed TO public
go
GRANT UPDATE ON dbo.stateTypes TO public
go
GRANT UPDATE ON dbo.answers TO public
go
GRANT UPDATE ON dbo.eventInvitees TO public
go
GRANT UPDATE ON dbo.eventVotes TO public
go
GRANT UPDATE ON dbo.interactionStatus TO public
go
GRANT UPDATE ON dbo.eventTimes TO public
go
GRANT UPDATE ON dbo.eventsList TO public
go
GRANT UPDATE ON dbo.lastStateChanges TO public
go
GRANT UPDATE ON dbo.correctStates TO public
go
GRANT EXECUTE ON dbo.autobackup TO public
go
GRANT EXECUTE ON dbo.getAuditoriumsUpdates TO public
go
GRANT EXECUTE ON dbo.getEventList TO public
go
GRANT EXECUTE ON dbo.getEventsUpdates TO public
go
