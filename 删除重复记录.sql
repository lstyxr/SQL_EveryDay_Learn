create table F0614(
	ID INT,
	Phone VARCHAR(20)
)

insert into F0614
values
(1,'13512345678'),
(2,'13512345678'),
(3,'13012345678')

select * from F0614

-- Ҫ��ɾ���绰������ͬ�ļ�¼������ID��С�ļ�¼

select * from F0614 a, F0614 b
where a.Phone = b.Phone
and a.ID > b.ID

-- �ⷨһ
-- ��֧������д������ʾ���﷨����
delete from F0614 a, F0614 b
where a.Phone = b.Phone
and a.ID > b.ID

-- �ⷨ��
delete from F0614
where ID in(
	select a.ID DID from F0614 a
	left join F0614 b
	on a.Phone = b.Phone
	where a.ID>b.ID
)