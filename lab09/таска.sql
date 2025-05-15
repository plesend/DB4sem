DECLARE @ch char = 'k',
		@vc varchar = 'shirasagi';

DECLARE @dt datetime = '2025-05-10',
		@time time = '14:30:00',
		@int int = 42,
		@sint smallint = 2,
		@tinint tinyint = 1,
		@numericVar NUMERIC(12,5);

SET		@dt = '2025-05-10';
SET		@time = '14:30:00';
SET		@int = 42;
SET		@sint = 2;
SET		@tinint = 1;
SET		@numericVar = 1234.123;

SELECT 
    @dt = GETDATE(),
    @time = CONVERT(TIME, GETDATE()),
    @int = 7890,
    @numericVar = 9876543.54321;

SELECT 
    [CHAR] = @ch,
    [VARCHAR] = @vc,
    [DATETIME] = @dt,
    [TIME] = @time;

PRINT 'INT: ' + CAST(@int AS VARCHAR);
PRINT 'SMALLINT: ' + CAST(@sint AS VARCHAR);
PRINT 'TINYINT: ' + CAST(@tinint AS VARCHAR);
PRINT 'NUMERIC: ' + CAST(@numericVar AS VARCHAR);

--2
use UNIVER;
DECLARE @TotalCapacity INT,
		@AudCount int, 
		@AvgCapacity decimal(10, 2),
		@BelowAvgCount int,
        @BelowAvgPercent decimal(5, 2);

select @TotalCapacity = sum(AUDITORIUM_CAPACITY) FROM AUDITORIUM
IF @TotalCapacity > 200
begin
	select @AudCount = count(*) from AUDITORIUM;
	select @AvgCapacity = avg(cast(AUDITORIUM_CAPACITY as decimal(10,2))) from AUDITORIUM;
	select @BelowAvgCount = count(*) from AUDITORIUM where AUDITORIUM_CAPACITY < @AvgCapacity;

set @BelowAvgPercent = cast(@BelowAvgCount AS DECIMAL(5,2)) * 100 / @AudCount;
select 
		[Общая вместимость] = @TotalCapacity,
        [Количество аудиторий] = @AudCount,
        [Средняя вместимость] = @AvgCapacity,
        [Количество ниже среднего] = @BelowAvgCount,
        [Процент таких аудиторий] = @BelowAvgPercent;
end 
else 
begin
print 'Общая вместимость ауд: ' + cast(@TotalCapacity AS VARCHAR);
end;

--3
PRINT @@ROWCOUNT;
PRINT @@VERSION;
PRINT @@SPID;
PRINT @@ERROR;
PRINT @@SERVERNAME;
PRINT @@TRANCOUNT;
PRINT @@FETCH_STATUS;
PRINT @@NESTLEVEL;

--4
declare @z real, @t real = 4, @x real = 2;
SET @z = 
    case
        WHen @t > @x then POWER(SIN(@t), 2)
        when @t < @x then 4 * (@t + @x)
        else 1 - POWER(EXP(1), @x - 2)
    END;
print 'z= ' + cast(@z as varchar); 

DECLARE @fullName NVARCHAR(100) = 'Порельская Ия Сергеевна',
        @shortName NVARCHAR(40),
        @firstSpace INT,
        @secondSpace INT;

SET @firstSpace = CHARINDEX(' ', @fullName);
SET @secondSpace = CHARINDEX(' ', @fullName, @firstSpace + 1);

SET @shortName = SUBSTRING(@fullName, 1, @firstSpace) + 
                 SUBSTRING(@fullName, @firstSpace + 1, 1) + '. ' +
                 SUBSTRING(@fullName, @secondSpace + 1, 1) + '. ';

PRINT 'Полное ФИО: ' + @fullName;
PRINT 'Сокращенное ФИО: ' + @shortName;

--///
DECLARE @NextMonth DATE = DATEADD(MONTH, 1, GETDATE())
SELECT S.NAME, S.BDAY, DATEDIFF(YEAR, S.BDAY, @NextMonth) AS YEARS
	FROM STUDENT AS S
	WHERE MONTH(s.BDAY) >= MONTH(@NextMonth) AND MONTH(s.BDAY) <= MONTH(@NextMonth);

SELECT S.IDGROUP, P.SUBJECT, P.PDATE, DATENAME(WEEKDAY, P.PDATE) AS [WEEKDAY]
	FROM PROGRESS AS P INNER JOIN STUDENT AS S ON P.IDSTUDENT = S.IDSTUDENT
	GROUP BY S.IDGROUP, P.SUBJECT, P.PDATE
	HAVING P.SUBJECT = 'СУБД';

--5
DECLARE @avarageNote REAL = (SELECT CAST(AVG(P.NOTE) AS REAL) FROM PROGRESS AS P)
IF @avarageNote >= 8
	PRINT 'средние оценки больше равно 8 ' + CAST(@avarageNote AS VARCHAR)
ELSE IF @avarageNote < 8 AND @avarageNote >= 6
	PRINT 'меньше 8 и больше равно 6 ' + CAST(@avarageNote AS VARCHAR)
ELSE 
	PRINT 'вывод: ' + CAST(@avarageNote AS VARCHAR)

--6
SELECT G.FACULTY, COUNT(P.NOTE) AS AMOUNT_STUDENT,
	CASE 
		WHEN P.NOTE BETWEEN 0 AND 4 THEN 'плоховато'
		WHEN P.NOTE BETWEEN 5 AND 7 THEN 'слава богу сдал'
		WHEN P.NOTE BETWEEN 8 AND 10 THEN 'умничка'
	END AS INFORMATION
		FROM PROGRESS AS P
		INNER JOIN STUDENT AS S ON P.IDSTUDENT = S.IDSTUDENT
		INNER JOIN GROUPS AS G ON S.IDGROUP = G.IDGROUP
	GROUP BY G.FACULTY,
		CASE 
			WHEN P.NOTE BETWEEN 0 AND 4 THEN 'плоховато'
			WHEN P.NOTE BETWEEN 5 AND 7 THEN 'слава богу сдал'
			WHEN P.NOTE BETWEEN 8 AND 10 THEN 'умничка'
		END
	HAVING G.FACULTY = 'ИСиТ'

--7 
create table #example (id int, name nvarchar(20), anytext nvarchar(20));
declare @i int = 0;
--return;
while @i < 10
begin 
	insert into #example (id, name, anytext)
	values (@i, concat('name for ', @i), concat('description for ', @i));

	set @i = @i + 1;
end;
select * from #example;
drop table #example;

--8
DECLARE @num INT
BEGIN TRY
	SET @num = 13 / 0;
END TRY
BEGIN CATCH
	PRINT ERROR_NUMBER();
	PRINT ERROR_MESSAGE();
	PRINT ERROR_LINE();
	PRINT ERROR_PROCEDURE();
	PRINT ERROR_SEVERITY();
	PRINT ERROR_STATE();
END CATCH