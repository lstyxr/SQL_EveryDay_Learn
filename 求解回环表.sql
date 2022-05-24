drop table f0331 

create table f0331(
	SN int,
	ID varchar(10),
	od varchar(10),
	nw varchar(10)
)

insert into f0331 
values
(1, '1', '212', '302'),
(2, '1', '302', '109'),
(3, '1', '109', '200'),
(4, '1', '101', '235'),
(5, '1', '235', '332'),
(6, '1', '145', '330')

-- 要求：求出每个回环的开始和结束记录
-- 解题思路
-- 通过递归获取每组回环数据记录

with recursive tmp(SN, ID, od, nw, deep) as
(
	select SN, ID, od, nw, 1 as deep from f0331 where SN=1
	union all 
	select t1.SN, t1.ID, t1.od, t1.nw, t2.deep + 1
	from f0331 t1, tmp t2
	where t2.deep < 3
	and t1.od = t2.nw
)
select * from tmp

with recursive tmp as(
select *, od OLDEST from f0331 where SN = 1
union all 
select B.*,
	case when A.nw = B.od then A.OLDEST else B.od end
from tmp A, f0331 B
where B.SN = A.SN + 1
)
select 
	(select A.od from f0331 A where A.SN = min(X.SN)) StartValue,
	(select A.nw from f0331 A where A.SN = max(X.SN)) EndValue
from tmp X
group by OLDEST