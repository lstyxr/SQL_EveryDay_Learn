create table F0224(
	ID int,
	金额 int
)

insert into f0224 
values
(2,30),
(3,30),
(4,30),
(11,9),
(12,1),
(13,1),
(14,15),
(15,33),
(16,5),
(17,8),
(18,14),
(19,3)

-- 要求：查询出第一条记录开始到第几条记录的累计金额刚好超过100？

-- 解法1
with 
tmp as(
	select *,
		sum(金额) over(order by ID) 金额累计
	from f0224
)
select *, min(ID) 
from tmp 
where 金额累计 > 100

-- 自连接
with
tmp as(
	select B.ID BID, A.ID AID, A.金额, sum(A.金额) 金额_sum  
	from f0224 A
	join f0224 B
	on B.ID >= A.ID
	group by B.ID 
)
select * from tmp where 金额_sum > 100 limit 1
