SELECT contactname, companyname, orderid, orderdate, requireddate, shippeddate
FROM Sales.Customers
LEFT OUTER JOIN Sales.Orders
ON Sales.Customers.custid = Sales.Orders.custid