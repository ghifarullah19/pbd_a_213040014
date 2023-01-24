select count(Sales.Customers.custid) as 'jumlah_pelanggan'
from Sales.Customers
where Sales.Customers.country = 'France'
group by Sales.Customers.city
having count(Sales.Customers.custid) > 1