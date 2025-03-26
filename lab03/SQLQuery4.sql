create table ЗАКАЗЧИКИ
(
	Наименование_фирмы nvarchar(20) primary key,
	Адрес nvarchar(50),
	Расчетный_счет nvarchar(20)
);
create table ЗАКАЗЫ
(
	Номер_заказа int primary key,
	Наименование_товара nvarchar(50) foreign key references ТОВАРЫ (Наименование),
	Цена_продажи real,
	Количество int,
	Дата_поставки date,
	Заказчик nvarchar(20) foreign key references ЗАКАЗЧИКИ (Наименование_фирмы)
);