select Sales.Customers.contactname, Sales.Customers.address
from Sales.Customers
where Sales.Customers.country = 'France'
and Sales.Customers.city = 'Paris'
or Sales.Customers.city = 'Nates'