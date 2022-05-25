create table F0329(
	workid varchar(20),
	RecDate date,
	RecTime varchar(20),
	Time4 varchar(20)
)

insert into f0329 
values
('161181', '2021-05-03', '13:01', '13:01'),
('161181', '2021-05-03', '14:01', '15:01'),
('161181', '2021-05-06', '13:01', '13:01'),
('161182', '2021-05-07', '13:01', '17:01'),
('161182', '2021-05-07', '13:01', '18:01'),
('161182', '2021-05-09', '13:01', '19:01')

-- Ҫ�󣺰����Ų������ڣ�RecDate����ͬ�Ҽ�¼��>1,��Rectime=Time4
-- ����һ�����ں���
with tmp as(
	select *,
		count(*) over(partition by workid, RecDate) ��ͬ�������� 
	from f0329
)
select * from tmp where RecTime = Time4 and ��ͬ��������>1

-- ���������Ӳ�ѯ
with t1 as 
(select * from f0329 where RecTime = Time4)
select t1.* from t1
inner join
	(select workid, RecDate 
	from f0329 
	group by workid, RecDate 
	having count(1)>1) t2
on t2.workid = t1.workid and t1.RecDate = t2.RecDate