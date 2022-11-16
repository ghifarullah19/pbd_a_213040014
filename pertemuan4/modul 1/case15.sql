-- Satukanlah lokasi dari dosen dan mahasiswa yang berbeda-beda dari salah satu pada
-- kedua data tersebut.

SELECT id_dosen, nama_dosen, alamat_dosen FROM dbo.dosen
UNION ALL
SELECT id_mahasiswa, nama_mahasiswa, alamat_mahasiswa FROM dbo.mahasiswa