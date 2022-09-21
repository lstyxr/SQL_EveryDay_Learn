create table F0627(
	ID INT,
	NAME VARCHAR(10),
	NUM INT
)

insert into F0627
values
(1,'A',1),
(2,'A',2),
(3,'A',6),
(4,'A',4),
(5,'A',3),
(6,'B',2),
(7,'B',8),
(8,'B',2)

select * from F0627

--要求：求出每个ID每次累加的结果/每组NAME总和的比例大于0.6的ID和NAME
/*
解释：从题目的意思可以看出A组的总数为16，从ID为1到5分别累加后的结果分别为1，3，9，13，16
只有13和16除以总数16才大于0.6，所以返回的结果ID为4和5，同样B组为7和8
*/

select t1.ID,t1.NAME,t1.NUM
from
(select *,
	SUM(NUM) over(partition by NAME order by ID) A,
	SUM(NUM) over(partition by NAME) B,
	SUM(NUM) over() C,
	(SUM(NUM) over(partition by NAME order by ID))*1.0/SUM(NUM) over(partition by NAME) D
from
F0627) t1
where t1.D>0.6