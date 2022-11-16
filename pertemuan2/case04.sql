select count(Sales.Customers.custid) as 'jumlah_pelanggan', Sales.Customers.city
from Sales.Customers
where Sales.Customers.country = 'France'
group by Sales.Customers.city