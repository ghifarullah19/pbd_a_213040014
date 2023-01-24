IF OBJECT_ID('dbo.HitungIPS') IS NOT NULL DROP PROCEDURE dbo.HitungIPS;
GO
CREATE PROCEDURE dbo.HitungIPS
    @tahun_id VARCHAR(10),
    @npm VARCHAR(9)
AS
BEGIN
    DECLARE @sks INT
    SET @sks = (
        SELECT SUM(MK.sks)
        FROM krs AS K
            JOIN tahun_akademik AS T
            ON K.tahun_id = T.tahun_id
            JOIN khs AS H
            ON K.krs_id = H.krs_id
            JOIN matakuliah AS MK
            ON H.id_matakuliah = MK.id_matakuliah
            JOIN mahasiswa AS M
            ON M.npm = K.npm
        WHERE T.tahun_id = @tahun_id
            AND M.npm = @npm
    )

    DECLARE @krsid VARCHAR(20)
    SET @krsid = (
        SELECT krs_id
        FROM krs AS K
            JOIN tahun_akademik AS T
            ON K.tahun_id = T.tahun_id
            JOIN mahasiswa AS M
            ON M.npm = K.npm
        WHERE T.tahun_id = @tahun_id
            AND M.npm = @npm
    )

    DECLARE @bobot FLOAT
    SET @bobot = (
        SELECT SUM(MK.sks * H.bobot_nilai_angka)
        FROM krs AS K
            JOIN tahun_akademik AS T
            ON K.tahun_id = T.tahun_id
            JOIN khs AS H
            ON K.krs_id = H.krs_id
            JOIN matakuliah AS MK
            ON H.id_matakuliah = MK.id_matakuliah
            JOIN mahasiswa AS M
            ON M.npm = K.npm
        WHERE T.tahun_id = @tahun_id
            AND M.npm = @npm
    )

    UPDATE krs
    SET ips = (@bobot/@sks)
    WHERE krs_id = @krsid
END;

EXEC dbo.HitungIPS
@tahun_id = '4', @npm = '1'

SELECT * FROM krs
SELECT * FROM khs