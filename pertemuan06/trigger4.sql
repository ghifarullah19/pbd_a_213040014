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
