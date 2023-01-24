IF OBJECT_ID('dbo.LihatTahunAktif') IS NOT NULL DROP FUNCTION dbo.LihatTahunAktif;
GO
CREATE FUNCTION dbo.LihatTahunAktif()
RETURNS VARCHAR(150)
AS
BEGIN
	DECLARE @isAktif INT
	DECLARE @aktif INT
	DECLARE @error VARCHAR(200)
	SET @isAktif = (
		SELECT COUNT(aktif)
		FROM tahun_akademik
		WHERE aktif = 1
	)
	IF @isAktif > 1
		RETURN N'semester tahun ajaran yang aktif lebih dari satu, tolong cek kembali dan pastikan hanya satu semester tahun ajaran yang aktif'
	SET @aktif = (
		SELECT tahun_ajaran
		FROM tahun_akademik
		WHERE aktif = 1
	)
	RETURN @aktif
END;

SELECT dbo.LihatTahunAktif()