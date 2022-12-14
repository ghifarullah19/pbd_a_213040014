IF YEAR(SYSDATETIME()) <> YEAR(DATEADD(day, 1, SYSDATETIME()))
    PRINT ' Hari ini adalah hari terakhir tahun ini.';
ELSE
    PRINT 'Hari ini bukan hari terakhir tahun ini.';

IF YEAR(SYSDATETIME()) <> YEAR(DATEADD(day, 1, SYSDATETIME()))
    PRINT ' Hari ini adalah hari terakhir tahun ini.';
ELSE
    IF MONTH(SYSDATETIME()) <> MONTH(DATEADD(day, 1, SYSDATETIME()))
        PRINT ' Hari ini adalah hari terakhir bulan ini tetapi bukan hari terakhir tahun ini.';
    ELSE
        PRINT 'Hari ini bukan hari terakhir tahun ini.';

IF DAY(SYSDATETIME()) = 1
    BEGIN
        PRINT 'Today is the first day of the month.';
        PRINT 'Starting first-of-month-day process.';
        /* ... process code goes here ... */
        PRINT 'Finished first-of-month-day database process.';
    END;
ELSE
    BEGIN
        PRINT 'Today is not the first day of the month.';
        PRINT 'Starting non-first-of-month-day process.';
        /* ... process code goes here ... */
        PRINT 'Finished non-first-of-month-day process.';
    END;