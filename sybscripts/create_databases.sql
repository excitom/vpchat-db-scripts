--------------------------------------------------------------------------------
-- DBArtisan Schema Extraction
-- TARGET DB:
-- 	audset,
-- 	vpplaces,
-- 	vpusers
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
