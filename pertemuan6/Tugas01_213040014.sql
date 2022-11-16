-- MODUL 1
-- Jawaban case 1
select Sales.Customers.contactname, Sales.Customers.address
from Sales.Customers

-- Jawaban case 2
select Sales.Customers.contactname, Sales.Customers.address
from Sales.Customers
where Sales.Customers.country = 'France'

-- Jawaban case 3
select Sales.Customers.contactname, Sales.Customers.address
from Sales.Customers
where Sales.Customers.country = 'France'
and Sales.Customers.city = 'Paris'
or Sales.Customers.city = 'Nates'

-- Jawaban case 4
select count(Sales.Customers.custid) as 'jumlah_pelanggan', Sales.Customers.city
from Sales.Customers
where Sales.Customers.country = 'France'
group by Sales.Customers.city

-- Jawaban case 5
select count(Sales.Customers.custid) as 'jumlah_pelanggan'
from Sales.Customers
where Sales.Customers.country = 'France'
group by Sales.Customers.city
having count(Sales.Customers.custid) > 1

-- Jawaban case 6
SELECT contactname, city, country
FROM Sales.Customers
ORDER BY city DESC, country

-- Jawaban case 7
SELECT TOP(5) contactname, address
FROM Sales.Customers

-- Jawaban case 8
SELECT TOP(10) PERCENT contactname, address
FROM Sales.Customers

-- Jawaban case 9
SELECT contactname, address
FROM Sales.Customers
ORDER BY contactname
OFFSET 3 ROWS 
FETCH NEXT 3 ROWS ONLY

-- Jawaban case 10
SELECT 
    CASE categoryid
        WHEN 1 THEN 'KATEGORI A'
        WHEN 2 THEN 'KATEGORI B'
        WHEN 3 THEN 'KATEGORI C'
        WHEN 4 THEN 'KATEGORI D'
        WHEN 5 THEN 'KATEGORI E'
        WHEN 6 THEN 'KATEGORI F'
        WHEN 7 THEN 'KATEGORI G'
        WHEN 8 THEN 'KATEGORI H'
        ELSE 'TIDAK DIKETAHUI'
    END
AS 'NAMA KATEGORI'
FROM Production.Products

-- Jawaban case 11
SELECT Production.Products.productid, Production.Products.productname, Production.Products.categoryid, categoryname
FROM Production.Products INNER JOIN Production.Categories
ON Production.Products.productid = Production.Categories.categoryid

-- Jawaban case 12
SELECT contactname, companyname, orderid, orderdate, requireddate, shippeddate
FROM Sales.Customers
LEFT OUTER JOIN Sales.Orders
ON Sales.Customers.custid = Sales.Orders.custid

-- Jawaban case 13
SELECT TOP(3) shipcountry, AVG(freight) AS avgfreight
FROM Sales.Orders
WHERE orderdate >= '20070101' AND orderdate < '20080101'
GROUP BY shipcountry
ORDER BY avgfreight DESC

-- MODUL 2
-- Jawaban case 1
select country, region, city from HR.Employees
UNION ALL
SELECT country, region, city from Sales.Customers

-- Jawaban case 2
select country, region, city from HR.Employees
union 
select country, region, city from sales.customers

-- Jawaban case 3
select country, region, city from hr.Employees
INTERSECT
select country, region, city from Sales.Customers

-- Jawaban case 4
select country, region, city from HR.Employees
except 
select country, region, city from Sales.Customers

-- Jawaban case 5
select country, region, city from Sales.Customers
except 
select country, region, city from HR.Employees

-- Jawaban case 6
select country, region, city from Production.Suppliers
except
select country, region, city from Sales.Customers
intersect 
select country, region, city from HR.Employees

-- Jawaban case 7
select country, count(*) as numlocations 
from (select country, region, city from HR.Employees
        union
        select country, region, city from Sales.Customers) as U  
group by country

-- Jawaban case 8
select empid, orderid, orderdate 
from (select top(2) empid, orderid, orderdate from Sales.Orders
        where empid = 3
        order by orderdate desc, orderid desc) as D1
union all 
select empid, orderid, orderdate 
from (select top(2) empid, orderid, orderdate from Sales.Orders
        where empid = 5
        order by orderdate desc, orderid desc) as D2 

-- INSERT INTO
-- Jawaban case 9
insert into dbo.Orders(orderid, orderdate, empid, custid)
select orderid, orderdate, empid, custid 
from Sales.Orders
where shipcountry = 'UK'

-- SELECT INTO & BULK INSERT
-- Jawaban case 10
select orderid, orderdate, empid, custid 
into dbo.Orders 
from Sales.Orders

-- Jawaban case 11
bulk insert dbo.Orders from 'c:\\Users\\Lutfi\\Documents\\orders.txt'
with (
    datafiletype = 'char',
    fieldterminator = ',',
    rowterminator = '\n'
);

-- UPDATE
-- Jawaban case 12
UPDATE dbo.OrderDetails
SET discount += 0.5
FROM dbo.OrderDetails 
JOIN dbo.Orders 
ON dbo.OrderDetails.orderid = dbo.Orders.orderid
WHERE dbo.Orders.custid = 1

--  atau 
UPDATE dbo.OrderDetails
SET discount += 0.05
WHERE EXISTS (
    SELECT * 
    FROM dbo.Orders
    WHERE dbo.Orders.orderid = dbo.OrderDetails.orderid 
    AND dbo.Orders.custid = 1
)

-- DELETE
-- Jawaban case 13
delete from dbo.Orders
where orderdate < '20070101'

-- Jawaban case 14
truncate table dbo.Customers

-- jawaban case 15
delete from O
from dbo.Orders as O
    join dbo.Customers as C 
    on O.custid = C.custid
where C.country = N'USA'
SELECT * FROM dbo.Customers

-- MERGE
-- Jawaban case 16
MERGE INTO dbo.Customers AS TGT 
USING dbo.CustomersStage AS SRC 
ON TGT.custid = SRC.custid
WHEN MATCHED THEN 
    UPDATE SET
    TGT.companyname = SRC.companyname,
    TGT.phone = SRC.phone,
    TGT.address = SRC.address
WHEN NOT MATCHED THEN
    INSERT (custid, companyname, phone, address)
    VALUES (SRC.custid, SRC.companyname, SRC.phone, SRC.address)
WHEN NOT MATCHED BY SOURCE THEN 
    DELETE;

-- MODUL 3
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

-- Jawaban case 6
SELECT empid,
COUNT(CASE WHEN orderyear = 2007 THEN orderyear END) AS cnt2007,
COUNT(CASE WHEN orderyear = 2008 THEN orderyear END) AS cnt2008,
COUNT(CASE WHEN orderyear = 2009 THEN orderyear END) AS cnt2009
FROM (SELECT empid, YEAR(orderdate) AS orderyear FROM dbo.Orders) AS Ord
GROUP BY empid

-- Jawaban case 7
SELECT GROUPING_ID(empid, custid, YEAR(Orderdate)) AS groupingset,
empid, custid, YEAR(Orderdate) AS orderyear, SUM(qty) AS sumqty
FROM dbo.Orders
GROUP BY GROUPING SETS (
    (empid, custid, YEAR(orderdate)),
    (empid, YEAR(orderdate)),
    (custid, YEAR(orderdate))
)

-- MODUL 4
-- Jawaban case 1
INSERT INTO dbo.T1(datacol)
OUTPUT inserted.keycol, inserted.datacol
SELECT lastname
FROM HR.Employees
WHERE country = N'USA';

-- Jawaban case 2
DELETE FROM dbo.Orders
OUTPUT 
    deleted.orderid,
    deleted.orderdate,
    deleted.empid,
    deleted.custid
WHERE orderdate < '20080101'

-- Jawaban case 3
UPDATE dbo.OrderDetails
SET discount += 0.05
OUTPUT
    inserted.productid,
    deleted.discount AS olddiscount,
    inserted.discount AS newdiscount
WHERE productid = 51;

-- Jawaban case 4
MERGE INTO dbo.Customers AS TGT
USING dbo.CustomersStage AS SRC
ON TGT.custid = SRC.custid
WHEN MATCHED THEN
UPDATE SET
TGT.companyname = SRC.companyname,
TGT.phone = SRC.phone,
TGT.address = SRC.address
WHEN NOT MATCHED THEN
INSERT (custid, companyname, phone, address)
VALUES (SRC.custid, SRC.companyname, SRC.phone, SRC.address)
OUTPUT $action AS theaction, inserted.custid,
deleted.companyname AS oldcompanyname,
inserted.companyname AS newcompanyname,
deleted.phone AS oldphone,
inserted.phone AS newphone,
deleted.address AS oldaddress,
inserted.address AS newaddress;

-- Jawaban case 5
INSERT INTO dbo.ProductsAudit(productid, colname, oldval, newval)
SELECT productid, N'unitprice', oldval, newval
FROM (UPDATE dbo.Products
SET unitprice *= 1.15
OUTPUT
inserted.productid,
deleted.unitprice AS oldval,
inserted.unitprice AS newval
WHERE supplierid = 1) AS D
WHERE oldval < 20.0 AND newval >= 20.0;
SELECT * FROM dbo.ProductsAudit;