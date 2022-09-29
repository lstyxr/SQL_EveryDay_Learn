create table Student(
	s_id VARCHAR(10),
	s_name VARCHAR(20),
	s_birth DATE,
	s_sex VARCHAR(5)
)

insert into Student
values
('01','����','1990-01-01','��'),
('02','Ǯ��','1990-12-21','��'),
('03','���','1990-05-20','��'),
('04','����','1990-08-06','��'),
('05','��÷','1991-12-01','Ů'),
('06','����','1992-03-01','Ů'),
('07','֣��','1989-07-01','Ů'),
('08','����','1990-01-20','Ů')

create table Course(
	c_id VARCHAR(10),
	c_name VARCHAR(20),
	t_id VARCHAR(10)
)

insert into Course
values
('01','����','02'),
('02','��ѧ','01'),
('03','Ӣ��','03')

create table Teacher(
	t_id VARCHAR(6),
	t_name VARCHAR(20)
)

insert into Teacher
values
('01','����'),
('02','����'),
('03','����')

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

--1����ѯ��01���γ̱ȡ�02���γ̳ɼ��ߵ�ѧ����Ϣ���γ̷���
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

-- ����ת�������͸��
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

--2����ѯ��01���γ̱ȡ�02���γ̳ɼ��͵�ѧ����Ϣ���γ̷���
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

--3����ѯƽ���ɼ����ڵ���60�ֵ�ͬѧ��ѧ����š�ѧ��������ƽ���ɼ�
-- �Ӳ�ѯ
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

-- ����������
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

--4����ѯƽ���ɼ�С��60�ֵ�ͬѧ��ѧ����š�ѧ��������ƽ���ɼ���ע��Ҫ����û�гɼ���ѧ��
--������û�гɼ���ѧ��
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

--����û�гɼ���ѧ��
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

--5����ѯ����ͬѧ��ѧ����š�ѧ��������ѡ�����������пγ̵��ܳɼ���ע��Ҫ����û�гɼ���ѧ��
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

--6����ѯ �������ʦ������
select
	count(*) cnt_t
from
	Teacher
where
	t_name like '��%'

--7����ѯѧ������������ʦ�ڿε�ѧ����Ϣ
select * from Score
select * from Student
select * from Teacher
select * from Course

--�Դ�
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
		t.t_name='����')))

--��
select
	d.*
from
	Score a, Course b, Teacher c, Student d
where
	a.c_id=b.c_id
and b.t_id=c.t_id
and	d.s_id=a.s_id
and	c.t_name='����'

--8����ѯûѧ������������ʦ�ڿε�ѧ����Ϣ
--not in����
select * from Student where s_id not in(
select
	a.s_id
from
	Score a, Course b, Teacher c
where
	a.c_id=b.c_id
and b.t_id=c.t_id
and	c.t_name='����')

--not exists����
select * from Student where not exists(
	select 1 from
		(select
			a.s_id
		from
			Score a, Course b, Teacher c
		where
			a.c_id=b.c_id
		and b.t_id=c.t_id
		and c.t_name='����') t
	where t.s_id=Student.s_id)

--9����ѯѧ����š�01������Ҳѧ����š�02���γ̵�ͬѧ��Ϣ
--�Դ�
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

--������
select
	c.*
from
	Score a,Score b,Student c
where
	a.c_id='01'
and b.c_id='02'
and a.s_id=b.s_id
and a.s_id=c.s_id

--10����ѯѧ����š�01����û��ѧ����š�02���γ̵�ͬѧ��Ϣ
--����ת�������
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

--11����ѯû��ѧȫ���пγ̵�ѧ����Ϣ
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

--12����ѯ������һ�ſ���ѧ��Ϊ��01����ͬѧ��ѧ��ͬ��ѧ����Ϣ
--in������distinctȥ��
select
	distinct a.*
from
	Student a
left join
	Score b
on a.s_id=b.s_id
where b.c_id in
	(select c_id from Score where s_id='01')
--in����������ȥ��
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

--exists����
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

--��ѯ�͡�01����ͬѧ��ѧ��ȫ��ͬ������ͬѧ����Ϣ
--��������͡�01����ѧ����ͬ����ʱ��
--full join����
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

--�����֧��full join������ֻ�ֱܷ�����������union
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

--14����ѯûѧ������������ʦ���ڵ���һ�ſγ̵�ѧ������
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
			and b.t_name='����')) t
	where t.s_id=Student.s_id)

--15����ѯ���ż����ϲ�����γ̵�ѧ��ѧ�š���������ƽ���ɼ�
--�Դ�
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

--��ʦ
select
	s.s_id,s.s_name,AVG(a.s_score) avg_s,
	sum(case when a.s_score>=60 then 0 else 1 end) ����������
from
	Student s
left join
	Score a
on  a.s_id=s.s_id
group by
	s.s_id,s.s_name
having
	sum(case when a.s_score>=60 then 0 else 1 end)>=2

--case when����⣬ʵ���������µ�һ�У�0������1������������sum�������ܵĲ���������
select
	s_id,
	sum(case when s_score>=60 then 0 else 1 end) sum_jg
from
	Score
group by
	s_id