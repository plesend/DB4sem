USE MyBase;

SELECT �.�������� AS �������, AVG(�.������) AS �������_������
FROM ������ �
JOIN ������� � ON �.ID_�������� = �.ID_��������
GROUP BY �.��������;

SELECT �.�������� AS �������, AVG(�.������) AS �������_������
FROM ������ �
JOIN ������� � ON �.ID_�������� = �.ID_��������
GROUP BY ROLLUP (�.��������);

SELECT �.�������, �.��������, AVG(�.������) AS �������_������
FROM ������ �
JOIN ������� � ON �.ID_�������� = �.ID_��������
JOIN �������� � ON �.ID_�������� = �.ID_��������
GROUP BY CUBE (�.�������, �.��������);

SELECT �.��������, AVG(�.������) AS �������_������
FROM ������ �
JOIN ������� � ON �.ID_�������� = �.ID_��������
WHERE �.�������� = '����������'
GROUP BY �.��������

UNION

SELECT �.��������, AVG(�.������) AS �������_������
FROM ������ �
JOIN ������� � ON �.ID_�������� = �.ID_��������
WHERE �.�������� = '������'
GROUP BY �.��������;


SELECT �.��������, AVG(�.������) AS �������_������
FROM ������ �
JOIN ������� � ON �.ID_�������� = �.ID_��������
WHERE �.�������� = '����������'
GROUP BY �.��������

UNION ALL

SELECT �.��������, AVG(�.������) AS �������_������
FROM ������ �
JOIN ������� � ON �.ID_�������� = �.ID_��������
WHERE �.�������� = '������'
GROUP BY �.��������;


SELECT ID_��������
FROM ������
WHERE ID_�������� = 1  -- ����������

INTERSECT

SELECT ID_��������
FROM ������
WHERE ID_�������� = 2;  -- ������


SELECT �.�������, �.���
FROM �������� �
WHERE �.ID_�������� IN (
    SELECT ID_�������� FROM ������ WHERE ID_�������� = 1
    INTERSECT
    SELECT ID_�������� FROM ������ WHERE ID_�������� = 2
);


SELECT ID_��������
FROM ������
WHERE ID_�������� = 1  -- ����������

EXCEPT

SELECT ID_��������
FROM ������
WHERE ID_�������� = 2;  -- ������


SELECT �.�������, �.���
FROM �������� �
WHERE �.ID_�������� IN (
    SELECT ID_�������� FROM ������ WHERE ID_�������� = 1
    EXCEPT
    SELECT ID_�������� FROM ������ WHERE ID_�������� = 2
);
