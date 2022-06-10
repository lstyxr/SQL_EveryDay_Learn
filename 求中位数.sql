create table F0309(
	ID int,
	Company varchar(10),
	Salary int
)

insert into F0309
values
(1,'A',10000),
(2,'A',9000),
(3,'A',11000),
(4,'A',8000),
(5,'B',12000),
(6,'B',13000),
(7,'B',14000),
(8,'C',12000),
(9,'C',9000),
(10,'C',9000),
(11,'C',11000)

-- 求：按公司求员工工资中位数
with
temp as(
	select *,
		ROW_NUMBER() over(partition by Company order by Salary) RN,
		count(ID) over(partition by Company) ID_Count
	from f0309
)
select Company,
	--sum(Salary)/COUNT(1) Mid  求和再除以计数
	AVG(Salary) Mid -- 直接平均法
from temp
where 
	(ID_Count%2=1 and RN = FLOOR(ID_Count/2) + 1)
or
	(ID_Count%2=0 and (RN = FLOOR(ID_Count/2) or RN = FLOOR(ID_Count/2) + 1))
group by Company