-- 2.1 versi 1
IF OBJECT_ID('dbo.LihatSemuaIPS') IS NOT NULL DROP FUNCTION dbo.LihatSemuaIPS;
GO
CREATE FUNCTION dbo.LihatSemuaIPS(@npm VARCHAR(35))
RETURNS @tempMahasiswa TABLE (
			npm VARCHAR(35) NOT NULL,
			nama VARCHAR(40) NOT NULL,
			tahun_ajaran VARCHAR(80) NOT NULL,
			semester VARCHAR(15) NOT NULL,
			ips VARCHAR(35) NOT NULL
			PRIMARY KEY(npm)
		)
AS
BEGIN
		INSERT INTO @tempMahasiswa(npm, nama, tahun_ajaran, semester, ips)
		SELECT M.npm, M.nama, T.tahun_ajaran, T.semester, K.ips
		FROM mahasiswa AS M
		JOIN krs AS K
		ON M.npm = K.npm
		JOIN tahun_akademik as T
		ON K.tahun_id = T.tahun_id
		WHERE M.npm = @npm
	RETURN;
END;

SELECT * FROM dbo.LihatSemuaIPS('1')