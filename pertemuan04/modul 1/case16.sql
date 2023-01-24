-- Munculkanlah lokasi-lokasi yang berbeda-beda tanpa ada duplikasi data untuk lokasi
-- yang terdapat pada dosen tetapi tidak terdapat di mahasiswa?

SELECT id_dosen, nama_dosen, alamat_dosen FROM dbo.dosen
EXCEPT
SELECT id_mahasiswa, nama_mahasiswa, alamat_mahasiswa FROM dbo.mahasiswa