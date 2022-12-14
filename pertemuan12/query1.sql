USE TSQLV4;

DECLARE @empname AS NVARCHAR(61);
SET @empname = (SELECT firstname + N' ' + lastname
            FROM HR.Employees
            where empid = 3);
select @empname as empname;

declare @firstname as nvarchar(20), @lastname as nvarchar(40);
set @firstname = (select firstname
            from hr.Employees
            where empid = 3);
set @lastname = (select lastname
            from hr.Employees
            where empid = 3);
select @firstname as firstname, @lastname AS lastname;

declare @firstname1 as nvarchar(20), @lastname1 as nvarchar(40);
select 
    @firstname1 = firstname,
    @lastname1 = lastname
from hr.Employees
where empid = 3
select @firstname1 as firstnaem, @lastname1 as lastname;

DECLARE @empname1 AS NVARCHAR(61);
SELECT @empname1 = firstname + N' ' + lastname
FROM HR.Employees
WHERE mgrid = 2;
SELECT @empname1 AS empname;

select firstname,lastname from hr.Employees where mgrid = 2;
