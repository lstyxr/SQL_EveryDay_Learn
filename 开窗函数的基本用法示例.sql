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

--Ҫ�����ÿ��IDÿ���ۼӵĽ��/ÿ��NAME�ܺ͵ı�������0.6��ID��NAME
/*
���ͣ�����Ŀ����˼���Կ���A�������Ϊ16����IDΪ1��5�ֱ��ۼӺ�Ľ���ֱ�Ϊ1��3��9��13��16
ֻ��13��16��������16�Ŵ���0.6�����Է��صĽ��IDΪ4��5��ͬ��B��Ϊ7��8
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