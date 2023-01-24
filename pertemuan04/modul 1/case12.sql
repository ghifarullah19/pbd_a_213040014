-- Gunakan perintah UPDATE untuk memperbarui jumlah barang untuk
-- id-dosen=’ds-001’ menjadi Firman Syahputra

UPDATE dbo.dosen
SET nama_dosen = 'Firman Syahputra'
WHERE id_dosen = 'ds-001'

INSERT INTO dbo.dosen(id_dosen, nama_dosen, alamat_dosen, tanggal_lahir_dosen, no_telepon_dosen)
VALUES ('ds-006','Adang Dwi',' Jln Cisatu 1','1945-08-17','0818788946851')

DELETE FROM dbo.dosen
WHERE id_dosen = 'mhs-005'

SELECT * 
FROM dbo.dosen