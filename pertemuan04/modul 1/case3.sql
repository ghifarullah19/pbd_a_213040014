insert into dbo.dosen(id_dosen, nama_dosen, alamat_dosen)
select id_mahasiswa, nama_mahasiswa, alamat_mahasiswa
from dbo.mahasiswa
where id_mahasiswa = 'mhs-005'