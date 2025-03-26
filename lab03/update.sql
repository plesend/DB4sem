UPDATE ТОВАРЫ set Количество = 1;
UPDATE ТОВАРЫ set Цена = Цена+1 Where Наименование = 'Стол';
DELETE from ТОВАРЫ Where Наименование = 'Стул';