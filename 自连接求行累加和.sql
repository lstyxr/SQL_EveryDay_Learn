create table F0316(
	ID int,
	NUM int
)

insert into F0316
values
(1,5),
(2,3),
(3,12),
(4,2),
(5,7),
(6,9)

-- 求累加和，不用开窗函数
select *,sum(NUM) over(order by id) from F0316

select
	B.ID,
	B.NUM,
	SUM(A.NUM) ADD_NUM
from F0316 B
left join F0316 A
on A.ID <= B.ID
group by B.ID, B.NUM
order by B.ID