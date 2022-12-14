DECLARE @i AS INT = 1;
WHILE @i <= 10
    BEGIN
        PRINT @i;
        SET @i = @i + 1;
    END;

DECLARE @j AS INT = 1;
WHILE @j <= 10
    BEGIN
        IF @j = 6 BREAK
            PRINT @j;
            SET @j = @j + 1;
    END;

DECLARE @k AS INT = 0;
WHILE @k < 10
    BEGIN
        SET @k += 1;
        IF @k = 6 CONTINUE;
        PRINT @k;
    END;

SET NOCOUNT ON;
DROP TABLE IF EXISTS dbo.Numbers;
CREATE TABLE dbo.Numbers(n INT NOT NULL PRIMARY KEY);
GO
DECLARE @i AS INT = 1;
WHILE @i <= 1000
    BEGIN
        INSERT INTO dbo.Numbers(n) VALUES(@i);
        SET @i = @i + 1;
    END;