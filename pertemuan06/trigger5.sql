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