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
select Stu.s_name,Cou.c_name,t2.score_01 from
	(select s_id from
		(select s1.s_id,s1.c_id,s1.s_score as score_01,s2.s_score as score_02 from Score s1, Score s2
		where s2.c_id = '02'
		and s2.s_id = s1.s_id
		and s1.c_id in('01','02')) t1
	where score_01>score_02) t2
join Student Stu
on Stu.s_id=t2.s_id
join Course Cou
on Cou.c_id=t2.c_id

select * from Score
where s_id in(
select s_id from
		(select s1.s_id,s1.c_id,s1.s_score as score_01,s2.s_score as score_02 from Score s1, Score s2
		where s2.c_id = '02'
		and s2.s_id = s1.s_id
		and s1.c_id in('01','02')) t1
	where score_01>score_02)