IF OBJECT_ID('dbo.employee', 'U') IS NOT NULL DROP TABLE dbo.employee;
SELECT * INTO dbo.employee FROM HR.Employees;

CREATE TRIGGER trg_Employees_d 
ON dbo.employee 
FOR DELETE
AS
IF NOT EXISTS(SELECT * FROM deleted) RETURN; -- pengecekan data untuk menghentikan proses rekursif
DELETE E
FROM dbo.employee AS E
JOIN deleted AS M
ON E.mgrid = M.empid;
GO

delete from dbo.employee where empid = 1
select * from dbo.employee