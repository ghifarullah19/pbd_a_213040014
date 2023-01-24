-- Buatlah tabel baru dengan nama dbo.kelasC,yang datanya diambil dari
-- dbo.mahasiswa

-- CREATE TABLE dbo.kelasC(
-- id_mahasiswa char(9) PRIMARY KEY NOT NULL,
-- nama_mahasiswa char(50) NOT NULL,
-- alamat_mahasiswa char(50) NOT NULL,
-- tanggal_lahir_mahasiswa DATE,
-- no_telepon_mahasiswa varchar(15),
-- angkatan_mahasiswa char(4)
-- );

INSERT INTO dbo.kelasC
SELECT * FROM dbo.mahasiswa

SELECT * FROM dbo.kelasC