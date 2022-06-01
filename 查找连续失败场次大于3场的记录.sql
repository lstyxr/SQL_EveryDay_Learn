create table F0228(
	ID int,
	场次 int,
	结果 varchar(10)
)

insert into f0228
values
(1,34,'败'),
(3,35,'胜'),
(5,36,'胜'),
(8,37,'败'),
(9,38,'败'),
(11,39,'败'),
(12,40,'败'),
(15,41,'胜'),
(17,42,'胜'),
(20,43,'败'),
(21,44,'败'),
(23,45,'败'),
(24,46,'败')

--  要求：查询出连续失败场次大于3的记录行
with
t1 as(
	select *, ROW_NUMBER() over(order by 场次) num1 from F0228
),
t2 as(
	select *,
		ROW_NUMBER() over(partition by 结果 order by 场次) xl,
		num1 - ROW_NUMBER() over(partition by 结果 order by 场次) num2
	from t1
)
select ID, 场次, 结果
from t2
where num2 in(
	select num2 
	from
	t2
	group by num2
	having COUNT(1) > 3
)