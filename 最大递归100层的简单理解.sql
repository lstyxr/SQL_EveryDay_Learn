create table F0617(
	ID INT,
	EndTime DATETIME
)

insert into F0617
values
(1,'2020/5/26 16:00'),
(2,'2020/5/26 17:30')

-- 要求：每条记录每次增加30分钟，增加3次（用递归）
with
CTE AS(
	select ID, EndTime, 1 as NUM
	from F0617
	UNION ALL
	select ID, DATEADD(MINUTE,30,c.EndTime), c.NUM+1
	from CTE c
	where NUM<101 -- 最大递归100层
)
select * from
CTE c
order by c.ID, c.EndTime