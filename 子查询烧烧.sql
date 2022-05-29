create table F0221A(
	stuID int, classID varchar(20), stuName varchar(20)
)

insert into F0221A
values
(1, 'A', '����'),
(2, 'A', '����'),
(3, 'B', '����'),
(4, 'A', '����')

create table F0221B(
	classID varchar(20),
	className varchar(20)
)

insert into F0221B
values
('A', 'һ��'),
('B', '����')

create table F0221C(
	stuID int, course varchar(20), score int
)

insert into F0221C
values
(1, '����', 80),
(1, '��ѧ', 90),
(1, 'Ӣ��', 90),
(2, '����', 89),
(2, '��ѧ', 91),
(2, 'Ӣ��', 88),
(3, '����', 95),
(3, '��ѧ', 77),
(3, 'Ӣ��', 72),
(4, '����', 89),
(4, '��ѧ', 91),
(4, 'Ӣ��', 88)

select * from F0221A  -- ѧ����
select * from F0221B  -- �༶��
select * from F0221C  -- �ɼ���

-- Ҫ�󣺲�ѯһ����Ƴɼ���ߵ�ѧ�������Ͷ�Ӧ�ķ���

-- ���ں������Ӳ�ѯ
with 
tmp as(
	select A.stuID, A.stuName, B.className, C.course, C.score from F0221C C
	join F0221A A
	on A.stuID = C.stuID
	join F0221B B
	on B.classID = A.classID and className = 'һ��'
),
t1 as(
	select *, 
	DENSE_RANK() over(order by score desc) score_num 
	from tmp where course = '����'
),
t2 as(
	select *, 
	DENSE_RANK() over(order by score desc) score_num 
	from tmp where course = '��ѧ'
),
t3 as(
	select *, 
	DENSE_RANK() over(order by score desc) score_num 
	from tmp where course = 'Ӣ��'
)
select * from t1 where score_num = 1
union all
select * from t2 where score_num = 1
union all
select * from t3 where score_num = 1


-- ���Ӳ�ѯ
-- �����ҳ�һ���ѧ��
with 
t1 as(
	select stuID, stuName
	from F0221A 
	join F0221B 
	on F0221A.classID = F0221B.classID and F0221B.className = 'һ��'
),
-- ����һ�����ҳ�����������
t2 as(
	select course, MAX(score) score_max 
	from F0221C
	join t1 on t1.stuID = F0221C.stuID
	group by course
)
-- ��� select ����Ҫ���ֶ�
select t1.stuID, t1.stuName, t2.course, t2.score_max
from F0221C C
join t2 on t2.course = C.course and t2.score_max = C.score
join t1 on t1.stuID = C.stuID


select *, DENSE_RANK() over(partition by course order by score) from F0221C