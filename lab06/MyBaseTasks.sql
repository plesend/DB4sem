USE MyBase;
SELECT 
    PR.Название AS Предмет,
    MAX(O.Оценка) AS [MAX Оценка], 
    MIN(O.Оценка) AS [MIN Оценка], 
    AVG(O.Оценка) AS [AVG Оценка],
    COUNT(*) AS [Количество Оценок]
FROM ОЦЕНКИ O
INNER JOIN ПРЕДМЕТ PR ON O.ID_Предмета = PR.ID_Предмета
GROUP BY PR.Название;

--2
SELECT 
    CASE
        WHEN Оценка IN (4, 5) THEN '4-5'
        WHEN Оценка IN (6, 7) THEN '6-7'
        WHEN Оценка = 8 THEN '8'
    END AS Интервал,
    COUNT(*) AS Количество
FROM ОЦЕНКИ
WHERE Оценка BETWEEN 4 AND 8
GROUP BY 
    CASE
        WHEN Оценка IN (4, 5) THEN '4-5'
        WHEN Оценка IN (6, 7) THEN '6-7'
        WHEN Оценка = 8 THEN '8'
    END
ORDER BY Интервал DESC;

--4
SELECT 
    PR.Название AS Предмет,
    ROUND(CAST(AVG(O.Оценка) AS DECIMAL(10, 2)), 2) AS Средняя_оценка
FROM ОЦЕНКИ O
INNER JOIN ПРЕДМЕТ PR ON O.ID_Предмета = PR.ID_Предмета
GROUP BY PR.Название
ORDER BY Средняя_оценка DESC;

SELECT 
    S.Фамилия,
    S.Имя,
    ROUND(CAST(AVG(O.Оценка) AS DECIMAL(10, 2)), 2) AS Средняя_оценка
FROM ОЦЕНКИ O
INNER JOIN СТУДЕНТЫ S ON O.ID_Студента = S.ID_Студента
GROUP BY S.Фамилия, S.Имя
HAVING AVG(O.Оценка) > 7
ORDER BY Средняя_оценка DESC;




