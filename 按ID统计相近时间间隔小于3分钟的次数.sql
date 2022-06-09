create table F0308(
	user_id int,
	times datetime
)

insert into F0308
values
(1,'2021-12-07 21:13:07'),
(1,'2021-12-07 21:15:07'),
(1,'2021-12-07 21:17:07'),
(2,'2021-12-13 21:14:06'),
(2,'2021-12-13 21:18:19'),
(2,'2021-12-13 21:20:36'),
(3,'2021-12-21 21:16:51'),
(4,'2021-12-16 22:22:08'),
(4,'2021-12-02 21:17:22'),
(4,'2021-12-30 15:15:44'),
(4,'2021-12-30 15:17:57')

-- 要求：求每个用户相邻两次浏览时间之差小于三分钟的次数

-- 1、开窗得出每个用户按时间排序的序号
with
t1 as(
	select *,
		row_number() over(partition by user_id order by times) rn
	from f0308
),
t2 as(
	select A.user_id,
		abs(datediff(minute, 
		isnull(A.times, '1970-01-01 00:00:00'), -- 为空返回缺省值
		isnull(B.times, '1970-01-01 00:00:00'))) time_dec
	from t1 A
	left join t1 B
	on A.rn = B.rn + 1  -- 错位关联条件
	and A.user_id = B.user_id
)
select user_id, 
sum(case when time_dec<3 then 1 else 0 end) 小于三分钟计数
from t2 group by user_id