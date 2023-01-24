IF OBJECT_ID('Sales.IncDiscount', 'P') IS NOT NULL
DROP PROC Sales.IncDiscount;
GO

CREATE PROCEDURE Sales.IncDiscount
    @custid AS INT,
    @discount AS NUMERIC(4,3)
AS
    UPDATE Sales.OrderDetails
    SET Sales.OrderDetails.discount -= @discount*10/100
        FROM Sales.OrderDetails
        INNER JOIN Sales.Orders
        ON Sales.OrderDetails.orderid = Sales.Orders.orderid
    WHERE Sales.Orders.custid = @custid;
GO

EXEC Sales.IncDiscount
@custid = 2,
@discount = 2;

SELECT Sales.Orders.custid, Sales.OrderDetails.*
FROM Sales.OrderDetails
    INNER JOIN Sales.Orders
    ON Sales.OrderDetails.orderid = Sales.Orders.orderid
ORDER BY Sales.Orders.custid;