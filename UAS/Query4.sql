IF OBJECT_ID('dbo.Update_Total_SKS') IS NOT NULL DROP TRIGGER dbo.Update_Total_SKS;
GO
CREATE TRIGGER dbo.Update_Total_SKS
ON KHS
AFTER INSERT
AS
BEGIN
    DECLARE @in VARCHAR(30)
    SET @in = (
        SELECT krs_id
        FROM inserted
    )

    DECLARE @krsid INT
    SET @krsid = (
        SELECT COUNT(krs_id)
        FROM khs
        WHERE krs_id = @in
    )

    DECLARE @total_sks INT
       
    IF @krsid IS NULL
        BEGIN
            SET @total_sks = 0
        END
    ELSE
        BEGIN
            SET @total_sks = (
                SELECT sks
                FROM matakuliah
                JOIN khs
                ON matakuliah.id_matakuliah = khs.id_matakuliah
                JOIN inserted
                ON khs.khs_id = inserted.khs_id   
            )
        END
    
    UPDATE krs
    SET total_sks += @total_sks
    WHERE krs_id = @in
END;