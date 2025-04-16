USE MyBase;
SELECT 
    PR.�������� AS �������,
    MAX(O.������) AS [MAX ������], 
    MIN(O.������) AS [MIN ������], 
    AVG(O.������) AS [AVG ������],
    COUNT(*) AS [���������� ������]
FROM ������ O
INNER JOIN ������� PR ON O.ID_�������� = PR.ID_��������
GROUP BY PR.��������;

--2
SELECT 
    CASE
        WHEN ������ IN (4, 5) THEN '4-5'
        WHEN ������ IN (6, 7) THEN '6-7'
        WHEN ������ = 8 THEN '8'
    END AS ��������,
    COUNT(*) AS ����������
FROM ������
WHERE ������ BETWEEN 4 AND 8
GROUP BY 
    CASE
        WHEN ������ IN (4, 5) THEN '4-5'
        WHEN ������ IN (6, 7) THEN '6-7'
        WHEN ������ = 8 THEN '8'
    END
ORDER BY �������� DESC;

--4
SELECT 
    PR.�������� AS �������,
    ROUND(CAST(AVG(O.������) AS DECIMAL(10, 2)), 2) AS �������_������
FROM ������ O
INNER JOIN ������� PR ON O.ID_�������� = PR.ID_��������
GROUP BY PR.��������
ORDER BY �������_������ DESC;

SELECT 
    S.�������,
    S.���,
    ROUND(CAST(AVG(O.������) AS DECIMAL(10, 2)), 2) AS �������_������
FROM ������ O
INNER JOIN �������� S ON O.ID_�������� = S.ID_��������
GROUP BY S.�������, S.���
HAVING AVG(O.������) > 7
ORDER BY �������_������ DESC;




