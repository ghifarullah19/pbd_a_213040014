-- Munculkanlah lokasi-lokasi yang berbeda-beda tanpa ada duplikasi data untuk lokasi
-- yang terdapat pada dosen dan mahasiswa?

SELECT id_dosen, nama_dosen, alamat_dosen FROM dbo.dosen
UNION
SELECT id_mahasiswa, nama_mahasiswa, alamat_mahasiswa FROM dbo.mahasiswa

INSERT INTO dbo.dosen(id_dosen, nama_dosen, alamat_dosen)
SELECT id_mahasiswa, nama_mahasiswa, alamat_mahasiswa
FROM dbo.mahasiswa
WHERE id_mahasiswa = 'mhs-005'

SELECT * FROM dbo.dosen