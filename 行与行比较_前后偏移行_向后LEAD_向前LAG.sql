create table F0303(
	工序 int,
	部门编号 int not null,
	完成数量 int not null
)

insert into F0303
values
(10,222,1500),
(20,223,1497),
(30,223,1499),
(40,223,1498),
(50,213,1497),
(60,224,1497),
(70,224,1497),
(80,220,1496),
(90,220,1496),
(100,224,0)

-- 要求：按工序排序，相邻的行，如果有部门相同的情况，取工序号最大的那一行记录
-- 行偏移开窗函数：LEAD(被偏移的列，向前偏移行数，超出分区返回的默认值) over()
with
tmp as(
	select *,
		LEAD(部门编号, 1, NULL) over(order by 工序) LEAD_1,
		LEAD(部门编号, 2, NULL) over(order by 工序) LEAD_2,
		LAG(部门编号, 1, NULL) over(order by 工序) LAD_1
	from F0303
)
select 工序,部门编号,完成数量
from tmp
where 部门编号 <> LEAD_1