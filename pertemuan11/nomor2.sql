IF OBJECT_ID('dbo.GetElement') IS NOT NULL DROP FUNCTION dbo.GetElement;
GO

CREATE FUNCTION dbo.GetElement(@custid as int)
RETURNS TABLE
AS
	RETURN
	(SELECT P.productname, O.qty
	FROM Production.Products as P
		INNER JOIN Sales.OrderDetails as O
		ON P.productid = O.productid
		INNER JOIN Sales.Orders AS OD
		ON O.orderid = OD.orderid
	WHERE OD.custid = @custid);
GO

SELECT * FROM dbo.GetElement(1)