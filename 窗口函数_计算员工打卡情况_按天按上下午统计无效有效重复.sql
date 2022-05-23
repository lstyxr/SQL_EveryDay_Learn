create table F0415(
	UserID int,
	CheckIn datetime
)

delete from demo.f0415

insert into f0415 
values
(1, '2018/12/1 8:25'),
(1, '2018/12/1 8:26'),
(1, '2018/12/1 17:02'),
(1, '2018/12/2 8:27'),
(2, '2018/12/1 8:26'),
(2, '2018/12/1 17:03'),
(2, '2018/12/1 17:29'),
(2, '2018/12/1 18:01'),
(2, '2018/12/1 17:30')

/*
	要求：1、每天上午8：00 - 9：00，下午 16：00 - 18：00这两个时间段内的最早一次记录视为“有效”，
		2、在这两个时间段内其它打卡数据显示为“重复”,否则为“无效”  
*/

select date(now())

with 
t1 as
(select *,
	case when -- 上、下午分别贴上标签1、2
		time(CheckIn) between '08:00' and '09:00' then 1  -- 时间各位应二位，不能是'8:00',而是 '08:00'
		when 
		time(CheckIN) between '16:00' and '18:00' then 2
		else 0
	end as 状态
from f0415),
t2 as
(-- 按用户、状态、日期进行分组编号
select *,
	row_number() over (partition by t1.UserID, date(t1.CheckIn), t1.状态 order by t1.CheckIn) as 状态2
from t1)
select *,
	case when 状态=0 then '无效' 
		 when 状态>0 and 状态2=1 then '有效'
		 when 状态>0 and 状态2>=2 then '重复'
	end as 打卡状态
from t2