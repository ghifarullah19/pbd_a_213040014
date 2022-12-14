BEGIN TRY
    PRINT 10/2;
    PRINT 'No error';
END TRY
BEGIN CATCH
    PRINT 'Error';
END CATCH;

BEGIN TRY
    PRINT 10/0;
    PRINT 'No error';
END TRY
BEGIN CATCH
    PRINT 'Error';
END CATCH;

IF OBJECT_ID('dbo.Employees') IS NOT NULL DROP TABLE dbo.Employees;
CREATE TABLE dbo.Employees
(
    empid INT NOT NULL,
    empname VARCHAR(25) NOT NULL,
    mgrid INT NULL,
    CONSTRAINT PK_Employees PRIMARY KEY(empid),
    CONSTRAINT CHK_Employees_empid CHECK(empid > 0),
    CONSTRAINT FK_Employees_Employees
    FOREIGN KEY(mgrid) REFERENCES dbo.Employees(empid)
);

BEGIN TRY
    INSERT INTO dbo.Employees(empid, empname, mgrid)
    VALUES(0, 'A', NULL);
    -- coba data empid = 0, 'A', NULL
END TRY
BEGIN CATCH
    IF ERROR_NUMBER() = 2627
        BEGIN
        PRINT ' Handling PK violation...';
        END
    ELSE IF ERROR_NUMBER() = 547
        BEGIN
        PRINT ' Handling CHECK/FK constraint violation...';
        END
    ELSE IF ERROR_NUMBER() = 515
        BEGIN
        PRINT ' Handling NULL violation...';
        END
    ELSE IF ERROR_NUMBER() = 245
        BEGIN
        PRINT ' Handling conversion error...';
        END
    BEGIN
        PRINT 'Re-throwing error...';
        THROW; -- SQL Server 2012 only
        END
            PRINT ' Error Number : ' + CAST(ERROR_NUMBER() AS VARCHAR(10));
            PRINT ' Error Message : ' + ERROR_MESSAGE();
            PRINT ' Error Severity: ' + CAST(ERROR_SEVERITY() AS VARCHAR(10));
            PRINT ' Error State : ' + CAST(ERROR_STATE() AS VARCHAR(10));
            PRINT ' Error Line : ' + CAST(ERROR_LINE() AS VARCHAR(10));
            PRINT ' Error Proc : ' + COALESCE(ERROR_PROCEDURE(), 'Not within proc');
END CATCH;