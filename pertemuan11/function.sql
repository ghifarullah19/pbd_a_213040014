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

SELECT
	empid, firstname, lastname, birthdate,
	dbo.GetAge(birthdate, SYSDATETIME()) AS age
FROM HR.Employees