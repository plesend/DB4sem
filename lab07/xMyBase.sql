USE MyBase;

SELECT П.Название AS Предмет, AVG(О.Оценка) AS Средняя_Оценка
FROM ОЦЕНКИ О
JOIN ПРЕДМЕТ П ON О.ID_Предмета = П.ID_Предмета
GROUP BY П.Название;

SELECT П.Название AS Предмет, AVG(О.Оценка) AS Средняя_Оценка
FROM ОЦЕНКИ О
JOIN ПРЕДМЕТ П ON О.ID_Предмета = П.ID_Предмета
GROUP BY ROLLUP (П.Название);

SELECT С.Фамилия, П.Название, AVG(О.Оценка) AS Средняя_Оценка
FROM ОЦЕНКИ О
JOIN ПРЕДМЕТ П ON О.ID_Предмета = П.ID_Предмета
JOIN СТУДЕНТЫ С ON О.ID_Студента = С.ID_Студента
GROUP BY CUBE (С.Фамилия, П.Название);

SELECT П.Название, AVG(О.Оценка) AS Средняя_Оценка
FROM ОЦЕНКИ О
JOIN ПРЕДМЕТ П ON О.ID_Предмета = П.ID_Предмета
WHERE П.Название = 'Математика'
GROUP BY П.Название

UNION

SELECT П.Название, AVG(О.Оценка) AS Средняя_Оценка
FROM ОЦЕНКИ О
JOIN ПРЕДМЕТ П ON О.ID_Предмета = П.ID_Предмета
WHERE П.Название = 'Физика'
GROUP BY П.Название;


SELECT П.Название, AVG(О.Оценка) AS Средняя_Оценка
FROM ОЦЕНКИ О
JOIN ПРЕДМЕТ П ON О.ID_Предмета = П.ID_Предмета
WHERE П.Название = 'Математика'
GROUP BY П.Название

UNION ALL

SELECT П.Название, AVG(О.Оценка) AS Средняя_Оценка
FROM ОЦЕНКИ О
JOIN ПРЕДМЕТ П ON О.ID_Предмета = П.ID_Предмета
WHERE П.Название = 'Физика'
GROUP BY П.Название;


SELECT ID_Студента
FROM ОЦЕНКИ
WHERE ID_Предмета = 1  -- Математика

INTERSECT

SELECT ID_Студента
FROM ОЦЕНКИ
WHERE ID_Предмета = 2;  -- Физика


SELECT С.Фамилия, С.Имя
FROM СТУДЕНТЫ С
WHERE С.ID_Студента IN (
    SELECT ID_Студента FROM ОЦЕНКИ WHERE ID_Предмета = 1
    INTERSECT
    SELECT ID_Студента FROM ОЦЕНКИ WHERE ID_Предмета = 2
);


SELECT ID_Студента
FROM ОЦЕНКИ
WHERE ID_Предмета = 1  -- Математика

EXCEPT

SELECT ID_Студента
FROM ОЦЕНКИ
WHERE ID_Предмета = 2;  -- Физика


SELECT С.Фамилия, С.Имя
FROM СТУДЕНТЫ С
WHERE С.ID_Студента IN (
    SELECT ID_Студента FROM ОЦЕНКИ WHERE ID_Предмета = 1
    EXCEPT
    SELECT ID_Студента FROM ОЦЕНКИ WHERE ID_Предмета = 2
);
