create table F0314(
	id int,
	DATA varchar(10)
)

insert into F0314
values
(1,'8'),
(2,'88'),
(3,'7,8'),
(4,'6,7,8'),
(5,'8,9'),
(6,'7,88')

-- ��ѯ������8�����ݣ�ֻ������8��88����
-- ����1��SQL SERVER 2016�汾���еĺ���
-- STRING_SPLIT ����
select t.id,
	t.DATA,
	v.value  -- ������ value ����
from F0314 t
cross apply string_split(t.DATA, ',') v
where v.value=8

-- string_split �����÷�
select value from string_split('2022-01-02', '-')

-- ����2
select * from F0314
where ','+DATA+',' like '%,8,%'

select * from F0314
where ','+DATA+',' like '%,8,%'

with
tmp as(
	select cast(RAND()*100 as int) value
	union
	select cast(RAND()*100 as int) value
	union
	select cast(RAND()*100 as int) value
	union
	select cast(RAND()*100 as int) value
)
select * from tmp where '3' +value like '3_'