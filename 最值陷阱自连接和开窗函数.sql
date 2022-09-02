create table F0607(
	ShipID INT,
	PayDate DATE,
	PayNo INT
)

insert into F0607 values
(1001, '2020/11/2', 5),
(1001, '2020/11/2', 3),
(1001, '2020/11/3', 1),
(1001, '2020/11/3', 3),
(1002, '2020/11/9', 1),
(1002, '2020/11/9', 4),
(1002, '2020/11/8', 3),
(1002, '2020/11/8', 2)

select * from F0607

/* 要求：查询出每个发货单号（ShipID）最早付款时间（PayDate）和对应的最小付款单号（PayNo）,多种解法*/

-- 错误解法，没有根据时间进行分组，因此最小付款单号是全表最小1
select
	ShipID,
	MIN(Paydate) MinDate,
	MIN(PayNo) MinNo
from F0607
group by ShipID

-- 解法一
select a.ShipID, b.min_paydate, MIN(a.PayNo) min_payno
from
	F0607 a
join
(select ShipID, MIN(PayDate) min_paydate from F0607 group by ShipID) b
on a.ShipID = b.ShipID and a.PayDate = b.min_paydate
group by a.ShipID, b.min_paydate

-- 解法二 开窗函数
select ShipID, PayDate, PayNo
from
	(select
		*,
		RANK() over(partition by ShipID order by PayDate,PayNo) rnk
	from F0607) tmp
where rnk=1