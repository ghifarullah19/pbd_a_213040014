-- 1
SELECT TOP(3) shipcountry, AVG(freight) AS avgfreight
FROM Sales.Orders
WHERE YEAR(orderdate) = '2015'
GROUP BY shipcountry
ORDER BY avgfreight DESC

-- 2
SELECT orderid, SUM(qty * unitprice) AS totalvalue
FROM Sales.OrderDetails
GROUP BY orderid
HAVING SUM(qty * unitprice) > 10000
ORDER BY SUM(qty * unitprice) DESC

-- 4
SELECT c.custid, companyname, o.orderid, orderdate
FROM Sales.Customers as c
INNER JOIN Sales.Orders as o
ON c.custid = o.custid
WHERE o.orderdate = '20160212';

-- 6
SELECT orderid, orderdate, custid, empid, DATEFROMPARTS(YEAR(orderdate), 12, 31) AS endofyear
FROM Sales.Orders
HAVING orderdate <> DATEFROMPARTS(YEAR(orderdate), 12, 31);

-- 3
SELECT c.custid, companyname, 
    CASE 
        WHEN orderdate IS NOT NULL THEN 'Yes'
        ELSE 'No' 
        END AS HasOrderOn20160212
FROM Sales.Customers as c
INNER JOIN Sales.Orders as o
ON c.custid = o.custid
WHERE o.orderdate = '20160212';