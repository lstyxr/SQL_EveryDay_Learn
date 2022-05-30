create table F0222(
	X int
)

insert into F0222
values
(-2), 
(0),
(2),
(5)

-- 要求：找出两点之间最近的
with
t1 as(
	select A.X A,B.X B,
		abs(A.X - B.X) cha
	from F0222 A, F0222 B
	where A.X <> B.X
)
select top 1 * from t1 order by cha

-- 方法二
select min(abs(A.X - B.X))
from F0222 A
join F0222 B
on A.X <> B.X  -- 用不等于条件来连接，返回两列不相等的所有组合