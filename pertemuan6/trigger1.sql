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
AFTER 
INSERT, DELETE
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