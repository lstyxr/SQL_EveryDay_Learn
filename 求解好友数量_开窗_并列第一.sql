create table F0225(
	requester_id int,
	accepter_id int,
	accept_date date
)

insert into F0225
values
(1,2,'2016-06-03'),
(1,3,'2016-06-08'),
(2,3,'2016-06-08'),
(3,4,'2016-06-09')

-- 要求：找出好友数最多的ID
with 
tmp as(
	select requester_id IDS from F0225
	union all
	select accepter_id IDS from F0225
)
select top 1 IDS, COUNT(*) CNT from tmp
group by IDS
order by CNT desc

-- 考虑有并列第一的ID

delete from F0225

insert into F0225
values
(1,2,'2016-06-03'),
(1,3,'2016-06-08'),
(2,3,'2016-06-08'),
(3,4,'2016-06-09'),
(1,4,'2016-06-09')

with
tmp as(
	select requester_id ID from F0225
	union all 
	select accepter_id ID from F0225
),
tmp2 as(
	select ID, COUNT(*) CNT
	from tmp
	group by ID
),
tmp3 as(
	select ID, CNT,
		RANK() over(order by CNT desc) RNK
	from tmp2
)
select * from tmp3 where RNK=1