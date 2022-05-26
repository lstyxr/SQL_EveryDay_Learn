create table F0325(
	ID int,
	NAMES varchar(20),
	Salary int,
	DepartmentID int
)

insert into F0325 values
(1, '曹操', 85000, 1),
(2, '关羽', 80000, 2),
(3, '刘备', 60000, 2),
(4, '吕布', 90000, 1),
(5, '张飞', 69000, 1),
(6, '赵云', 85000, 1),
(7, '黄忠', 70000, 1)

create table F0325B(
	ID int,
	Name varchar(20)
)

insert into F0325B values
(1, 'IT'),
(2, 'Sales')

-- 解法一，窗口函数
with 
tmp1 as
	(select A.*, B.Name from F0325 A join F0325B B on A.DepartmentID=B.ID),
tmp2 as
	(select *,
	DENSE_RANK() over(partition by DepartmentID order by Salary desc) RK
	from tmp1)
select * from tmp2 where RK<=3

-- 解法二
select *
from F0325 F1
join F0325B D on F1.DepartmentID = D.ID
where(
	-- Salary=90000
	select
	COUNT(distinct F2.Salary) 
	from F0325 F2
	where F2.Salary >= F1.Salary
	and F2.DepartmentID = F1.DepartmentID
)<=3
order by D.Name, F1.Salary desc