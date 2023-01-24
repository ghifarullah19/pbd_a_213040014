USE TSQLV4;

DROP DATABASE UAS;

CREATE DATABASE UAS;

USE UAS;

CREATE TABLE alamat (
	id_alamat VARCHAR(10) PRIMARY KEY NOT NULL,
	alamat VARCHAR(35) NOT NULL,
	kelurahan VARCHAR(35) NOT NULL,
	kecamatan VARCHAR(35) NOT NULL,
	provinsi VARCHAR(35) NOT NULL,
	kode_pos VARCHAR(35) NOT NULL,
	status VARCHAR(35) NOT NULL,
	kategori VARCHAR(35)
	);

CREATE TABLE tahun_akademik (
	tahun_id VARCHAR(10) PRIMARY KEY NOT NULL,
	tahun_ajaran INT NOT NULL,
	semester VARCHAR(15) NOT NULL,
	aktif INT NOT NULL
	);

CREATE TABLE matakuliah (
	id_matakuliah VARCHAR(10) PRIMARY KEY NOT NULL,
	nama VARCHAR(35) NOT NULL,
	deskripsi VARCHAR(35),
	nama_inggris VARCHAR(35),
	sks INT NOT NULL,
	semester INT NOT NULL
	);

CREATE TABLE wali (
	id_wali VARCHAR(10) PRIMARY KEY NOT NULL,
	nama VARCHAR(40) NOT NULL,
	handphone VARCHAR(20) UNIQUE NOT NULL,
	email VARCHAR(30) UNIQUE NOT NULL,
	pekerjaan VARCHAR(30) NOT NULL,
	jenis_kelamin VARCHAR(6) NOT NULL,
	id_alamat VARCHAR(10) FOREIGN KEY REFERENCES alamat(id_alamat)
	);

CREATE TABLE dosen (
	id_dosen VARCHAR(10) PRIMARY KEY NOT NULL,
	nama VARCHAR(40) NOT NULL,
	jenis_kelamin VARCHAR(6) NOT NULL,
	agama VARCHAR(12) NOT NULL,
	tanggal_diterima DATE,
	jabatan_fungsional VARCHAR(35),
	jabatan_struktural VARCHAR(35),
	professional VARCHAR(35),
	tanggal_pengesahan_professional DATE,
	bidang_keilmuan VARCHAR(35),
	id_alamat VARCHAR(10) FOREIGN KEY REFERENCES alamat(id_alamat)
	);

CREATE TABLE mahasiswa (
	npm VARCHAR(10) PRIMARY KEY NOT NULL,
	nama VARCHAR(40) NOT NULL,
	jenis_kelamin VARCHAR(6) NOT NULL,
	tanggal_lahir DATE NOT NULL,
	tempat_lahir VARCHAR(35) NOT NULL,
	agama VARCHAR(12) NOT NULL,
	tahun_masuk INT NOT NULL,
	status VARCHAR(12) NOT NULL,
	handphone VARCHAR(20) UNIQUE NOT NULL,
	email VARCHAR(35) UNIQUE NOT NULL,
	ipk FLOAT,
	id_dosen VARCHAR(10) FOREIGN KEY REFERENCES dosen(id_dosen),
	id_alamat VARCHAR(10) FOREIGN KEY REFERENCES alamat(id_alamat),
	id_wali VARCHAR(10) FOREIGN KEY REFERENCES wali(id_wali)
	);

CREATE TABLE krs (
	krs_id VARCHAR(20) PRIMARY KEY NOT NULL,
	tanggal_pengesahan DATE NOT NULL,
	total_sks INT NOT NULL,
	ips FLOAT NOT NULL DEFAULT 0,
	npm VARCHAR(10) FOREIGN KEY REFERENCES mahasiswa(npm),
	tahun_id VARCHAR(10) FOREIGN KEY REFERENCES tahun_akademik(tahun_id)
	);

CREATE TABLE khs (
	khs_id VARCHAR(20) PRIMARY KEY NOT NULL,
	nilai_kehadiran FLOAT NOT NULL DEFAULT 0,
	nilai_tugas FLOAT NOT NULL DEFAULT 0,
	nilai_uts FLOAT NOT NULL DEFAULT 0,
	nilai_uas FLOAT NOT NULL DEFAULT 0,
	nilai_angka FLOAT NOT NULL DEFAULT 0,
	nilai_huruf CHAR NOT NULL DEFAULT '-',
	bobot_nilai_angka FLOAT NOT NULL DEFAULT 0,
	krs_id VARCHAR(20) FOREIGN KEY REFERENCES krs(krs_id),
	id_matakuliah VARCHAR(10) FOREIGN KEY REFERENCES matakuliah(id_matakuliah)
	);

-- 1.	1.1 Check Constraint:
-- �	Kolom Agama di table mahasiswa:
ALTER TABLE Mahasiswa
ADD CONSTRAINT CK_Agama CHECK (Agama IN ('Islam', 'Kristen', 'Budha', 'Hindu', 'Kepercayaan'));
-- �	Kolom Tanggal Lahir:
ALTER TABLE Mahasiswa
ADD CONSTRAINT CK_tanggal_lahir CHECK (YEAR(tanggal_lahir) <= YEAR(SYSDATETIME()) - 15);

SELECT * FROM mahasiswa
-- �	Kolom Jenis kelamin di table mahasiswa, wali, dosen:
ALTER TABLE Mahasiswa
ADD CONSTRAINT CK_Jenis_KelaminMHS CHECK (jenis_kelamin IN ('Pria', 'Wanita'));
ALTER TABLE Wali
ADD CONSTRAINT CK_Jenis_KelaminDSN CHECK (jenis_kelamin IN ('Pria', 'Wanita'));
ALTER TABLE Dosen
ADD CONSTRAINT CK_Jenis_KelaminWLI CHECK (jenis_kelamin IN ('Pria', 'Wanita'));
ALTER TABLE Tahun_Akademik
ADD CONSTRAINT CK_Aktif CHECK (aktif IN (0, 1));

-- 1.2	Unique Constraint:
-- �	Pada table Mahasiswa (Email dan Handphone):
ALTER TABLE Mahasiswa
ADD CONSTRAINT UQ_Mahasiswa_Email UNIQUE (email);
ALTER TABLE Mahasiswa
ADD CONSTRAINT UQ_Mahasiswa_Handphone UNIQUE (handphone);
-- �	Pada table wali (Email dan Handphone):
ALTER TABLE wali
ADD CONSTRAINT UQ_Wali_Email UNIQUE (email);
ALTER TABLE wali
ADD CONSTRAINT UQ_Wali_Handphone UNIQUE (handphone);

INSERT INTO alamat(id_alamat, alamat, kelurahan, kecamatan, provinsi, kode_pos, [status], kategori)
VALUES ('1', 'Jl. RAYA A', 'RAYA A', 'RAYA A', 'Jawa Barat', '1111', '', ''),
('2', 'Jl. RAYA B', 'RAYA B', 'RAYA B', 'Jawa Barat', '2222', '', ''),
('3', 'Jl. RAYA C', 'RAYA C', 'RAYA C', 'Jawa Barat', '3333', '', ''),
('4', 'Jl. RAYA D', 'RAYA D', 'RAYA D', 'Jawa Barat', '4444', '', ''),
('5', 'Jl. RAYA E', 'RAYA E', 'RAYA E', 'Jawa Barat', '5555', '', '')

SELECT * FROM tahun_akademik

INSERT INTO tahun_akademik(tahun_id, tahun_ajaran, semester, aktif)
VALUES ('1', 2021, 'Ganjil', 0),
('2', 2022, 'Genap', 0),
('3', 2022, 'Sisipan', 0),
('4', 2023, 'Remedial Ganjil', 1),
('5', 2023, 'Remedial Genap', 0)

INSERT INTO matakuliah(id_matakuliah, nama, deskripsi, nama_inggris, sks, semester)
VALUES ('1', 'MATKUL A', 'NAMA MATKUL A', 'DESKRIPSI MATKUL A', 3, 1),
('2', 'MATKUL B', 'NAMA MATKUL B', 'DESKRIPSI MATKUL B', 2, 1),
('3', 'MATKUL C', 'NAMA MATKUL C', 'DESKRIPSI MATKUL C', 3, 1),
('4', 'MATKUL D', 'NAMA MATKUL D', 'DESKRIPSI MATKUL D', 2, 2),
('5', 'MATKUL E', 'NAMA MATKUL E', 'DESKRIPSI MATKUL E', 3, 2),
('6', 'MATKUL F', 'NAMA MATKUL F', 'DESKRIPSI MATKUL F', 2, 2),
('7', 'MATKUL G', 'NAMA MATKUL G', 'DESKRIPSI MATKUL G', 2, 3),
('8', 'MATKUL H', 'NAMA MATKUL H', 'DESKRIPSI MATKUL H', 3, 3),
('9', 'MATKUL I', 'NAMA MATKUL I', 'DESKRIPSI MATKUL I', 2, 4),
('10', 'MATKUL J', 'NAMA MATKUL J', 'DESKRIPSI MATKUL J', 3, 4),
('11', 'MATKUL K', 'NAMA MATKUL K', 'DESKRIPSI MATKUL K', 2, 4)

INSERT INTO wali(id_wali, nama, handphone, email, pekerjaan, jenis_kelamin, id_alamat)
VALUES ('1', 'WALI A', '081221214040', 'EMAIL A', 'KERJA A', 'Pria', '1'),
('2', 'WALI B', '081221214041', 'EMAIL B', 'KERJA B', 'Wanita', '2'),
('3', 'WALI C', '081221214042', 'EMAIL C', 'KERJA C', 'Pria', '4'),
('4', 'WALI D', '081221214043', 'EMAIL D', 'KERJA D', 'Wanita', '5')

INSERT INTO dosen(id_dosen, nama, jenis_kelamin, agama, tanggal_diterima, jabatan_fungsional, jabatan_struktural, professional, tanggal_pengesahan_professional, bidang_keilmuan, id_alamat)
VALUES ('1', 'DOSEN A', 'Pria', 'Islam', '20230101', 'JABATAN FUNGSIONAL A', 'JABATAN STRUKTURAL A', 'PROFESSIONAL A', '20220101', 'BIDANG KEILMUAN A', '1'),
('2', 'DOSEN B', 'Wanita', 'Kristen', '20230101', 'JABATAN FUNGSIONAL A', 'JABATAN STRUKTURAL A', 'PROFESSIONAL B', '20220101', 'BIDANG KEILMUAN B', '2'),
('3', 'DOSEN C', 'Pria', 'Hindu', '20230101', 'JABATAN FUNGSIONAL B', 'JABATAN STRUKTURAL B', 'PROFESSIONAL C', '20220101', 'BIDANG KEILMUAN C', '3'),
('4', 'DOSEN D', 'Wanita', 'Budha', '20230101', 'JABATAN FUNGSIONAL C', 'JABATAN STRUKTURAL C', 'PROFESSIONAL D', '20220101', 'BIDANG KEILMUAN D', '4'),
('5', 'DOSEN E', 'Pria', 'Kepercayaan', '20230101', 'JABATAN FUNGSIONAL C', 'JABATAN STRUKTURAL C', 'PROFESSIONAL E', '20220101', 'BIDANG KEILMUAN E', '5')

INSERT INTO mahasiswa(npm, nama, jenis_kelamin, tanggal_lahir, tempat_lahir, agama, tahun_masuk, [status], handphone, email, ipk, id_dosen, id_alamat, id_wali)
VALUES ('1', 'MHS A', 'Pria', '20020101', 'KOTA A', 'Islam', 2021, 'BELUM KAWIN', '08123456789', 'emailA@email.com', 0, '1', '1', '1'),
('2', 'MHS B', 'Wanita', '20020101', 'KOTA B', 'Kristen', 2020, 'BELUM KAWIN', '08123456780', 'emailB@email.com', 0, '2', '2', '2'),
('3', 'MHS C', 'Pria', '20000101', 'KOTA C', 'Hindu', 2021, 'BELUM KAWIN', '08123456781', 'emailC@email.com', 0, '3', '3', '3'),
('4', 'MHS D', 'Wanita', '20010101', 'KOTA D', 'Budha', 2020, 'BELUM KAWIN', '08123456782', 'emailD@email.com', 0, '4', '4', '4'),
('5', 'MHS E', 'Pria', '20030101', 'KOTA E', 'Kepercayaan', 2021, 'BELUM KAWIN', '08123456783', 'emailE@email.com', 0, '4', '5', NULL),
('6', 'MHS F', 'Wanita', '20030101', 'KOTA F', 'Islam', 2020, 'BELUM KAWIN', '08123456784', 'emailF@email.com', 0, '5', '1', NULL),
('7', 'MHS G', 'Pria', '20020101','KOTA G', 'Kristen', 2021, 'BELUM KAWIN', '08123456785', 'emailG@email.com', 0, '2', '2', NULL);