-- SQL Server Syntax  
-- Trigger on an INSERT, UPDATE, or DELETE statement to a table or view (DML Trigger)
CREATE [ OR ALTER ] TRIGGER [ schema_name . ]trigger_name   
ON { table | view }   
[ WITH <dml_trigger_option> [ ,...n ] ]  
{ FOR | AFTER | INSTEAD OF }   
{ [ INSERT ] [ , ] [ UPDATE ] [ , ] [ DELETE ] }   
[ WITH APPEND ]  
[ NOT FOR REPLICATION ]   
AS { sql_statement  [ ; ] [ ,...n ] | EXTERNAL NAME <method specifier [ ; ] > }  
  
<dml_trigger_option> ::=  
    [ ENCRYPTION ]  
    [ EXECUTE AS Clause ]  
  
<method_specifier> ::=  
    assembly_name.class_name.method_name  

-- SQL Server Syntax  
-- Trigger on an INSERT, UPDATE, or DELETE statement to a 
-- table (DML Trigger on memory-optimized tables)  
CREATE [ OR ALTER ] TRIGGER [ schema_name . ]trigger_name   
ON { table }   
[ WITH <dml_trigger_option> [ ,...n ] ]  
{ FOR | AFTER }   
{ [ INSERT ] [ , ] [ UPDATE ] [ , ] [ DELETE ] }   
AS { sql_statement  [ ; ] [ ,...n ] }  
  
<dml_trigger_option> ::=  
    [ NATIVE_COMPILATION ]  
    [ SCHEMABINDING ]  
    [ EXECUTE AS Clause ] 

-- Trigger on a CREATE, ALTER, DROP, GRANT, DENY, 
-- REVOKE or UPDATE statement (DDL Trigger)  
CREATE [ OR ALTER ] TRIGGER trigger_name   
ON { ALL SERVER | DATABASE }   
[ WITH <ddl_trigger_option> [ ,...n ] ]  
{ FOR | AFTER } { event_type | event_group } [ ,...n ]  
AS { sql_statement  [ ; ] [ ,...n ] | EXTERNAL NAME < method specifier >  [ ; ] }  
  
<ddl_trigger_option> ::=  
    [ ENCRYPTION ]  
    [ EXECUTE AS Clause ]

-- Trigger on a LOGON event (Logon Trigger)  
  
CREATE [ OR ALTER ] TRIGGER trigger_name   
ON ALL SERVER   
[ WITH <logon_trigger_option> [ ,...n ] ]  
{ FOR| AFTER } LOGON    
AS { sql_statement  [ ; ] [ ,...n ] | EXTERNAL NAME < method specifier >  [ ; ] }  
  
<logon_trigger_option> ::=  
    [ ENCRYPTION ]  
    [ EXECUTE AS Clause ]

-- Azure SQL Database Syntax   
-- Trigger on an INSERT, UPDATE, or DELETE statement to a table or view (DML Trigger)  
CREATE [ OR ALTER ] TRIGGER [ schema_name . ]trigger_name   
ON { table | view }   
 [ WITH <dml_trigger_option> [ ,...n ] ]   
{ FOR | AFTER | INSTEAD OF }   
{ [ INSERT ] [ , ] [ UPDATE ] [ , ] [ DELETE ] }   
  AS { sql_statement  [ ; ] [ ,...n ] [ ; ] > }  
  
<dml_trigger_option> ::=   
        [ EXECUTE AS Clause ]

-- Trigger 1
-- SET NOCOUNT { ON | OFF} 
    -- Stops the message that shows the count of the number of rows 
    -- affected by a Transact-SQL statement or stored procedure from 
    -- being returned as part of the result set.

IF OBJECT_ID('dbo.T1_Audit', 'U') IS NOT NULL DROP TABLE dbo.T1_Audit;
IF OBJECT_ID('dbo.T1', 'U') IS NOT NULL DROP TABLE dbo.T1;
CREATE TABLE dbo.T1
(
    keycol INT NOT NULL PRIMARY KEY,
    datacol VARCHAR(10) NOT NULL
);
CREATE TABLE dbo.T1_Audit
(
    audit_lsn INT NOT NULL IDENTITY PRIMARY KEY,
    dt DATETIME NOT NULL DEFAULT(SYSDATETIME()),
    login_name sysname NOT NULL DEFAULT(ORIGINAL_LOGIN()),
    keycol INT NOT NULL,
    datacol VARCHAR(10) NOT NULL,
    insertordelete CHAR(1) NOT NULL
);

CREATE TRIGGER dbo.trg_T1_insertordelete_audit 
ON dbo.T1
FOR AFTER INSERT, DELETE
AS
    SET NOCOUNT ON;
    INSERT INTO dbo.T1_Audit(keycol, datacol, insertordelete)
        SELECT keycol, datacol, 'I'
        FROM inserted
        UNION ALL
        SELECT keycol, datacol, 'D'
        FROM deleted
GO

INSERT INTO dbo.T1(keycol, datacol) VALUES(10, 'a');
INSERT INTO dbo.T1(keycol, datacol) VALUES(30, 'x');
INSERT INTO dbo.T1(keycol, datacol) VALUES(20, 'g');
DELETE FROM dbo.T1 WHERE keycol = 20
SELECT * FROM dbo.T1_Audit
SELECT * FROM dbo.T1

-- Trigger 2
-- DECLARE @nama_variable tipedata: 
    -- Variables are declared in the body of a batch or procedure with 
    -- the DECLARE statement and are assigned values by using either a 
    -- SET or SELECT statement. Cursor variables can be declared with 
    -- this statement and used with other cursor-related statements. 
    -- After declaration, all variables are initialized as NULL, 
    -- unless a value is provided as part of the declaration.

IF OBJECT_ID('dbo.T1', 'U') IS NOT NULL DROP TABLE dbo.T1;
CREATE TABLE dbo.T1
(
    keycol INT NOT NULL PRIMARY KEY,
    datacol VARCHAR(10) NOT NULL
);

CREATE TRIGGER trg_T1_iud 
ON dbo.T1 
FOR INSERT, UPDATE, DELETE
AS 
    DECLARE @i AS INT = 
        (SELECT COUNT(*) FROM (SELECT TOP(1) * FROM inserted) AS I);
    DECLARE @d AS INT = 
        (SELECT COUNT(*) FROM (SELECT TOP (1) * FROM deleted) AS D);
    IF @i = 1 AND @d = 1
        PRINT 'Telah terjadi pembaruan data, minimal satu baris';
    ELSE IF @i = 1 AND @d = 0
        PRINT 'Telah terjadi penyisipan data, minimal satu baris';
    ELSE IF @i = 0 AND @d = 1
        PRINT 'Telah terjadi penghapusan data, minimal satu baris';
    ELSE
        PRINT 'Tidak ada data yang terpengaruh';
GO

INSERT INTO dbo.T1(keycol, datacol) VALUES(10, 'a');
UPDATE dbo.T1 SET datacol = 'c' WHERE keycol = 10;
SELECT * FROM dbo.T1

-- Trigger 3
IF OBJECT_ID('dbo.employee', 'U') IS NOT NULL DROP TABLE dbo.employee;
SELECT * INTO dbo.employee FROM HR.Employees;

CREATE TRIGGER trg_Employees_d 
ON dbo.employee 
FOR DELETE
AS
IF NOT EXISTS(SELECT * FROM deleted) RETURN; -- pengecekan data untuk menghentikan proses rekursif
DELETE E
FROM dbo.employee AS E
JOIN deleted AS M
ON E.mgrid = M.empid;
GO

delete from dbo.employee where empid = 1
select * from dbo.employee

-- Trigger 4
SET NOCOUNT ON;
USE tempdb;
IF OBJECT_ID('dbo.T1', 'U') IS NOT NULL DROP TABLE dbo.T1;
IF OBJECT_ID('dbo.T1Audit', 'U') IS NOT NULL DROP TABLE dbo.T1Audit;
CREATE TABLE dbo.T1
(
    keycol INT NOT NULL PRIMARY KEY,
    intcol INT NULL,
    varcharcol VARCHAR(10) NULL
);
CREATE TABLE dbo.T1Audit
(
    lsn INT NOT NULL IDENTITY PRIMARY KEY, -- log serial number
    keycol INT NOT NULL,
    colname sysname NOT NULL,
    oldval SQL_VARIANT NULL,
    newval SQL_VARIANT NULL
);

CREATE TRIGGER trg_T1_u_audit 
ON dbo.T1 
FOR UPDATE
AS
-- jika baris yang diubah = 0, maka tidak akan melakukan apapun dan keluar dari trigger
IF NOT EXISTS(SELECT * FROM inserted) RETURN;
INSERT INTO dbo.T1Audit(keycol, colname, oldval, newval)
    SELECT *
    FROM (SELECT I.keycol, colname,
            CASE colname
                WHEN N'intcol' THEN CAST(D.intcol AS SQL_VARIANT)
                WHEN N'varcharcol' THEN CAST(D.varcharcol AS SQL_VARIANT)
            END AS oldval,
            CASE colname
                WHEN N'intcol' THEN CAST(I.intcol AS SQL_VARIANT)
                WHEN N'varcharcol' THEN CAST(I.varcharcol AS SQL_VARIANT)
            END AS newval
        FROM inserted AS I 
        JOIN deleted AS D
        ON I.keycol = D.keycol 
        CROSS JOIN 
            (SELECT N'intcol' AS colname
            UNION ALL 
            SELECT N'varcharcol') AS C) AS D
    WHERE oldval <> newval
        OR (oldval IS NULL AND newval IS NOT NULL)
        OR (oldval IS NOT NULL AND newval IS NULL);
GO

INSERT INTO dbo.T1(keycol, intcol, varcharcol) 
VALUES (1, 10, 'A'), (2, 20, 'B'), (3, 30, 'C');
SELECT * FROM dbo.T1;
UPDATE dbo.T1
SET varcharcol = varcharcol + 'X', intcol = 40 - intcol
WHERE keycol < 3;
SELECT * FROM dbo.T1;
SELECT * FROM dbo.T1Audit;

-- Trigger 5
-- SUBSTRING(expression, start, length)
    -- Returns part of a character, binary, text, or image expression in SQL Server.
-- MAX([ ALL | DISTINCT ] expression)
-- MAX([ ALL ] expression) OVER(<partition_by_clause> [ <order_by_clause> ])
    -- Returns the maximum value in the expression.
-- CAST (expression AS data_type [ ( length ) ])  
-- CONVERT ( data_type [ ( length ) ] , expression [ , style ] )  
    -- These functions convert an expression of one data type to another.
IF OBJECT_ID('dbo.Employee', 'U') IS NOT NULL DROP TABLE dbo.Employee;
CREATE TABLE dbo.Employee(
    id CHAR(10) PRIMARY KEY,
    name VARCHAR(50)
);
GO

INSERT INTO dbo.Employee(id, name) 
VALUES('1','Tubagus')

CREATE TRIGGER AutoIncrement_Trigger 
ON dbo.Employee 
INSTEAD OF INSERT 
AS
BEGIN
    DECLARE @ch CHAR
    DECLARE @num INT
    SELECT @num=SUBSTRING(MAX(id),2,1) FROM dbo.Employee
    SELECT @ch=SUBSTRING(MAX(id),1,1) FROM dbo.Employee
    IF @num=9
    BEGIN
        SET @num=0
        SET @ch= CHAR( ( 1 + ASCII(@ch) ))
    END
    INSERT INTO dbo.Employee (id,name) SELECT
    (@ch+CONVERT(VARCHAR(9),(@num+1))),inserted.name FROM inserted
END

INSERT INTO dbo.Employee(name) 
VALUES('Iwan')
INSERT INTO dbo.Employee(name) 
VALUES('Joni')
INSERT INTO dbo.Employee(name) 
VALUES('Asep')
SELECT * FROM dbo.Employee

-- Trigger 6
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
ON DATABASE 
FOR DDL_DATABASE_LEVEL_EVENTS
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