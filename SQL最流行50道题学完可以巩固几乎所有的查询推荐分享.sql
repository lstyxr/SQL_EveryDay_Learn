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

--4、查询平均成绩小于60分的同学的学生编号、学生姓名和平均成绩，注意要包含没有成绩的学生
--不包含没有成绩的学生
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

--包含没有成绩的学生
select
	s.s_id,
	s.s_name,
	isnull(AVG(a.s_score),0) avg_s
from
	Score a
right join
	Student s
on
	s.s_id=a.s_id
group by
	s.s_id,
	s.s_name
having
	isnull(AVG(a.s_score),0)<60
order by
	s.s_id

--5、查询所有同学的学生编号、学生姓名、选课总数、所有课程的总成绩，注意要包含没有成绩的学生
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
	s.s_id,
	s.s_name,
	COUNT(a.c_id) cnt_c,
	isnull(SUM(a.s_score),0) sum_s
from
	Score a
right join
	Student s
on
	a.s_id=s.s_id
group by
	s.s_id,
	s.s_name
order by
	s.s_id

--6、查询 ‘李’姓老师的数量
select
	count(*) cnt_t
from
	Teacher
where
	t_name like '李%'

--7、查询学过‘张三’老师授课的学生信息
select * from Score
select * from Student
select * from Teacher
select * from Course

--自创
select
	*
from
	Student
where
	s_id
in
	(select
		a.s_id
	from
		Score a
	where
		a.c_id
in
	(select
		c.c_id
	from
		Course c
	where
		c.t_id
in
	(select
		t.t_id
	from
		Teacher t
	where
		t.t_name='张三')))

--简化
select
	d.*
from
	Score a, Course b, Teacher c, Student d
where
	a.c_id=b.c_id
and b.t_id=c.t_id
and	d.s_id=a.s_id
and	c.t_name='张三'

--8、查询没学过‘张三’老师授课的学生信息
--not in方法
select * from Student where s_id not in(
select
	a.s_id
from
	Score a, Course b, Teacher c
where
	a.c_id=b.c_id
and b.t_id=c.t_id
and	c.t_name='张三')

--not exists方法
select * from Student where not exists(
	select 1 from
		(select
			a.s_id
		from
			Score a, Course b, Teacher c
		where
			a.c_id=b.c_id
		and b.t_id=c.t_id
		and c.t_name='张三') t
	where t.s_id=Student.s_id)

--9、查询学过编号‘01’并且也学过编号‘02’课程的同学信息
--自创
select * from Student where s_id in(
select
	t2.s_id
from
	(select
		t.s_id,
		COUNT(t.c_id) cnt_c
	from
		(select
			*
		from
			Score a
		where
			a.c_id in ('01','02')) t
	group by
		t.s_id
	having
		COUNT(t.c_id)>1) t2)

--自连接
select
	c.*
from
	Score a,Score b,Student c
where
	a.c_id='01'
and b.c_id='02'
and a.s_id=b.s_id
and a.s_id=c.s_id

--10、查询学过编号‘01’但没有学过编号‘02’课程的同学信息
--长表转换宽表方法
select
	s.*
from
	(select
		s.s_id,
		max(case when s.c_id='01' then s.s_score end) s01,
		MAX(case when s.c_id='02' then s.s_score end) s02
	from
		Score s
	group by
		s.s_id) t,Student s
where
	s.s_id=t.s_id
and t.s01 is not null
and t.s02 is null

--11、查询没有学全所有课程的学生信息
--course score student
select * from Student where exists(
	select * from
		(select
			a.s_id,
			COUNT(b.c_id) cnt_c
		from
			Student a
		left join
			Score b
		on a.s_id=b.s_id
		group by
			a.s_id
		having
			COUNT(b.c_id)<
			(select COUNT(c_id) from Course)) t
	where
		t.s_id=Student.s_id)

--12、查询至少有一门课与学号为‘01’的同学所学相同的学生信息
--in方法，distinct去重
select
	distinct a.*
from
	Student a
left join
	Score b
on a.s_id=b.s_id
where b.c_id in
	(select c_id from Score where s_id='01')
--in方法，分组去重
select
	a.*
from
	Student a
left join
	Score b
on a.s_id=b.s_id
where b.c_id in(
	select c_id from Score where s_id='01')
group by a.s_id,a.s_name,a.s_birth,a.s_sex

--exists方法
select
	distinct a.*
from
	Student a
left join
	Score b
on
	a.s_id=b.s_id
where exists(
	select * from
		(select c_id from Score where s_id='01') t
	where
		t.c_id=b.c_id)

--查询和‘01’号同学所学完全相同的其他同学的信息
--构建假设和‘01’所学都相同的临时表
--full join方法
select * from Student 
where s_id not in(
	select t2.s_id 
	from
		(select
			t.*,s.c_id cid2
		from
			(select
				a.*,b.c_id
			from
				Student a,
				(select c_id from Score where s_id='01') b) t
		full join
			Score s
		on  t.s_id=s.s_id
		and s.c_id=t.c_id) t2
	where t2.cid2 is null or t2.c_id is null)
and s_id!='01'

--如果不支持full join方法，只能分别左右连接再union
with tmpT as(
select
	t.*,s.c_id cid2
from
	(select
		a.*,b.c_id
	from
		Student a,
		(select * from Score where s_id='01') b) t
right join
	Score s
on  s.s_id=t.s_id
and s.c_id=t.c_id
union
select
	t.*,s.c_id cid2
from
	(select
		a.*,b.c_id
	from
		Student a,
		(select * from Score where s_id='01') b) t
left join
	Score s
on  s.s_id=t.s_id
and s.c_id=t.c_id)
select * from Student where s_id not in(
select s_id from tmpT where c_id is null or cid2 is null)

--14、查询没学过‘张三’老师讲授的任一门课程的学生姓名
select s_name from Student where not exists(
	select * from
		(select
			s.s_id
		from
			Score s
		where s.c_id in(
			select 
				a.c_id
			from
				Course a,Teacher b
			where
				a.t_id=b.t_id
			and b.t_name='张三')) t
	where t.s_id=Student.s_id)

--15、查询两门及以上不及格课程的学生学号、姓名及其平均成绩
--自创
select
	*
from
	(select
		s.s_id,s.s_name,t2.avg_s
	from
		Student s
	left join
		(select
			t.s_id,
			AVG(t.s_score) avg_s
		from
			(select
				*
			from
				Score a
			where
				a.s_score<60) t
		group by
			t.s_id) t2
	on t2.s_id=s.s_id) t3
where t3.avg_s is not null

--老师
select
	s.s_id,s.s_name,AVG(a.s_score) avg_s,
	sum(case when a.s_score>=60 then 0 else 1 end) 不及格门数
from
	Student s
left join
	Score a
on  a.s_id=s.s_id
group by
	s.s_id,s.s_name
having
	sum(case when a.s_score>=60 then 0 else 1 end)>=2

--case when的理解，实际是生成新的一列，0代表及格、1代表不及格，再用sum函数求总的不及格门数
select
	s_id,
	sum(case when s_score>=60 then 0 else 1 end) sum_jg
from
	Score
group by
	s_id

--16、检索‘01’课程分数小于60，按分数降序排列的学生信息
--自创
select s.*,c.s_score from Student s,Score c where exists(
	select * from
		(select
			a.s_id
		from
			Score a
		where
			a.c_id='01' and s_score<60) t
	where
		t.s_id=s.s_id)
and s.s_id=c.s_id
and c.c_id='01'
order by c.s_score desc

--老师
select
	b.*,a.s_score
from
	Score a
right join
	Student b
on a.s_id=b.s_id
where
	a.c_id='01'
and a.s_score<60
order by a.s_score desc

--17、按平均成绩从高到低显示所有学生的所有课程的成绩以及平均成绩
select
	a1.*,a2.avg_s
from
	(select * from Score) a1,
	(select a.s_id,round(AVG(a.s_score),2) avg_s from Score a group by a.s_id) a2
where
	a1.s_id=a2.s_id
order by avg_s desc

--开窗
select
	a.*,
	AVG(a.s_score) over(partition by a.s_id) avg_S
from
	Score a
order by AVG(a.s_score) over(partition by a.s_id) desc

--18、查询各科成绩最高分、最低分和平均分；以如下形式显示：课程ID，课程name，最高分，最低分，平均分，及格率，中等率，优良率，优秀率
--及格为>=60,中等为：70-80，优良为：80-90，优秀为：>=90
select
	a.*,
	MAX(a.s_score) over(partition by a.c_id) max_s,
	MIN(a.s_score) over(partition by a.c_id) min_s,
	AVG(a.s_score) over(partition by a.c_id) avg_s
from
	Score a
--官方
select
	a.c_id,a.c_name,
	round(MAX(b.s_score),2) max_s, --貌似四舍五入后面也是补的0
	round(MIN(b.s_score),2) min_s,
	round(AVG(b.s_score),2) avg_s,
	round(sum(case when b.s_score>=60 then 1.0 else 0 end)/COUNT(1),2) 及格率,
	round(sum(case when b.s_score>=70 and b.s_score<80 then 1.0 else 0 end)/COUNT(1),2) 中等率,
	round(sum(case when b.s_score>=80 and b.s_score<90 then 1.0 else 0 end)/COUNT(1),2) 优良率,
	round(sum(case when b.s_score>=90 then 1.0 else 0 end)/COUNT(1),2) 优秀率
from
	Course a
left join
	Score b
on a.c_id=b.c_id
group by
	a.c_id,a.c_name

--19、按各科成绩进行排序，并显示排名
--窗口函数实现
select
	s.c_id,s.s_score,
	dense_RANK() over(partition by s.c_id order by s.s_score desc) rk --排名函数：rank(并列第一，间断)、dense_rank（并列第一、不间断）、row_number（输出行数）
from
	Score s

--子查询来实现，有点烧脑，
select
	a.*,
	(select COUNT(*) from Score b where b.c_id=a.c_id and b.s_score>a.s_score)+1 rk --理解：分别取a表每行分数值作为b表的查询条件了，
from
	Score a
order by
	a.c_id,a.s_score desc

--20、查询学生的总成绩并排名

--开窗函数实现
select
	t.*,
	RANK() over(order by sum_s desc) rk
from
	(select
		a.s_id,
		SUM(a.s_score) sum_s
	from
		Score a
	group by
		a.s_id) t

--子查询实现
with sum_s_tmp as
(select
	s_id,
	SUM(s_score) sum_s
from
	Score
group by
	s_id)
select 
	*,
	(select COUNT(*) from sum_s_tmp b where b.sum_s>a.sum_s)+1 rk
	--(select COUNT(*) from sum_s_tmp b where b.s_id=a.s_id and b.sum_s>a.sum_s)+1 rk，不能加条件b.s_id=a.s_id
from 
	sum_s_tmp a
order by
	a.sum_s desc

--21、查询不同老师所教不同课程平均分从高到低显示
--自创
select
	c.t_name,t.*
from
	(select 
		a.c_id,
		AVG(a.s_score) avg_s
	from
		Score a
	group by
		a.c_id) t,Course b, Teacher c
where
	t.c_id=b.c_id
and b.t_id=c.t_id
order by t.avg_s desc

--官方
select
	a.t_name,b.c_name,AVG(c.s_score) avg_s
from
	Teacher a
left join
	Course b
on a.t_id=b.t_id
left join
	Score c
on b.c_id=c.c_id
group by
	a.t_name,b.c_name
order by
	AVG(c.s_score) desc

--22、查询所有课程的成绩第2到第3名的学生信息及该课程成绩
-- 自创，理解上有区别，这里对课程进行了分组
select
	s.*,t2.c_id,c.c_name,t2.s_score,t2.rk
from
	(select
		*
	from
		(select
			*,
			RANK() over(partition by c_id order by s_score desc) rk
		from
			Score) t
	where
		t.rk>=2 and t.rk<=3) t2
left join
	Course c
on c.c_id=t2.c_id
left join
	Student s
on s.s_id=t2.s_id

-- 其实题意是不对课程分组，直接全部按分数排序
select
	s.*,t.c_id,c.c_name,t.s_score
from
	Student s
left join
	(select
		a.*,
		RANK() over(order by a.s_score desc) rk
	from
		Score a) t
on s.s_id=t.s_id
left join
	Course c
on c.c_id=t.c_id
where
	rk in(2,3)

--23、统计各科成绩各分数段人数，课程编号，课程名称[100,85)[85,70)[70,60)[60,0)及所占百分比
select
	a.c_id,a.c_name,
	sum(case when b.s_score>85 and b.s_score<=100 then 1 else 0 end) '[100,85)',
	sum(case when b.s_score>70 and b.s_score<=85 then 1 else 0 end) '[85,70)',
	sum(case when b.s_score>60 and b.s_score<=70 then 1 else 0 end) '[70,60)',
	sum(case when b.s_score>0 and b.s_score<=60 then 1 else 0 end) '[60,0)',
	sum(case when b.s_score>85 and b.s_score<=100 then 1.0 else 0 end)/COUNT(*) '[100,85)%',
	sum(case when b.s_score>70 and b.s_score<=85 then 1.0 else 0 end)/COUNT(*) '[85,70)%',
	sum(case when b.s_score>60 and b.s_score<=70 then 1.0 else 0 end)/COUNT(*) '[70,60)%',
	sum(case when b.s_score>0 and b.s_score<=60 then 1.0 else 0 end)/COUNT(*) '[60,0)%'
from
	Course a
left join
	Score b
on a.c_id=b.c_id
group by
	a.c_id,a.c_name