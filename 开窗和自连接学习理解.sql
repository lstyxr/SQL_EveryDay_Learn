create table F0622(
	play_id INT,
	device_id INT,
	event_date DATE,
	games_played INT
)

insert into F0622
values
(1,2,'2016/3/1',5),
(1,2,'2016/5/2',6),
(1,3,'2017/6/25',1),
(3,1,'2016/3/2',0),
(3,4,'2018/7/3',5)

select * from F0622

-- 要求：查询每个玩家每天累计玩游戏的数量有多少？

-- 解法一：开窗
select play_id,event_date,
	SUM(games_played) over(partition by play_id order by event_date) games_played_so_far
from
F0622

-- 解法二：自连接
select t1.play_id,t1.event_date,
	sum(t2.games_played) games_played_so_far
from
F0622 t1, F0622 t2
where t1.play_id = t2.play_id 
	and t2.event_date <= t1.event_date
group by t1.play_id,t1.event_date
order by t1.play_id,t1.event_date