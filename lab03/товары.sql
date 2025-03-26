use ПРОДАЖИ
create table ТОВАРЫ
(	
	Наименование nvarchar(50) primary key,
	Цена real unique not null,
	Количество int
);
