SELECT alamat_dosen
FROM dbo.dosen
EXCEPT
SELECT alamat_mahasiswa
FROM dbo.mahasiswa