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

-- 要求：删除电话号码相同的记录并保留ID最小的记录

select * from F0614 a, F0614 b
where a.Phone = b.Phone
and a.ID > b.ID

-- 解法一
-- 不支持这种写法，提示有语法错误
delete from F0614 a, F0614 b
where a.Phone = b.Phone
and a.ID > b.ID

-- 解法二
delete from F0614
where ID in(
	select a.ID DID from F0614 a
	left join F0614 b
	on a.Phone = b.Phone
	where a.ID>b.ID
)