-- nomor 1
select empid, firstname, lastname, titleofcourtesy,
	case 
		when titleofcourtesy = 'Mr.' then 'Male'
		when titleofcourtesy = 'Ms.' or titleofcourtesy = 'Mrs.' then 'Female'
		else 'Unknown'
	end as gender
from HR.Employees

-- nomor 2
select c.custid, count(distinct o.orderid) as numorders, sum(od.qty) as totalqty
from ((sales.customers as c
	inner join sales.orders as o
		on c.custid = o.custid) 
	inner join sales.orderdetails as od
		on o.orderid = od.orderid)
where c.country = N'USA'
group by c.custid

-- nomor 3
SELECT C.custid, C.companyname, O.orderid, O.orderdate 
FROM Sales.Customers AS C   
INNER JOIN Sales.Orders AS O     
ON C.custid = O.custid;

-- nomor 4
select c.custid, c.companyname, o.orderid, o.orderdate
from sales.customers as c
	left join sales.orders as o
		on c.custid = o.custid

--nomor 5
select orderid, orderdate, custid, empid
from sales.orders
where orderdate = ( 
		select max(o.orderdate)
		from sales.orders as o)

-- nomor 6
select h.empid, h.Firstname, h.lastname
from hr.employees as h
where empid not in (
	select o.empid
	from sales.orders as o
	where o.orderdate >= '20160501'
)

-- nomor 8
SELECT orderid, orderdate, custid, empid,
  DATEFROMPARTS(YEAR(orderdate), 12, 31) AS endofyear 
FROM Sales.Orders 
WHERE orderdate <> DATEFROMPARTS(YEAR(orderdate), 12, 31);

-- nomor 9
WITH EmpsCTE AS
(
  SELECT empid, mgrid, firstname, lastname
  FROM HR.Employees
  WHERE empid = 9
  
  UNION ALL
  
  SELECT P.empid, P.mgrid, P.firstname, P.lastname
  FROM EmpsCTE AS C
    INNER JOIN HR.Employees AS P
      ON C.mgrid = P.empid
)
SELECT empid, mgrid, firstname, lastname
FROM EmpsCTE;

-- nomor 10
SELECT custid, empid
FROM Sales.Orders
WHERE orderdate >= '20160101' AND orderdate < '20160201'
INTERSECT
SELECT custid, empid
FROM Sales.Orders
WHERE orderdate >= '20160201' AND orderdate < '20160301'
EXCEPT
SELECT custid, empid
FROM Sales.Orders
WHERE orderdate >= '20150101' AND orderdate < '20160101'