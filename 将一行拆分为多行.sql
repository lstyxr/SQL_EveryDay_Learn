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

-- 查询出数字8的数据，只是数字8，88不算
-- 方法1，SQL SERVER 2016版本才有的函数
-- STRING_SPLIT 函数
select t.id,
	t.DATA,
	v.value  -- 必须是 value 列名
from F0314 t
cross apply string_split(t.DATA, ',') v
where v.value=8

-- string_split 函数用法
select value from string_split('2022-01-02', '-')

-- 方法2
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