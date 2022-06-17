create table F0321(
	员工号 nvarchar(10),
	姓名 nvarchar(10),
	性别 nvarchar(2),
	类别 nvarchar(10),
	入职日期 date
)

insert into F0321
values
('1001','张三','男','普通','2021-08-03'),
('1002','李四','女','管理','2021-08-18'),
('1003','王五','男','普通','2021-08-19'),
('1004','赵六','女','管理','2021-08-04')

/*
1) 如果员工的类别是【普通】，则员工的【转正日期】为【入职日期】后三个月；
   如果员工的类别是【管理】，则员工的【转正日期】为【入职日期】后六个月；
2) 如果【入职日期】在15号及以前，则【社保缴纳月份】为当月；
   如果【入职日期】在15号以后，则【社保缴纳月份】为次月；   
*/

select *,
	case when 类别 = '普通' 
		then DATEADD(MONTH, 3, 入职日期)
		else DATEADD(MONTH, 6, 入职日期)
	end as 转正日期,
	case when DATEPART(DAY, 入职日期) <= 15
		then CONVERT(char(7), 入职日期, 120)
		else CONVERT(char(7), dateadd(month, 1, 入职日期), 120)
	end as 社保缴纳月份
from F0321

-- 日期函数用法
select DATEADD(MONTH,1,GETDATE())
select DATEADD(MONTH,-1,GETDATE())

select DATEPART(YEAR, GETDATE())
select DATEPART(WEEK, GETDATE())
select DATEPART(WEEKDAY, GETDATE())
select DATENAME(WEEKDAY, GETDATE())
select DATENAME(QUARTER, GETDATE())