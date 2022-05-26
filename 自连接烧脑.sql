create table F0216(
	Num int
)

insert into f0216
values
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9)

select * from f0216

/*
要求：求出3个或2个不同数相加等于10的全部组合  
*/

select t1.Num, t2.Num, t3.Num
from
	f0216 t1, f0216 t2, f0216 t3
where 
	t1.Num + t2.Num + t3.Num = 10
and t1.Num <> t2.Num
and t1.Num <> t3.Num
and t2.Num <> t3.Num
union all 
select t1.Num, t2.Num, null 
from
	f0216 t1, f0216 t2
where 
	t1.Num + t2.Num = 10
and t1.num <> t2.Num