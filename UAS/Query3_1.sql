IF OBJECT_ID('dbo.KontrakMK') IS NOT NULL DROP PROCEDURE dbo.KontrakMK;
GO
CREATE PROCEDURE dbo.KontrakMK
	@npm VARCHAR(35),
	@kode_mk VARCHAR(35)
AS
BEGIN
	DECLARE @tahun_ajaran INT
	SET @tahun_ajaran = dbo.LihatTahunAktif()

	DECLARE @tahun_id VARCHAR(5)
	SET @tahun_id = (
		SELECT tahun_id
	FROM tahun_akademik
	WHERE tahun_ajaran = @tahun_ajaran
		AND aktif = 1
	)

	DECLARE @semester INT
	SET @semester = (
		SELECT CASE
			WHEN semester = 'Ganjil' THEN 1
			WHEN semester = 'Genap' THEN 2
			WHEN semester = 'Sisipan' THEN 3
			WHEN semester = 'Remedial Ganjil' THEN 4
			WHEN semester = 'Remedial Genap' THEN 5
			END
	FROM tahun_akademik
	WHERE tahun_ajaran = @tahun_ajaran
		AND aktif = 1
	)

	DECLARE @krsid VARCHAR(20)
	SET @krsid = 'KRS-' + CAST(@tahun_ajaran AS VARCHAR(4)) + '-' + CAST(@semester AS VARCHAR(2)) + '-' + @npm
	DECLARE @khsid VARCHAR(30)
	SET @khsid = 'KHS-' + CAST(@tahun_ajaran AS VARCHAR(4)) + '-' + CAST(@semester AS VARCHAR(2)) + '-' + @npm + '-' + @kode_mk

	DECLARE @isKrs INT
	SET @isKrs = (
		SELECT COUNT(krs_id)
	FROM krs
	WHERE krs_id = @krsid
	)

	IF @isKrs = 0
		BEGIN
		INSERT INTO krs
			(krs_id, tanggal_pengesahan, total_sks, ips, npm, tahun_id)
		VALUES
			(@krsid, SYSDATETIME(), 0, 0, @npm, @tahun_id)
	END
	INSERT INTO khs
		(khs_id, nilai_kehadiran, nilai_tugas, nilai_uts, nilai_uas, nilai_angka, nilai_huruf, bobot_nilai_angka, krs_id, id_matakuliah)
	VALUES(@khsid, 0, 0, 0, 0, 0, '-', 0, @krsid, @kode_mk)
END;

EXEC dbo.KontrakMK
@npm = '4', @kode_mk = '9';
EXEC dbo.KontrakMK
@npm = '4', @kode_mk = '10';
EXEC dbo.KontrakMK
@npm = '4', @kode_mk = '11';

SELECT * FROM krs
SELECT * FROM khs