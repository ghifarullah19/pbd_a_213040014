CREATE VIEW Sales.EmpOrders
WITH SCHEMABINDING
AS
SELECT
O.empid,
DATEADD(month, DATEDIFF(month, 0, O.orderdate), 0) AS ordermonth,
SUM(OD.qty) AS qty,
CAST(SUM(OD.qty * OD.unitprice * (1 - discount))
AS NUMERIC(12, 2)) AS val,
COUNT(*) AS numorders
FROM Sales.Orders AS O
JOIN Sales.OrderDetails AS OD
ON OD.orderid = O.orderid
GROUP BY empid, DATEADD(month, DATEDIFF(month, 0, O.orderdate), 0);
GO
IF OBJECT_ID('dbo.Orders', 'U') IS NOT NULL DROP TABLE dbo.Orders;
CREATE TABLE dbo.Orders
(
orderid INT NOT NULL,
orderdate DATE NOT NULL,
empid INT NOT NULL,
custid VARCHAR(5) NOT NULL,
qty INT NOT NULL,
CONSTRAINT PK_Orders PRIMARY KEY(orderid)
);
INSERT INTO dbo.Orders(orderid, orderdate, empid, custid, qty)
VALUES
(30001, '20070802', 3, 'A', 10),
(10001, '20071224', 2, 'A', 12),
(10005, '20071224', 1, 'B', 20),
(40001, '20080109', 2, 'A', 40),
(10006, '20080118', 1, 'C', 14),
(20001, '20080212', 2, 'B', 12),
(40005, '20090212', 3, 'A', 10),
(20002, '20090216', 1, 'C', 20),
(30003, '20090418', 2, 'B', 15),
(30004, '20070418', 3, 'C', 22),
(30007, '20090907', 3, 'D', 30);

-- Jawaban case 1
SELECT orderid, custid, val,
SUM(val) OVER() AS totalvalue,
SUM(val) OVER(PARTITION BY custid) AS custtotalvalue
FROM Sales.OrderValues
WHERE custid IN (1,2,3)

-- Jawaban case 2
SELECT ROW_NUMBER() OVER(ORDER BY custid ASC) AS "RowNum",
orderid, custid, val, 
SUM(val) OVER() AS totalvalue,
SUM(val) OVER(PARTITION BY custid) AS custtotalvalue
FROM Sales.OrderValues
WHERE custid IN(1,2,3)

-- Jawaban case 3
SELECT empid, ordermonth, val, 
SUM(val) OVER(PARTITION BY empid
ORDER BY ordermonth 
ROWS BETWEEN UNBOUNDED PRECEDING
AND CURRENT ROW) AS runval
FROM Sales.EmpOrders;

-- Jawaban case 4
SELECT custid, orderid, val,
ROW_NUMBER() OVER(ORDER BY val) AS rownum,
RANK() OVER(ORDER BY val) AS rank,
DENSE_RANK() OVER(ORDER BY val) AS dense_rank,
NTILE(100) OVER(ORDER BY val) AS ntile 
FROM Sales.OrderValues
ORDER BY val;

-- Jawaban case 5
SELECT custid, orderid, qty,
RANK() OVER(PARTITION BY custid ORDER BY qty) AS 'mk',
DENSE_RANK() OVER(PARTITION BY custid ORDER BY qty) as 'drnk'
FROM dbo.Orders;