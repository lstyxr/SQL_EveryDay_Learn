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
