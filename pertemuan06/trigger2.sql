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
