--TASK1
DECLARE subjectCursor Cursor 
		for SELECT SUBJECT.SUBJECT FROM SUBJECT
			WHERE SUBJECT.PULPIT = '????';
DECLARE @subjectName char(20), @result1 char(300)='';
OPEN subjectCursor;
	FETCH subjectCursor INTO @subjectName;
	PRINT '?????? ????????? ?? ??????? ????';
	WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @result1 = RTRIM(@subjectName)+','+@result1;
			FETCH subjectCursor INTO @subjectName;
		END
	PRINT @result1
CLOSE subjectCursor;
DEALLOCATE subjectCursor;
go


--TASK2
DECLARE nameStudentCursor CURSOR LOCAL
	for SELECT ST.NAME FROM STUDENT AS ST
DECLARE @name char(40);
	OPEN nameStudentCursor
	FETCH nameStudentCursor INTO @name
	PRINT '1 ' +  @name
go
DECLARE @name char(40);
	FETCH nameStudentCursor INTO @name
	PRINT '2 ' + @name
go


DECLARE nameStudentCursor CURSOR GLOBAL
	for SELECT ST.NAME FROM STUDENT AS ST
DECLARE @name char(40);
	OPEN nameStudentCursor
	FETCH nameStudentCursor INTO @name
	PRINT '1 ' + @name
go
DECLARE @name char(40);
	FETCH nameStudentCursor INTO @name
	PRINT '2 ' + @name
	CLOSE nameStudentCursor
	DEALLOCATE nameStudentCursor
go


--TASK3
DROP TABLE SUBJECT_COPY;
SELECT * INTO SUBJECT_COPY FROM SUBJECT;
SELECT * FROM SUBJECT_COPY;

DECLARE @dsc CHAR(10), @output CHAR(150) = ' ';
DECLARE DSC_CURSOR CURSOR LOCAL STATIC
	for SELECT PULPIT FROM dbo.SUBJECT_COPY;

OPEN DSC_CURSOR;
SELECT * FROM SUBJECT_COPY;
PRINT '?????????? ?????: ' + CAST(@@CURSOR_ROWS AS VARCHAR(5));
	DELETE SUBJECT_COPY WHERE PULPIT = '????';
FETCH DSC_CURSOR INTO @dsc;
WHILE @@FETCH_STATUS = 0
BEGIN
    SET @output = TRIM(@dsc) + ', ' + @output; 
    FETCH DSC_CURSOR INTO @dsc;
END
PRINT @output;
CLOSE DSC_CURSOR;
DEALLOCATE DSC_CURSOR;
go


DECLARE @dsc CHAR(10), @output CHAR(150) = ' ';
DECLARE DSC_CURSOR CURSOR LOCAL DYNAMIC
	for SELECT PULPIT FROM dbo.SUBJECT_COPY;

OPEN DSC_CURSOR;
SELECT * FROM SUBJECT_COPY;
PRINT '?????????? ?????: ' + CAST(@@CURSOR_ROWS AS VARCHAR(5));
	DELETE SUBJECT_COPY WHERE PULPIT = '????';
FETCH DSC_CURSOR INTO @dsc;
WHILE @@FETCH_STATUS = 0
BEGIN
    SET @output = TRIM(@dsc) + ', ' + @output; 
    FETCH DSC_CURSOR INTO @dsc;
END
PRINT @output;
CLOSE DSC_CURSOR;
DEALLOCATE DSC_CURSOR;
go


--TASK4
DECLARE nameStudentCursor CURSOR LOCAL dynamic scroll
	for SELECT ROW_NUMBER() over (order by ST.IDSTUDENT), st.NAME
	FROM STUDENT AS ST
DECLARE @id int, @name char(40);
	OPEN nameStudentCursor
		FETCH FIRST from nameStudentCursor INTO @id, @name
	PRINT '?????? ??????: ' + cast(@id as char) + trim(@name);
		FETCH NEXT from nameStudentCursor INTO @id, @name
	PRINT '????????? ??????: ' + cast(@id as char) + trim(@name);
		FETCH LAST from nameStudentCursor INTO @id, @name
	PRINT '????????? ??????: ' + cast(@id as char) + trim(@name);
		FETCH PRIOR from nameStudentCursor INTO @id, @name
	PRINT '?????????? ??????: ' + cast(@id as char) + trim(@name);
		FETCH ABSOLUTE 20 from nameStudentCursor INTO @id, @name
	PRINT '20-? ?????? ? ??????: ' + cast(@id as char) + trim(@name);
		FETCH ABSOLUTE -20 from nameStudentCursor INTO @id, @name
	PRINT '20-? ?????? ? ?????: ' + cast(@id as char) + trim(@name);
		FETCH RELATIVE 5 from nameStudentCursor INTO @id, @name
	PRINT '5-? ?????? ????? ?? ???????: ' + cast(@id as char) + trim(@name);
		FETCH RELATIVE -6 from nameStudentCursor INTO @id, @name
	PRINT '6-? ?????? ????? ?? ???????: ' + cast(@id as char) + trim(@name);
CLOSE nameStudentCursor
DEALLOCATE nameStudentCursor
go


--TASK5 
DROP TABLE SUBJECT_COPY;
SELECT * INTO SUBJECT_COPY FROM SUBJECT;
SELECT * FROM SUBJECT_COPY;

DECLARE @dsc CHAR(10);
DECLARE DSC_CURSOR CURSOR LOCAL DYNAMIC
	for SELECT PULPIT 
	FROM dbo.SUBJECT_COPY FOR UPDATE;

OPEN DSC_CURSOR;
SELECT * FROM SUBJECT_COPY;
PRINT '?????????? ?????: ' + CAST(@@CURSOR_ROWS AS VARCHAR(5));
		FETCH DSC_CURSOR INTO @dsc;
	DELETE SUBJECT_COPY WHERE CURRENT OF DSC_CURSOR;
		FETCH DSC_CURSOR INTO @dsc;
	UPDATE SUBJECT_COPY SET PULPIT = '????' WHERE CURRENT OF DSC_CURSOR;

CLOSE DSC_CURSOR;
DEALLOCATE DSC_CURSOR;
go


--TASK6
--1
SELECT * FROM PROGRESS

DECLARE studentCursor CURSOR LOCAL DYNAMIC 
	for SELECT ST.NAME, P.SUBJECT, P.NOTE
	FROM PROGRESS AS P
	INNER JOIN STUDENT AS ST ON P.IDSTUDENT = ST.IDSTUDENT
	INNER JOIN GROUPS AS G ON ST.IDGROUP = G.IDGROUP
	WHERE P.NOTE <= 4
DECLARE @sname nvarchar(50), @subj nvarchar(50), @mark int

OPEN studentCursor
	FETCH studentCursor INTO  @sname, @subj, @mark
	WHILE @@FETCH_STATUS = 0
BEGIN
	DELETE PROGRESS where CURRENT OF studentCursor
	FETCH studentCursor INTO  @sname, @subj, @mark
END
CLOSE studentCursor
DEALLOCATE studentCursor
go


--2
SELECT * FROM PROGRESS

DECLARE studentCursor CURSOR LOCAL DYNAMIC 
	for SELECT ST.NAME, P.SUBJECT, P.NOTE
	FROM PROGRESS AS P
	INNER JOIN STUDENT AS ST ON P.IDSTUDENT = ST.IDSTUDENT
	INNER JOIN GROUPS AS G ON ST.IDGROUP = G.IDGROUP
	WHERE ST.IDSTUDENT BETWEEN 1001 AND 1003
DECLARE @sname nvarchar(50), @subj nvarchar(50), @mark int

OPEN studentCursor
	FETCH studentCursor INTO  @sname, @subj, @mark
	WHILE @@FETCH_STATUS = 0
BEGIN
	UPDATE PROGRESS SET NOTE = NOTE +1 where CURRENT OF studentCursor
	FETCH studentCursor INTO  @sname, @subj, @mark
END
CLOSE studentCursor
DEALLOCATE studentCursor
go