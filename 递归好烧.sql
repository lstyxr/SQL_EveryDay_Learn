create table F0307(
	ID int,
	PRODUCTNAME varchar(64),
	PARENTID int
)

insert into F0307
values
(1,'汽车',NULL),
(2,'车身', 1),
(3,'发动机',1),
(4,'车门',2),
(5,'驾驶舱',2),
(6,'行李舱',2),
(7,'气缸',3),
(8,'活塞',3)

-- 要求：根据父ID（PARENTID）来逐级显示产品名和层级序号
/*什么是递归
至少包含两个查询，第一个查询为定点成员，定点成员只是一个返回有效表的查询，用于递归的基础或定位点
				  第二个查询为递归成员，使该查询称为递归成员的是对CTE名称的递归引用是触发
				  在逻辑上可以将CTE名称的内部应用理解为前一个查询的结果集
*/

with
CTE as(
	--定点成员
	select ID, PARENTID,PRODUCTNAME,
		0 CTELEVEL, CAST(ID AS varchar) OrderID
	from F0307 where ID=1
	union all
	-- 递归成员
	select A.ID, A.PARENTID, A.PRODUCTNAME,
		B.CTELEVEL + 1,CAST(B.OrderID + '->' + LTRIM(A.ID) as varchar)
	from F0307 A
	join CTE B on B.ID = A.PARENTID  -- 关联CTE自己，通常是子ID与父ID进行关联
)
select ID, PARENTID,
	RIGHT('      ',4*CTELEVEL) + PRODUCTNAME PRODUCTNAME, OrderID
from CTE
order by OrderID