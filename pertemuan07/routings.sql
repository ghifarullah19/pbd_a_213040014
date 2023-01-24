IF OBJECT_ID('dbo.GetAge') IS NOT NULL DROP FUNCTION dbo.GetAge;
GO
CREATE FUNCTION dbo.GetAge
(
    @birthdate AS DATE,
    @eventdate AS DATE
)
RETURNS INT
AS
BEGIN
    RETURN
    DATEDIFF(year, @birthdate, @eventdate)
    - CASE WHEN 100 * MONTH(@eventdate) + DAY(@eventdate)
                    < 100 * MONTH(@birthdate) + DAY(@birthdate)
    THEN 1
    ELSE 0
    END;
END;
GO

SELECT empid, firstname, lastname, birthdate, dbo.GetAge(birthdate, SYSDATETIME()) AS age
FROM HR.Employees

IF OBJECT_ID('Sales.GetCustomerOrders', 'P') IS NOT NULL
DROP PROC Sales.GetCustomerOrders 
GO
CREATE PROC Sales.GetCustomerOrders
    @custid AS INT,
    @fromdate AS DATETIME = '19000101',
    @todate AS DATETIME = '99991231',
    @numrows AS INT OUTPUT
AS
    SET NOCOUNT ON;
    SELECT orderid, custid, empid, orderdate
    FROM Sales.Orders
    WHERE custid = @custid
    AND orderdate >= @fromdate
    AND orderdate < @todate
    SET @numrows = @@ROWCOUNT;
GO

DECLARE @rc AS INT
EXEC Sales.GetCustomerOrders
@custid = 1, @fromdate = '20070101',
@todate = '20080101',
@numrows = @rc OUTPUT;
SELECT @rc AS numrows;