create table Student(
	s_id VARCHAR(10),
	s_name VARCHAR(20),
	s_birth DATE,
	s_sex VARCHAR(5)
)

insert into Student
values
('01','赵雷','1990-01-01','男'),
('02','钱电','1990-12-21','男'),
('03','孙风','1990-05-20','男'),
('04','李云','1990-08-06','男'),
('05','周梅','1991-12-01','女'),
('06','吴兰','1992-03-01','女'),
('07','郑竹','1989-07-01','女'),
('08','王菊','1990-01-20','女')

create table Course(
	c_id VARCHAR(10),
	c_name VARCHAR(20),
	t_id VARCHAR(10)
)

insert into Course
values
('01','语文','02'),
('02','数学','01'),
('03','英语','03')

create table Teacher(
	t_id VARCHAR(6),
	t_name VARCHAR(20)
)

insert into Teacher
values
('01','张三'),
('02','李四'),
('03','王五')

create table Score(
	s_id VARCHAR(10),
	c_id VARCHAR(10),
	s_score NUMERIC(18,5)
)

insert into Score
values
('01','01',80),
('01','02',90),
('01','03',99),
('02','01',70),
('02','02',60),
('02','03',80),
('03','01',80),
('03','02',80),
('03','03',80),
('04','01',50),
('04','02',30),
('04','03',20),
('05','01',76),
('05','02',87),
('06','01',31),
('06','03',34),
('07','02',89),
('07','03',98)

--1、查询“01”课程比“02”课程成绩高的学生信息及课程分数
-- score,student

select
	c.*,
	a.s_score s01,
	b.s_score s02
from
	Score a, Score b, Student c
where
	a.c_id='01'
and b.c_id='02'
and a.s_id=b.s_id
and a.s_score>b.s_score
and a.s_id=c.s_id

-- 长表转宽表、数据透视
select
	s.*,
	t.s01,t.s02
from
	(select
		a.s_id,
		MAX(case when a.c_id='01' then a.s_score end) s01,
		MAX(case when a.c_id='02' then a.s_score end) s02
	from
		Score a
	group by a.s_id) t,Student s
where t.s01>t.s02
and s.s_id=t.s_id

--2、查询“01”课程比“02”课程成绩低的学生信息及课程分数
select
	s.*,
	t.s01,t.s02
from
	(select
		a.s_id,
		MAX(case when a.c_id='01' then a.s_score end) s01,
		MAX(case when a.c_id='02' then a.s_score end) s02
	from
		Score a
	group by a.s_id) t,Student s
where t.s01<t.s02
and s.s_id=t.s_id

--3、查询平均成绩大于等于60分的同学的学生编号、学生姓名和平均成绩
-- 子查询
select
	a.s_id,
	(select s.s_name from Student s where s.s_id=a.s_id) s_name,
	AVG(s_score) avg_s
from
	Score a
group by
	a.s_id
having
	AVG(a.s_score)>60

-- 两个表连接
select
	a.s_id,s.s_name,
	AVG(a.s_score) avg_s
from
	Score a,Student s
where
	a.s_id=s.s_id
group by
	a.s_id,s.s_name
having
	AVG(a.s_score)>=60

--3、查询平均成绩小于60分的同学的学生编号、学生姓名和平均成绩
select
	a.s_id,s.s_name,
	AVG(a.s_score) avg_s
from
	Score a,Student s
where
	a.s_id=s.s_id
group by
	a.s_id,s.s_name
having
	AVG(a.s_score)<60


--4、查询所有同学的学生编号、学生姓名、选课总数、所有课程的总成绩
select
	a.s_id,
	s.s_name,
	COUNT(a.c_id) cnt_c,
	SUM(a.s_score) sum_s
from
	Score a, Student s
where
	a.s_id=s.s_id
group by
	a.s_id,s.s_name


select
	a.s_id,
	s.s_name,
	COUNT(a.c_id) cnt_c,
	SUM(a.s_score) sum_s
from
	Score a
right join
	Student s
on
	a.s_id=s.s_id
group by
	a.s_id,s.s_name