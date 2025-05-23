select G.FACULTY, count(S.IDSTUDENT) AS STUDENT_COUNT
FROM STUDENT S
JOIN GROUPS G ON G.IDGROUP = S.IDGROUP
GROUP BY G.FACULTY


SELECT P.PULPIT_NAME, COUNT(S.IDSTUDENT) AS STUDENT_QUANTITY
FROM STUDENT S
JOIN GROUPS G ON G.IDGROUP = S.IDGROUP
JOIN FACULTY F ON F.FACULTY = G.FACULTY
JOIN PULPIT P ON P.FACULTY = F.FACULTY
GROUP BY P.PULPIT_NAME

SELECT A.AUDITORIUM, AT.AUDITORIUM_TYPENAME
FROM AUDITORIUM A
JOIN AUDITORIUM_TYPE AT ON A.AUDITORIUM_TYPE = AT.AUDITORIUM_TYPE
WHERE A.AUDITORIUM_CAPACITY > 
	(SELECT AVG(A.AUDITORIUM_CAPACITY)
	FROM AUDITORIUM A)

SELECT A.AUDITORIUM, AT.AUDITORIUM_TYPENAME
FROM AUDITORIUM A
JOIN AUDITORIUM_TYPE AT ON A.AUDITORIUM_TYPE = AT.AUDITORIUM_TYPE
WHERE A.AUDITORIUM_CAPACITY <
	(SELECT MAX(A1.AUDITORIUM_CAPACITY)
	FROM AUDITORIUM A1
	WHERE A1.AUDITORIUM_TYPE = '��')

SELECT A.AUDITORIUM, AT.AUDITORIUM_TYPENAME
FROM AUDITORIUM A
JOIN AUDITORIUM_TYPE AT ON A.AUDITORIUM_TYPE = AT.AUDITORIUM_TYPE
WHERE A.AUDITORIUM_CAPACITY > 
    (SELECT AVG(A1.AUDITORIUM_CAPACITY)
     FROM AUDITORIUM A1
     WHERE A1.AUDITORIUM_TYPE = A.AUDITORIUM_TYPE);

SELECT A.AUDITORIUM, AT.AUDITORIUM_TYPENAME
FROM AUDITORIUM A
JOIN AUDITORIUM_TYPE AT ON A.AUDITORIUM_TYPE = AT.AUDITORIUM_TYPE
WHERE A.AUDITORIUM_CAPACITY > 
		(SELECT AVG(A1.AUDITORIUM_CAPACITY)
		FROM AUDITORIUM A1
		WHERE A1.AUDITORIUM_TYPE = A.AUDITORIUM_TYPE)


select S.NAME, G.FACULTY
FROM STUDENT S
JOIN GROUPS G ON S.IDGROUP = G.IDGROUP
WHERE G.FACULTY IN (
		SELECT P.FACULTY
		FROM PROFESSION P
		WHERE P.FACULTY = G.FACULTY AND P.FACULTY = '����');