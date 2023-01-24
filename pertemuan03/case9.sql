SELECT alamat_dosen
FROM dbo.dosen
INTERSECT
SELECT alamat_mahasiswa
FROM dbo.mahasiswa