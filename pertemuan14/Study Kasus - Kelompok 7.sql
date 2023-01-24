-- Study Kasus Kelompok 7
-- Fowaz Amran Alfarez				- 213040008
-- Muhammad Lutfi Amin Ghifarullah	- 213040014
-- Mohammad Deandra Adhitya			- 213040026
-- Fauzi Ilyas Nuryadi				- 213040032
-- Gilman Arif Firmansyah			- 213040037

-- STRUKTUR DATA
CREATE DATABASE Studi_Kasus;

USE Studi_Kasus;

CREATE TABLE Diskon (
Diskon_ID VARCHAR(35) NOT NULL,
Persen_Diskon INT NOT NULL,
Tanggal_Awal_Berlaku DATE NOT NULL,
Tanggal_Akhir_Berlaku DATE NOT NULL,
MinQty INT NOT NULL,
Deskripsi NVARCHAR(60) NOT NULL,
PRIMARY KEY (Diskon_ID)
);
CREATE TABLE Diskon_Produk (
Diskon_Produk_ID VARCHAR(35) NOT NULL,
DiskonDiskon_ID VARCHAR(35) NOT NULL,
ProdukProduk_ID VARCHAR(35) NOT NULL,
PRIMARY KEY (Diskon_Produk_ID)
);
CREATE TABLE Gerai (
Gerai_ID VARCHAR(35) NOT NULL,
Nama_Cabang NVARCHAR(40) NOT NULL,
Tanggal_Pembukaan timestamp NOT NULL,
Alamat NVARCHAR(60) NOT NULL,
Kelurahan NVARCHAR(40) NOT NULL,
Kecamatan NVARCHAR(40) NOT NULL,
Kabupaten_Kota NVARCHAR(40) NOT NULL,
Provinsi NVARCHAR(40) NOT NULL,
PRIMARY KEY (Gerai_ID)
);
CREATE TABLE Jabatan (
Jabatan_ID VARCHAR(35) NOT NULL,
Nama_Jabatan NVARCHAR(80) NOT NULL,
Deskripsi NVARCHAR(60) NOT NULL,
PRIMARY KEY (Jabatan_ID)
);
CREATE TABLE Jenis_Member (
Jenis_Member_ID VARCHAR(35) NOT NULL,
Nama_Jenis_Member NVARCHAR(80) NOT NULL,
Min_Trans NVARCHAR(20) NOT NULL,
Deskripsi NVARCHAR(60) NOT NULL,
PRIMARY KEY (Jenis_Member_ID)
);
CREATE TABLE Member (
Member_ID VARCHAR(35) NOT NULL,
No_KTP NVARCHAR(20) NOT NULL UNIQUE,
Nama NVARCHAR(80) NOT NULL,
Jenis_Kelamin NVARCHAR(20) NOT NULL,
Alamat NVARCHAR(60) NOT NULL,
Kelurahan NVARCHAR(40) NOT NULL,
Kecamatan NVARCHAR(40) NOT NULL,
Kabupaten_Kota NVARCHAR(40) NOT NULL,
Provinsi NVARCHAR(40) NOT NULL,
Tanggal_Daftar_Member DATE NOT NULL,
Tanggal_Kadaluarsa_Member DATE NOT NULL,
No_Kontak NVARCHAR(20) NOT NULL UNIQUE,
Jenis_MemberJenis_Member_ID VARCHAR(35) NOT NULL,
PRIMARY KEY (Member_ID)
);
CREATE TABLE Pegawai (
Pegawai_ID VARCHAR(35) NOT NULL,
Nama NVARCHAR(80) NOT NULL,
Jenis_Kelamin NVARCHAR(20) NOT NULL,
Tanggal_Lahir DATE NOT NULL,
Tanggal_Diterima DATE NOT NULL,
Alamat NVARCHAR(60) NOT NULL,
Kelurahan NVARCHAR(40) NOT NULL,
Kecamatan NVARCHAR(40) NOT NULL,
Kabupaten_Kota NVARCHAR(40) NOT NULL,
Provinsi NVARCHAR(40) NOT NULL,
Lulusan_Pendidikan NVARCHAR(20) NOT NULL,
Honor MONEY NOT NULL,
Status_Pernikahan NVARCHAR(20) NOT NULL,
Jumlah_Anak INT NOT NULL,
Jenis_Pegawai NVARCHAR(20) NOT NULL,
GeraiGerai_ID VARCHAR(35) NOT NULL,
JabatanJabatan_ID VARCHAR(35) NOT NULL,
Atasan_ID VARCHAR(35) NOT NULL,
PRIMARY KEY (Pegawai_ID)
);
CREATE TABLE Pengiriman (
Pengiriman_ID VARCHAR(35) NOT NULL,
Tanggal_Pengiriman DATE NOT NULL,
Tanggal_Penerimaan DATE NOT NULL,
Nama_Penerima NVARCHAR(80) NOT NULL,
Alamat NVARCHAR(60) NOT NULL,
Kelurahan NVARCHAR(40) NOT NULL,
Kecamatan NVARCHAR(40) NOT NULL,
Kabupaten_Kota NVARCHAR(40) NOT NULL,
Provinsi NVARCHAR(40) NOT NULL,
PegawaiPegawai_ID VARCHAR(35) NOT NULL,
PenjualanNo_Transaksi VARCHAR(35) NOT NULL,
PRIMARY KEY (Pengiriman_ID)
);
CREATE TABLE Penjualan (
No_Transaksi VARCHAR(35) NOT NULL,
Tanggal_Transaksi DATE NOT NULL,
Total_Pembayaran MONEY NOT NULL,
Jenis_Pembayaran NVARCHAR(20) NOT NULL,
PegawaiPegawai_ID VARCHAR(35) NOT NULL,
MemberMember_ID VARCHAR(35) NULL,
PRIMARY KEY (No_Transaksi)
);
CREATE TABLE Produk (
Produk_ID VARCHAR(35) NOT NULL,
Nama_Produk NVARCHAR(80) NOT NULL,
Jenis_Produk NVARCHAR(20) NOT NULL,
Tanggal_Kadaluarsa DATE NOT NULL,
Berat INT NOT NULL,
Satuan_Berat VARCHAR(5) NOT NULL,
Sumber_Produk NVARCHAR(40) NOT NULL,
Harga_Satuan MONEY NOT NULL,
ProdukProduk_ID VARCHAR(35) NOT NULL,
SupplierSupplier_ID VARCHAR(35) NOT NULL,
PRIMARY KEY (Produk_ID)
);
CREATE TABLE Rincian_Penjualan (
Rincian_ID VARCHAR(35) NOT NULL,
Harga_Satuan MONEY NOT NULL,
jumlah_penjualan INT NOT NULL,
Nominal_Diskon INT NOT NULL,
Total_Biaya_Per_Produk AS (harga_satuan * jumlah_penjualan) - Nominal_Diskon,
PenjualanNo_Transaksi VARCHAR(35) NULL,
ProdukProduk_ID VARCHAR(35) NOT NULL,
Diskon_ProdukDiskon_Produk_ID VARCHAR(35) NULL,
PRIMARY KEY (Rincian_ID)
);
CREATE TABLE Supplier (
Supplier_ID VARCHAR(35) NOT NULL,
Nama_Supplier NVARCHAR(80) NOT NULL,
Alamat NVARCHAR(60) NOT NULL,
Kelurahan NVARCHAR(40) NOT NULL,
Kecamatan NVARCHAR(40) NOT NULL,
Kabupaten_Kota NVARCHAR(40) NOT NULL,
Provinsi NVARCHAR(40) NOT NULL,
No_Kontak NVARCHAR(20) NOT NULL UNIQUE,
PRIMARY KEY (Supplier_ID)
);
ALTER TABLE Rincian_Penjualan
ADD CONSTRAINT FKRincian_Pe641973 FOREIGN KEY
(Diskon_ProdukDiskon_Produk_ID)
REFERENCES Diskon_Produk (Diskon_Produk_ID);
ALTER TABLE Diskon_Produk
ADD CONSTRAINT FKDiskon_Pro616815 FOREIGN KEY (ProdukProduk_ID)
REFERENCES Produk (Produk_ID);
ALTER TABLE Diskon_Produk
ADD CONSTRAINT FKDiskon_Pro543845 FOREIGN KEY (DiskonDiskon_ID)
REFERENCES Diskon (Diskon_ID);
ALTER TABLE Produk
ADD CONSTRAINT FKProduk121103 FOREIGN KEY (SupplierSupplier_ID)
REFERENCES Supplier (Supplier_ID);
ALTER TABLE Rincian_Penjualan
ADD CONSTRAINT FKRincian_Pe767564 FOREIGN KEY (ProdukProduk_ID)
REFERENCES Produk (Produk_ID);
ALTER TABLE Rincian_Penjualan
ADD CONSTRAINT FKRincian_Pe256002 FOREIGN KEY (PenjualanNo_Transaksi)
REFERENCES Penjualan (No_Transaksi);
ALTER TABLE Member
ADD CONSTRAINT FKMember315319 FOREIGN KEY (Jenis_MemberJenis_Member_ID)
REFERENCES Jenis_Member (Jenis_Member_ID);
ALTER TABLE Penjualan
ADD CONSTRAINT FKPenjualan559490 FOREIGN KEY (MemberMember_ID)
REFERENCES Member (Member_ID);
ALTER TABLE Pengiriman
ADD CONSTRAINT FKPengiriman392349 FOREIGN KEY (PenjualanNo_Transaksi)
REFERENCES Penjualan (No_Transaksi);
ALTER TABLE Penjualan
ADD CONSTRAINT FKPenjualan440803 FOREIGN KEY (PegawaiPegawai_ID)
REFERENCES Pegawai (Pegawai_ID);
ALTER TABLE Pengiriman
ADD CONSTRAINT FKPengiriman185161 FOREIGN KEY (PegawaiPegawai_ID)
REFERENCES Pegawai (Pegawai_ID);
ALTER TABLE Pegawai
ADD CONSTRAINT FKPegawai548309 FOREIGN KEY (Atasan_ID)
REFERENCES Pegawai (Pegawai_ID);
ALTER TABLE Pegawai
ADD CONSTRAINT FKPegawai726894 FOREIGN KEY (JabatanJabatan_ID)
REFERENCES Jabatan (Jabatan_ID);
ALTER TABLE Pegawai
ADD CONSTRAINT FKPegawai935947 FOREIGN KEY (GeraiGerai_ID)
REFERENCES Gerai (Gerai_ID);

-- QUERY INSERT DATA
INSERT INTO Pegawai(Pegawai_ID, Nama, Jenis_Kelamin, Tanggal_Lahir, Tanggal_Diterima, Alamat, Kelurahan,
Kecamatan, Kabupaten_Kota, Provinsi, Lulusan_Pendidikan, Honor, Status_Pernikahan, Jumlah_Anak, Jenis_Pegawai,
GeraiGerai_ID, JabatanJabatan_ID, Atasan_ID)
VALUES	('1', 'Lutfi', 'Pria', '20021011', '20221011', 'Jl. Sarijadi', 'Sukawarna', 
'Sukajadi', 'Bandung', 'Jawa Barat', 'S1', 25000000, 'Belum Nikah', 0, 'Manager', '1', '1', '1'),
('2', 'Fowaz', 'Pria', '20000110', '20221011', 'Jl. Cimahi', 'Cimahi', 
'Cimahi', 'Cimahi', 'Jawa Barat', 'S1', 20000000, 'Belum Nikah', 0, 'Wakil Manager', '1', '2', '1'),
('3', 'Malwi', 'Pria', '20000404', '20221011', 'Jl. Gerlong', 'Gerlong', 
'Gerlong', 'Bandung', 'Jawa Barat', 'S1', 20000000, 'Belum Nikah', 0, 'Wakil Manager', '1', '2', '1'),
('4', 'Adit', 'Pria', '20020608', '20221011', 'Jl. Cimahi', 'Cimahi', 
'Cimahi', 'Cimahi', 'Jawa Barat', 'S1', 8000000, 'Belum Nikah', 0, 'Kasir', '1', '3', '1'),
('5', 'Gilman', 'Pria', '20020701', '20221011', 'Jl. Cileunyi', 'Cileunyi', 
'Cileunyi', 'Bandung', 'Jawa Barat', 'S1', 8000000, 'Belum Nikah', 0, 'Kasir', '1', '3', '1'),
('6', 'Fauzi', 'Pria', '20020806', '20221011', 'Jl. Gerlong', 'Gerlong', 
'Gerlong', 'Bandung', 'Jawa Barat', 'S1', 8000000, 'Belum Nikah', 0, 'Kasir', '1', '3', '1');

INSERT INTO Jabatan(Jabatan_ID, Nama_Jabatan, Deskripsi)
VALUES ('1', 'Manager', 'Atasan dari seluruh pegawai'),
('2', 'Wakil Manager', 'Wakil dari Manager'),
('3', 'Kasir', 'Bertanggung jawab dalam proses transaksi');

INSERT INTO Gerai(Gerai_ID, Nama_Cabang, Tanggal_Pembukaan, Alamat, Kelurahan, Kecamatan, Kabupaten_Kota, Provinsi)
VALUES ('1', 'Toko Pertama', '20220701', 'Jl. Sarijadi', 'Sukawarna', 'Sukajadi', 'Bandung', 'Jawa Barat');

INSERT INTO Produk
VALUES ('1', 'Produk A', 'Makanan', '20231231', 200, 'mg', 'Perusahaan A', 10000, '1', '1');

INSERT INTO Supplier(Supplier_ID, Nama_Supplier, Alamat, Kelurahan, Kecamatan, Kabupaten_Kota, Provinsi, No_Kontak)
VALUES ('1', 'Perusahaan A', 'Jl. Cileunyi', 'Cileunyi', 'Cileunyi', 'Bandung', 'Jawa Barat', '081122334455');

INSERT INTO Diskon(Diskon_ID, Persen_Diskon, Tanggal_Awal_Berlaku, Tanggal_Akhir_Berlaku, MinQty, Deskripsi)
VALUES ('1', 50, '20221201', '20230201', 5, 'Promo pergantian tahun.');

INSERT INTO Diskon_Produk(Diskon_Produk_ID, DiskonDiskon_ID, ProdukProduk_ID)
VALUES ('1', '1', '1');

-- NOMOR 1.1
SELECT * FROM dbo.rincian_penjualan;

ALTER TABLE dbo.rincian_penjualan
 ADD total_biaya_per_produk AS (harga_satuan * jumlah_penjualan) - nominal_diskon PERSISTED;

ALTER TABLE dbo.rincian_penjualan
 DROP COLUMN total_biaya_per_produk;

-- NOMOR 1.2
--Nilai di Kolom/ Atribut Jenis_kelamin pada member harus Perempuan atau Pria
SELECT * FROM dbo.member;
ALTER TABLE dbo.member
 ADD CONSTRAINT CHK_JenisKelamin CHECK (jenis_kelamin = 'Perempuan' OR jenis_kelamin = 'Pria');

--Nilai di Kolom/ Atribut pernikahan pada pegawai harus Nikah atau Belum Nikah
SELECT * FROM dbo.pegawai;
ALTER TABLE dbo.pegawai
 ADD CONSTRAINT CHK_StatusPernikahan CHECK (status_pernikahan = 'Nikah' OR status_pernikahan =  'Belum Nikah');

--Nilai di Kolom/ Atribut Jumlah_anak pada entitas pegawai harus berisi 0 Jika status pernikahan Belum Nikah
SELECT * FROM dbo.pegawai;
ALTER TABLE dbo.pegawai
 ADD CONSTRAINT CHK_JumlahAnak CHECK (jumlah_anak=CASE WHEN status_pernikahan='belum menikah' THEN '0' END );

--Nilai di Kolom/ Atribut Persen_Diskon pada entitas diskon harus berisikan nilai dari 0 - 100
SELECT * FROM dbo.diskon;
ALTER TABLE dbo.diskon
 ADD CONSTRAINT CHK_PersenDiskon CHECK(percent_diskon >= 0 AND percent_diskon <= 100 );

--Nilai harus lebih dari 0 untuk Kolom/ Atribut berikut:
--MinQty pada entitas diskon
--harga_satuan pada Rincian_Penjualan
--Nominal_Diskon pada Rincian_Penjualan
--Total_Biaya_Per_Produk pada Rincian_Penjualan
--harga_satuan pada Produk

  /* o	MinQty pada entitas diskon */
 SELECT * FROM dbo.diskon;
 ALTER TABLE dbo.diskon
  ADD CHECK (MinQty > 0);
  /* o harga_satuan pada Rincian_Penjualan */
SELECT * FROM dbo.rincian_penjualan;
ALTER TABLE dbo.rincian_penjualan
 ADD CHECK (harga_satuan > 0);
 /* o Nominal_Diskon pada Rincian_Penjualan */
SELECT * FROM dbo.rincian_penjualan;
ALTER TABLE dbo.rincian_penjualan
 ADD CHECK (nominal_diskon > 0);
 /* Total_Biaya_Per_Produk pada Rincian_Penjualan */
SELECT * FROM dbo.rincian_penjualan;
ALTER TABLE dbo.rincian_penjualan
 ADD CHECK (total_biaya_per_produk > 0);
 /* harga_satuan pada Produk */
SELECT * FROM dbo.produk;
ALTER TABLE dbo.produk
 ADD CHECK(harga_satuan > 0);

--NOMOR 1.3
--Entitas Member
--Kolom/ Atribut No_KTP
--Kolom/ Atribut No_Kontak
SELECT * FROM dbo.member;
ALTER TABLE dbo.member
 ADD CONSTRAINT UC_Member UNIQUE (no_ktp, no_kontak);

--Entitas Supplier
--Kolom/Atribut No_Kontak
SELECT * FROM dbo.supplier;
ALTER TABLE dbo.supplier
ADD UNIQUE (no_kontak);		

--NOMOR 1.4
CREATE TYPE dbo.nama FROM varchar (80) NOT NULL
GO
ALTER TABLE dbo.pengiriman ALTER COLUMN nama_penerima dbo.nama
ALTER TABLE dbo.gerai ALTER COLUMN nama_cabang dbo.nama
ALTER TABLE dbo.pegawai ALTER COLUMN nama dbo.nama
ALTER TABLE dbo.jabatan ALTER COLUMN nama_jabatan dbo.nama
ALTER TABLE dbo.member ALTER COLUMN nama dbo.nama
ALTER TABLE dbo.jenis_member ALTER COLUMN nama_jenis_member dbo.nama
ALTER TABLE dbo.produk ALTER COLUMN nama_produk dbo.nama

-- NOMOR 2.1
IF OBJECT_ID('dbo.RegisterMember') IS NOT NULL DROP FUNCTION dbo.RegisterMember;
GO
CREATE FUNCTION dbo.RegisterMember
(
	@No_KTP AS VARCHAR(255),
	@Nama AS VARCHAR(255),
	@Jenis_Kelamin AS VARCHAR(255),
	@Alamat AS VARCHAR(255),
	@Kelurahan AS VARCHAR(255),
	@Kecamatan AS VARCHAR(255),
	@Kabupaten_Kota AS VARCHAR(255),
	@Propinsi AS VARCHAR(255),
	@No_Kontak AS VARCHAR(255),
	@MinTrans AS INT
)
RETURNS VARCHAR(255)
AS

BEGIN
	DECLARE @res VARCHAR(255);
	DECLARE @member_id VARCHAR(255);
	DECLARE @no_daftar INT;
	DECLARE @year VARCHAR(255);
	DECLARE @month VARCHAR(255);
	DECLARE @day VARCHAR(255);
	DECLARE @tanggal_daftar_member DATE;
	DECLARE @tanggal_kedaluarsa_member DATE;
	DECLARE @Jenis_MemberJenis_Member_ID INT;

	IF @MinTrans = 100000 
		BEGIN
			SET @no_daftar = 0001;
			SET @year = CAST(YEAR(SYSDATETIME()) AS varchar);
			SET @month = CAST(MONTH(SYSDATETIME())-(MONTH(SYSDATETIME())-1) AS varchar);
			SET @day = CAST(DAY(SYSDATETIME())-(DAY(SYSDATETIME())-1) AS varchar);
			SET @member_id = CONCAT(@year, RIGHT('00'+CONVERT(varchar(20),@month),2),
			RIGHT('00'+CONVERT(varchar(20),@day),2), RIGHT('0000'+CONVERT(varchar(20),@no_daftar),4));

			SET @tanggal_daftar_member = SYSDATETIME();
			SET @tanggal_kedaluarsa_member = DATEADD(YEAR, 1, SYSDATETIME());
			SET @Jenis_MemberJenis_Member_ID = 
					CASE 
						WHEN @MinTrans = 50000 THEN 1
						WHEN @MinTrans = 100000 THEN 2
						WHEN @MinTrans = 1000000 THEN 3
						ELSE 0
					END;
			SET @res =  CONCAT('Selamat, Anda menjadi member kami dengan ', @Jenis_MemberJenis_Member_ID,
			' dan keanggotaan anda berkahir ', @tanggal_kedaluarsa_member)
		END;
	ELSE
		BEGIN
			SET @res = 'Proses registrasi ditolak karena minimal transaksi tidak memenuhi syarat'
		END;
	RETURN @res;
END;
GO

SELECT dbo.RegisterMember('0123456789','Eka','Perempuan','Jl. Sukjadi','Sukajadi','Sukajadi','Bandung','Jawa Barat','081234567890',100000)

-- NOMOR 2.2
IF OBJECT_ID('dbo.MengambilNamaPegawai') IS NOT NULL DROP FUNCTION dbo.MengambilNamaPegawai;
GO
CREATE FUNCTION dbo.MengambilNamaPegawai(@Pegawai_ID VARCHAR(255))
RETURNS VARCHAR(255)
AS
BEGIN
	DECLARE @res AS VARCHAR(255);
	IF @Pegawai_ID = CAST((SELECT Pegawai_ID 
							FROM Pegawai
							WHERE Pegawai_ID = @Pegawai_ID) AS varchar)
		BEGIN 
			SET @res = CAST((SELECT Nama 
							FROM Pegawai
							WHERE Pegawai_ID = @Pegawai_ID) AS varchar)
		END;
	ELSE
		BEGIN
			SET @res = ''
		END;
	RETURN @res;
END;
GO

SELECT dbo.MengambilNamaPegawai('2');

-- NOMOR 2.3
IF OBJECT_ID('dbo.SetBawahan') IS NOT NULL DROP FUNCTION dbo.SetBawahan;
GO

CREATE FUNCTION dbo.SetBawahan 
(	
	@Pegawai_ID VARCHAR(255),
	@Atasan_ID VARCHAR(255)
)
RETURNS VARCHAR(255)
AS
BEGIN
	DECLARE @res VARCHAR(255)
	IF dbo.MengambilNamaPegawai(@Pegawai_ID) = '' AND dbo.MengambilNamaPegawai(@Atasan_ID) = ''
		BEGIN
			SET @res = 'Pegawai yang Anda tetapkan tidak tersedia, silahkan cek kembali data pegawai yang akan disunting';
		END;
	ELSE
		BEGIN
			SET @res = CONCAT('Selamat ', dbo.MengambilNamaPegawai(@Pegawai_ID), ' menjadi bawahan dari ', 
			dbo.MengambilNamaPegawai(@Atasan_ID));
		END;
	RETURN @res;
END;
GO

SELECT dbo.SetBawahan('6', '1')

-- NOMOR 2.4
IF OBJECT_ID('dbo.NominalDiskon') IS NOT NULL DROP FUNCTION dbo.NominalDiskon;
GO
CREATE FUNCTION dbo.NominalDiskon(@Produk_ID VARCHAR(35), @Kuantitas INT)
RETURNS MONEY
AS
BEGIN
	DECLARE @harga MONEY;
	DECLARE @diskon INT;
	DECLARE @res MONEY;
	SET @harga = (SELECT Harga_Satuan FROM dbo.Produk WHERE Produk_ID = @Produk_ID)
	SET @diskon = (SELECT D.Persen_Diskon
					FROM Produk AS P 
						JOIN Diskon_Produk AS PD 
							ON P.ProdukProduk_ID = PD.ProdukProduk_ID
						JOIN Diskon AS D
							ON PD.DiskonDiskon_ID = D.Diskon_ID
					WHERE P.Produk_ID = @Produk_ID
					AND Tanggal_Awal_Berlaku <= SYSDATETIME()
					AND Tanggal_Akhir_Berlaku >= SYSDATETIME()
					AND D.MinQty <= @Kuantitas)
	IF @harga = NULL AND @diskon = NULL
		BEGIN 
			SET @res = 0;
		END;
	ELSE 
		BEGIN 
			SET @res = (@diskon * @harga) / 100
		END;
	RETURN @res
END;

SELECT dbo.NominalDiskon('1', 5);

-- NOMOR 3.1
IF OBJECT_ID('dbo.TambahPenjualan') IS NOT NULL DROP PROC dbo.TambahPenjualan;
GO
CREATE PROC dbo.TambahPenjualan
	@Pegawai_ID VARCHAR(35),
	@Member_ID VARCHAR(35),
	@Total_Pembayaran MONEY
AS
	DECLARE @pegawai VARCHAR(35);
	DECLARE @no_transaksi VARCHAR(35);
	DECLARE @nomor INT;
	SET @nomor = (SELECT COUNT(Tanggal_Transaksi) FROM Penjualan);
	IF CONVERT(VARCHAR(8), GETDATE(),108) = '00:00:00'
		SET @nomor += 0000;
	
	BEGIN TRY
		SET @pegawai = @Pegawai_ID;
		SET @no_transaksi = CONCAT('INV-',FORMAT(GETDATE(), 'yyyyMMdd'), '-', CAST(FORMAT(@nomor+1, '0000') AS VARCHAR));
		
		INSERT INTO dbo.Penjualan(No_Transaksi, Tanggal_Transaksi, Total_Pembayaran, Jenis_Pembayaran, PegawaiPegawai_ID, MemberMember_ID)
		VALUES (@no_transaksi, CAST(CONCAT(YEAR(GETDATE()), MONTH(GETDATE()), DAY(GETDATE())) AS DATE), @Total_Pembayaran, 'CASH', @pegawai, @Member_ID);
	END TRY
	BEGIN CATCH
		IF ERROR_NUMBER() = 515
			BEGIN
				PRINT 'Data Pegawai tidak dikenali, cek kembali pegawai yang melakukan penjualan'
			END;
	END CATCH 
GO

EXEC dbo.TambahPenjualan
@Pegawai_ID = '5', @Member_ID = NULL,
@Total_Pembayaran = 50000;

SELECT *
FROM Penjualan;

-- NOMOR 3.2
IF OBJECT_ID('dbo.TambahRincianPenjualan') IS NOT NULL DROP PROC dbo.TambahRincianPenjualan;
GO
CREATE PROC dbo.TambahRincianPenjualan
	@No_Transaksi VARCHAR(35),
	@Produk_ID VARCHAR(35),
	@Kuantitas INT
AS
	BEGIN
	DECLARE @rincian_id VARCHAR(255);
	DECLARE @no VARCHAR(35);
	DECLARE @produk VARCHAR(35);
	DECLARE @harga MONEY;
	DECLARE @nomor INT;
	SET @nomor = (SELECT COUNT(Rincian_ID) + 1 FROM Rincian_Penjualan);
	IF CONVERT(VARCHAR(8), GETDATE(),108) = '00:00:00'
		SET @nomor += 0000;

	SET @rincian_id = CONCAT('INV-',FORMAT(GETDATE(), 'yyyyMMdd'), '-', CAST(FORMAT(@nomor, '0000') AS VARCHAR));;

	SET @harga = (SELECT Harga_Satuan FROM Produk WHERE Produk_ID = @Produk_ID)
	
	BEGIN TRY
		SET @no = (SELECT No_Transaksi
					FROM Penjualan
					WHERE No_Transaksi = @No_Transaksi);
		SET @produk = (SELECT Produk_ID
					FROM Produk
					WHERE Produk_ID = @Produk_ID);
	END TRY
	BEGIN CATCH
		IF ERROR_NUMBER() = 515
			PRINT 'ERROR'
	END CATCH;

	INSERT INTO Rincian_Penjualan(Rincian_ID, Harga_Satuan, jumlah_penjualan, Nominal_Diskon
	,PenjualanNo_Transaksi, ProdukProduk_ID, Diskon_ProdukDiskon_Produk_ID)
	VALUES(@rincian_id, @harga, @Kuantitas, dbo.NominalDiskon(@Produk_ID, @Kuantitas),@no, 
	@produk, @produk);
	END;
GO

EXEC dbo.TambahRincianPenjualan
@No_Transaksi = 'INV-20221226-0011', @Produk_ID = '1',
@Kuantitas = 5;

SELECT * FROM Rincian_Penjualan

-- NOMOR 4.1
IF OBJECT_ID('Total_Bayar') IS NOT NULL DROP TRIGGER Total_Bayar;
GO
CREATE TRIGGER Total_Bayar
ON dbo.Rincian_Penjualan
AFTER INSERT
AS
BEGIN
	DECLARE @no INT;
	DECLARE @trans VARCHAR(35);
	SET @trans = (SELECT PenjualanNo_Transaksi
					FROM inserted)
	SET @no = (SELECT 
					CASE
						WHEN PenjualanNo_Transaksi IS NULL THEN 0
						ELSE Total_Biaya_Per_Produk
					END
				FROM inserted);
	IF @no = 0
		BEGIN
			UPDATE Penjualan
			SET Total_Pembayaran += 0
			WHERE No_Transaksi = @trans
		END;
	ELSE
		BEGIN
			UPDATE Penjualan
			SET Total_Pembayaran += (SELECT SUM(Total_Biaya_Per_Produk)
										FROM inserted)
			WHERE No_Transaksi = @trans
		END
END;

SELECT * FROM Rincian_Penjualan