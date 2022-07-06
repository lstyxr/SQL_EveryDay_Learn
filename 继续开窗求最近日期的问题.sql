create table F0518(
	商品 nvarchar(22),
	日期 date,
	单价 int,
	数量 int
)

insert into F0518
values
('桌子', '2022-01-01',100,1),
('椅子', '2022-01-01',50,4),
('桌子', '2022-01-02',100,2),
('桌子', '2022-01-02',105,1)

-- 要求：查找每种商品 最近一天 的日平均单价
with
t1 as(
	select *,
		DENSE_RANK() over(partition by 商品 order by 日期 desc) RK
	from F0518
)
select 商品,日期,
	SUM(数量*单价)*1.0 / SUM(数量) as 平均价
from t1
where RK = 1
group by 商品,日期