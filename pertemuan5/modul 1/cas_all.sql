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
SELECT TOP(10) contactname, address
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