create table F0217(
	ID int,
	Uname varchar(20),
	Price int,
	BuyDate varchar(20)
)

insert into F0217
values
(1, '张三', 180, '2021/12/1'),
(2, '张三', 280, '2021/12/7'),
(3, '李四', 480, '2021/12/10'),
(4, '李四', 280, '2021/12/1'),
(5, '王五', 280, '2021/12/1'),
(6, '王五', 880, '2021/12/11'),
(7, '王五', 380, '2021/12/15')

-- 取所有记录中Uname的Price最大值所对应的那行完整数据
-- 错误解法
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
and A.Price = B.Max_Price -- 名字和价格都要相等

-- --------------------------
select *
from(
	select *,
	row_number() over(partition by Uname order by Price desc) num
	from f0217
)tmp
where num=1


