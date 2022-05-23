drop table f0406

create table F0406(
	物品 varchar(10),
	购买日期 varchar(20),
	单价 int
)

insert into f0406
values
('A', '2018-11-01', 100),
('A', '2018-10-01', 120),
('A', '2018-12-01', 115),
('B', '2018-11-01', 99),
('B', '2018-09-01', 88)

-- 依次查出最新单价，上次单价，上上次单价，如果不存在则用0替代
with 
t_over as
(select *,
	row_number() over(partition by 物品 order by 购买日期 desc) sort_num
from f0406)
select
	t1.*, 
	case when t2.单价 is null then 0 else t2.单价 end as 上一次单价,
	case when t3.单价 is null then 0 else t3.单价 end as 上上次
from
(select 物品, 单价 最新单价 from t_over where sort_num=1) as t1
left join t_over as t2 on t2.物品 = t1.物品 and t2.sort_num=2
left join t_over as t3 on t3.物品 = t1.物品 and t3.sort_num=3