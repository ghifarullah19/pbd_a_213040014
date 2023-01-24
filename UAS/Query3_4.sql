IF OBJECT_ID('dbo.HitungIPK') IS NOT NULL DROP PROCEDURE dbo.HitungIPK;
GO
CREATE PROCEDURE dbo.HitungIPK
    @npm VARCHAR(10)
AS
BEGIN
    DECLARE @ips FLOAT
    SET @ips = (
        SELECT SUM(ips)
        FROM krs
        WHERE npm = @npm
    )

    DECLARE @krs INT
    SET @krs = (
        SELECT COUNT(npm)
        FROM krs
        WHERE npm = @npm
    )

    DECLARE @ipk FLOAT
    SET @ipk = (@ips / @krs)

    UPDATE mahasiswa
    SET ipk = @ipk
    WHERE npm = @npm
END;

EXEC dbo.HitungIPK
@npm = '1'

SELECT * FROM mahasiswa