-- 2.1 versi 2
IF OBJECT_ID('dbo.LihatSemuaIPS') IS NOT NULL DROP FUNCTION dbo.LihatSemuaIPS;
GO
CREATE FUNCTION dbo.LihatSemuaIPS(@npm VARCHAR(35))
RETURNS TABLE
AS RETURN
	SELECT M.npm, M.nama, T.tahun_ajaran, T.semester, K.ips
	FROM mahasiswa AS M
	JOIN krs AS K
		ON M.npm = K.npm
	JOIN tahun_akademik as T
		ON K.tahun_id = T.tahun_id
	WHERE M.npm = @npm

SELECT * FROM dbo.LihatSemuaIPS('1')