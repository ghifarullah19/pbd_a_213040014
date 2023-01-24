-- EVENTDATA( )
    -- This function returns information about server or database events. 
    -- When an event notification fires, and the specified service broker 
    -- receives the results, EVENTDATA is called. 
    -- A DDL or logon trigger also support internal use of EVENTDATA.

IF OBJECT_ID('dbo.T1', 'U') IS NOT NULL DROP TABLE dbo.T1;
IF OBJECT_ID('dbo.AuditDDLEvents', 'U') IS NOT NULL
DROP TABLE dbo.AuditDDLEvents;
CREATE TABLE dbo.AuditDDLEvents
(
    audit_lsn INT NOT NULL IDENTITY,
    posttime DATETIME NOT NULL,
    eventtype sysname NOT NULL,
    loginname sysname NOT NULL,
    schemaname sysname NOT NULL,
    objectname sysname NOT NULL,
    targetobjectname sysname NULL,
    eventdata XML NOT NULL,
    CONSTRAINT PK_AuditDDLEvents PRIMARY KEY(audit_lsn)
);

CREATE TRIGGER trg_audit_ddl_events
ON DATABASE FOR DDL_DATABASE_LEVEL_EVENTS
AS
    SET NOCOUNT ON;
    DECLARE @eventdata AS XML = eventdata();
    INSERT INTO dbo.AuditDDLEvents(
        posttime, eventtype, loginname, schemaname,
        objectname, targetobjectname, eventdata)
    VALUES(
        @eventdata.value('(/EVENT_INSTANCE/PostTime)[1]', 'VARCHAR(23)'),
        @eventdata.value('(/EVENT_INSTANCE/EventType)[1]', 'sysname'),
        @eventdata.value('(/EVENT_INSTANCE/LoginName)[1]', 'sysname'),
        @eventdata.value('(/EVENT_INSTANCE/SchemaName)[1]', 'sysname'),
        @eventdata.value('(/EVENT_INSTANCE/ObjectName)[1]', 'sysname'),
        @eventdata.value('(/EVENT_INSTANCE/TargetObjectName)[1]', 'sysname'),
        @eventdata
        );
GO

CREATE TABLE dbo.T1(col1 INT NOT NULL PRIMARY KEY);
ALTER TABLE dbo.T1 ADD col2 INT NULL;
ALTER TABLE dbo.T1 ALTER COLUMN col2 INT NOT NULL;
CREATE NONCLUSTERED INDEX idx1 ON dbo.T1(col2);
SELECT * FROM dbo.AuditDDLEvents;