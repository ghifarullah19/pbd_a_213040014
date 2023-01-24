-- NOMOR 1
CREATE DATABASE LATIHAN_PERTEMUAN13;

CREATE TABLE Latihan
(
barang_id INT PRIMARY KEY,
nama_barang VARCHAR(40),
jumlah SMALLINT,
harga MONEY,
diskon SMALLMONEY,
category_id INT,
brand_id INT
);

INSERT INTO Latihan (barang_id, nama_barang, jumlah, harga, diskon, category_id, brand_id)
VALUES (3, 'Laptop', 11, 10000000, 0, 4, 2),
(4, 'Sepatu', 12, 135000, 5000, 3, 1),
(5, 'Sandal Swalow', 15, 165000, 1000, 3, 1),
(6, 'Jaket', 4, 90000, 1000, 3, 1),
(7, 'Kaos Naruto', 6, 50000, 1000, 3, 3),
(8, 'Kaos Oblong', 5, 35000, 1000, 3, 3),
(9, 'Mouse Logitech', 10, 200000, NULL, 4, 4),
(10, 'Dongrak', 2, 500000, NULL, 5, 5),
(11, 'Tas Adidas', 2, 200000, NULL, NULL, NULL),
(13, 'switer new', 10, 100000, 0, 3, 3);

SELECT * FROM Latihan;

-- NOMOR 2
DECLARE NamaBarangCursor CURSOR FAST_FORWARD
FOR
SELECT nama_barang, harga
FROM Latihan;

DECLARE @nama varchar(40), @harga money;

OPEN NamaBarangCursor;

FETCH NEXT FROM NamaBarangCursor
INTO @nama, @harga
BEGIN;
    IF @harga > 5000000
        PRINT 'Terdapat nama barang ' + @nama;
    ELSE
        PRINT 'Tidak ada produk yang dipilih';
FETCH NEXT FROM NamaBarangCursor
INTO @nama, @harga;
END;

CLOSE NamaBarangCursor;
DEALLOCATE NamaBarangCursor;

-- NOMOR 3
DECLARE JumlahHarga CURSOR FAST_FORWARD
FOR
SELECT nama_barang, harga
FROM Latihan;

DECLARE @namaBarang VARCHAR(40), @hargaBarang MONEY;

OPEN JumlahHarga;

FETCH NEXT FROM JumlahHarga
INTO @namaBarang, @hargaBarang
WHILE @@FETCH_STATUS = 0
	BEGIN;
    IF @hargaBarang > 300000
        PRINT 'Penjualan ' + @namaBarang +  ' lebih dari 300.000';
    ELSE
        PRINT 'Penjualan ' + @namaBarang +  ' tidak lebih dari 300.000';
FETCH NEXT FROM JumlahHarga
INTO @namaBarang, @hargaBarang;
END;

CLOSE JumlahHarga;
DEALLOCATE JumlahHarga;

-- NOMOR 4
DECLARE PrintHarga CURSOR FAST_FORWARD
FOR
SELECT barang_id, nama_barang
FROM Latihan;

DECLARE @namaBarangLagi VARCHAR(40), @id INT;

OPEN PrintHarga;

FETCH NEXT FROM PrintHarga
INTO @id, @namaBarangLagi
WHILE @@FETCH_STATUS = 0
BEGIN;
	IF @id >= 5 and @id <= 10
		PRINT @namaBarangLagi;
FETCH NEXT FROM PrintHarga
INTO @id, @namaBarangLagi;
END;

CLOSE PrintHarga;
DEALLOCATE PrintHarga;