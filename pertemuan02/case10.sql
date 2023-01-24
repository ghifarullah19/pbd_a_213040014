SELECT 
    CASE categoryid
        WHEN 1 THEN 'KATEGORI A'
        WHEN 2 THEN 'KATEGORI B'
        WHEN 3 THEN 'KATEGORI C'
        WHEN 4 THEN 'KATEGORI D'
        WHEN 5 THEN 'KATEGORI E'
        WHEN 6 THEN 'KATEGORI F'
        WHEN 7 THEN 'KATEGORI G'
        WHEN 8 THEN 'KATEGORI H'
        ELSE 'TIDAK DIKETAHUI'
    END
AS 'NAMA KATEGORI'
FROM Production.Products