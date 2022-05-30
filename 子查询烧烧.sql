create table F0221A(
	stuID int, classID varchar(20), stuName varchar(20)
)

insert into F0221A
values
(1, 'A', '张三'),
(2, 'A', '李四'),
(3, 'B', '王五'),
(4, 'A', '赵六')

create table F0221B(
	classID varchar(20),
	className varchar(20)
)

insert into F0221B
values
('A', '一班'),
('B', '二班')

create table F0221C(
	stuID int, course varchar(20), score int
)

insert into F0221C
values
(1, '语文', 80),
(1, '数学', 90),
(1, '英语', 90),
(2, '语文', 89),
(2, '数学', 91),
(2, '英语', 88),
(3, '语文', 95),
(3, '数学', 77),
(3, '英语', 72),
(4, '语文', 89),
(4, '数学', 91),
(4, '英语', 88)

select * from F0221A  -- 学生表
select * from F0221B  -- 班级表
select * from F0221C  -- 成绩表

-- 要求：查询一班各科成绩最高的学生姓名和对应的分数

-- 窗口函数与子查询
with 
tmp as(
	select A.stuID, A.stuName, B.className, C.course, C.score from F0221C C
	join F0221A A
	on A.stuID = C.stuID
	join F0221B B
	on B.classID = A.classID and className = '一班'
),
t1 as(
	select *, 
	DENSE_RANK() over(order by score desc) score_num 
	from tmp where course = '语文'
),
t2 as(
	select *, 
	DENSE_RANK() over(order by score desc) score_num 
	from tmp where course = '数学'
),
t3 as(
	select *, 
	DENSE_RANK() over(order by score desc) score_num 
	from tmp where course = '英语'
)
select * from t1 where score_num = 1
union all
select * from t2 where score_num = 1
union all
select * from t3 where score_num = 1


-- 纯子查询
-- 首先找出一班的学生
with 
t1 as(
	select stuID, stuName
	from F0221A 
	join F0221B 
	on F0221A.classID = F0221B.classID and F0221B.className = '一班'
),
-- 再在一班中找出各科最大分数
t2 as(
	select course, MAX(score) score_max 
	from F0221C
	join t1 on t1.stuID = F0221C.stuID
	group by course
)
-- 最后 select 所需要的字段
select t1.stuID, t1.stuName, t2.course, t2.score_max
from F0221C C
join t2 on t2.course = C.course and t2.score_max = C.score
join t1 on t1.stuID = C.stuID


select *, DENSE_RANK() over(partition by course order by score) from F0221C