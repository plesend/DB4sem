use ÏĞÎÄÀÆÈ;
create table test (
	id int,
	dataName nvarchar(50)
);

alter table test add testColumn nvarchar(50);
insert into test(id, dataName, testColumn) values
	(1, 'info', 'test');
update test set testColumn = 'test2' where id = 1;