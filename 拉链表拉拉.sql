create table F0324(
	USEID int,
	OPERATION varchar(10),
	DATE date
)

insert into F0324
values
(1001,'创建订单','2021/1/1'),
(1001,'支付订单','2021/1/2'),
(1001,'确认收货','2021/1/5'),
(1002,'创建订单','2021/1/1'),
(1002,'支付订单','2021/1/3'),
(1003,'创建订单','2021/1/2')

/*
要求：生成一张拉链表
何谓拉链表：
	同个USEID，DATE从小到大排序后，每个操作日期作为开始日期，操作日期的下一个日期作为结束日期，
	例如：USEID为1001组，第一个日期是2021/1/1，第二个日期是2021/1/2，那么第一个日期2021/1/1的
	结束日期为2021/1/2，以此类推，如果是最后一个日期，那么结束日期默认为9999/12/31
*/

with
t1 as(
	select *,
		ROW_NUMBER() over(partition by USEID order by DATE) row_num
	from F0324
)
select 
	A.USEID,
	A.OPERATION,
	A.DATE Start_Date,
	ISNULL(B.DATE,'9999-12-31') End_Date
from t1 A
left join t1 B
on A.row_num + 1 = B.row_num
and A.USEID = B.USEID

-- 窗口函数的第二各写法，不partition by 就用一个order by
with
t1 as(
	select *,
		ROW_NUMBER() over(order by USEID,DATE) row_num
	from F0324
)
select 
	A.USEID,
	A.OPERATION,
	A.DATE Start_Date,
	ISNULL(B.DATE,'9999-12-31') End_Date
from t1 A
left join t1 B
on A.row_num + 1 = B.row_num
and A.USEID = B.USEID