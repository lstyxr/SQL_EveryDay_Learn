create table F0215(
	StuID int,
	CID varchar(10),
	Course int
)

insert into F0215
values
(1, '001', 67),
(1, '002', 89),
(1, '003', 94),
(2, '001', 95),
(2, '004', 78),
(3, '001', 94),
(3, '002', 77),
(3, '003', 90)

/*
要求：找出001和003都学过的学生id
*/

-- 错误写法, CID既是001也是003，
-- 严重逻辑错误，返回结果为空，没有结果满足条件
select * from F0215
where CID = '001' and CID = '003'

-- CID是001 或者是 003
-- 不符合题意，ID为2的学生只学过001，没学过003，不应该返回
select * from F0215
where CID = '001' or CID = '003'

-- 思路1， 取自连接
with 
t1 as(
	select * from F0215 where CID = '001'
),
t2 as(
	select * from F0215 where CID = '003'
)
select * from t1 inner join t2 on t1.StuID = t2.StuID

-- 自连接，烧脑
select * from F0215 A, F0215 B  -- 迪卡尔积？
where A.StuID = B.StuID         -- 用学生ID关连筛选符合逻辑的数据，因为同一行学生ID不同无意义 
and A.CID = '003'               -- 再分别筛选001 和 003 ，排除其它的，这里有点烧脑
and B.CID = '001'               -- 实际就是生成两列CID，两列的联合筛选， 在电子表格中如何实现

-- 取交集， 最好理解的方式
select SC.StuID
from F0215 SC
where SC.CID = '001'
intersect
select SC.StuID
from F0215 SC
where SC.CID = '003'

-- 最简单的解法
select StuID
from F0215
where CID in ('001', '003')
group by StuID
having COUNT(StuID) = 2

-- 最简单的解法变种
with 
tmp as(
	select * from F0215 where CID = '001'
	union all
	select * from F0215 where CID = '003'
)
select StuID, COUNT(CID) CID_COUNT from tmp 
group by StuID 
having COUNT(StuID) = 2


-- 思路2，开窗
with
t1 as( 
	select * from F0215
	where CID = '001' or CID = '003'
)
select distinct StuID from
	(select *,
		COUNT(*) over(partition by StuID) CID_COUNT
	from t1) t2
where CID_COUNT = 2
