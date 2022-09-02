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

/* Ҫ�󣺲�ѯ��ÿ���������ţ�ShipID�����縶��ʱ�䣨PayDate���Ͷ�Ӧ����С����ţ�PayNo��,���ֽⷨ*/

-- ����ⷨ��û�и���ʱ����з��飬�����С�������ȫ����С1
select
	ShipID,
	MIN(Paydate) MinDate,
	MIN(PayNo) MinNo
from F0607
group by ShipID

-- �ⷨһ
select a.ShipID, b.min_paydate, MIN(a.PayNo) min_payno
from
	F0607 a
join
(select ShipID, MIN(PayDate) min_paydate from F0607 group by ShipID) b
on a.ShipID = b.ShipID and a.PayDate = b.min_paydate
group by a.ShipID, b.min_paydate

-- �ⷨ�� ��������
select ShipID, PayDate, PayNo
from
	(select
		*,
		RANK() over(partition by ShipID order by PayDate,PayNo) rnk
	from F0607) tmp
where rnk=1