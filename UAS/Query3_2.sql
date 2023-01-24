IF OBJECT_ID('dbo.EntriNilai') IS NOT NULL DROP PROCEDURE dbo.EntriNilai;
GO
CREATE PROCEDURE dbo.EntriNilai
    @krsid VARCHAR(20),
    @id_matakuliah VARCHAR(10),
    @nilai_kehadiran FLOAT,
    @nilai_tugas FLOAT,
    @nilai_uts FLOAT,
    @nilai_uas FLOAT
AS
BEGIN
    DECLARE @nilai_angka FLOAT 
    SET @nilai_angka = (0.1 * @nilai_kehadiran) + (0.4 * @nilai_tugas) + (0.25 * @nilai_uts) + (0.25 * @nilai_uas)

    DECLARE @nilai_huruf CHAR
    SET @nilai_huruf = (
        CASE 
            WHEN @nilai_angka >= 80 AND @nilai_angka <= 100 THEN 'A'
            WHEN @nilai_angka >= 70 AND @nilai_angka <= 79.99 THEN 'AB'
            WHEN @nilai_angka >= 60 AND @nilai_angka <= 69.99 THEN 'B'
            WHEN @nilai_angka >= 50 AND @nilai_angka <= 59.99 THEN 'BC'
            WHEN @nilai_angka >= 40 AND @nilai_angka <= 49.99 THEN 'C'
            WHEN @nilai_angka >= 30 AND @nilai_angka <= 39.99 THEN 'D'
            WHEN @nilai_angka >= 0 AND @nilai_angka <= 29.99 THEN 'E'
        END
    )

    DECLARE @bobot FLOAT
    SET @bobot = (
        CASE 
            WHEN @nilai_huruf = 'A' THEN 4
            WHEN @nilai_huruf = 'AB' THEN 3.5
            WHEN @nilai_huruf = 'B' THEN 3
            WHEN @nilai_huruf = 'BC' THEN 2.5
            WHEN @nilai_huruf = 'C' THEN 2
            WHEN @nilai_huruf = 'D' THEN 1
            WHEN @nilai_huruf = 'E' THEN 0
        END
    )

    UPDATE khs
    SET nilai_kehadiran = @nilai_kehadiran,
    nilai_tugas = @nilai_tugas,
    nilai_uts = @nilai_uts,
    nilai_uas = @nilai_uas,
    nilai_angka = @nilai_angka,
    nilai_huruf = @nilai_huruf,
    bobot_nilai_angka = @bobot
    WHERE krs_id = @krsid
    AND id_matakuliah = @id_matakuliah
END;

EXEC dbo.EntriNilai
@krsid = 'KRS-2023-4-1', @id_matakuliah = '9',
@nilai_kehadiran = 100, @nilai_tugas = 95,
@nilai_uts = 90, @nilai_uas = 85
EXEC dbo.EntriNilai
@krsid = 'KRS-2023-4-1', @id_matakuliah = '10',
@nilai_kehadiran = 95, @nilai_tugas = 100,
@nilai_uts = 90, @nilai_uas = 90
EXEC dbo.EntriNilai
@krsid = 'KRS-2023-4-1', @id_matakuliah = '11',
@nilai_kehadiran = 100, @nilai_tugas = 90,
@nilai_uts = 95, @nilai_uas = 80

SELECT * FROM khs