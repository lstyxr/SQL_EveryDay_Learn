create table F0217(
	ID int,
	Uname varchar(20),
	Price int,
	BuyDate varchar(20)
)

insert into F0217
values
(1, '����', 180, '2021/12/1'),
(2, '����', 280, '2021/12/7'),
(3, '����', 480, '2021/12/10'),
(4, '����', 280, '2021/12/1'),
(5, '����', 280, '2021/12/1'),
(6, '����', 880, '2021/12/11'),
(7, '����', 380, '2021/12/15')

-- ȡ���м�¼��Uname��Price���ֵ����Ӧ��������������
-- ����ⷨ
select ID, Uname, BuyDate, max(Price) Price from f0217
group by ID, Uname, BuyDate

-- -------------
with tmp as 
(select *,
	max(Price) over(partition by Uname) MAX_Price
from f0217)
select * from tmp where Max_Price=Price

-- --------------
select A.* from f0217 A
join(
	select Uname, max(Price) Max_Price
	from f0217 
	group by Uname
) B
on A.Uname = B.Uname 
and A.Price = B.Max_Price -- ���ֺͼ۸�Ҫ���

-- --------------------------
select *
from(
	select *,
	row_number() over(partition by Uname order by Price desc) num
	from f0217
)tmp
where num=1


