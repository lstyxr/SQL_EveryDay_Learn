create table F0228(
	ID int,
	���� int,
	��� varchar(10)
)

insert into f0228
values
(1,34,'��'),
(3,35,'ʤ'),
(5,36,'ʤ'),
(8,37,'��'),
(9,38,'��'),
(11,39,'��'),
(12,40,'��'),
(15,41,'ʤ'),
(17,42,'ʤ'),
(20,43,'��'),
(21,44,'��'),
(23,45,'��'),
(24,46,'��')

--  Ҫ�󣺲�ѯ������ʧ�ܳ��δ���3�ļ�¼��
with
t1 as(
	select *, ROW_NUMBER() over(order by ����) num1 from F0228
),
t2 as(
	select *,
		ROW_NUMBER() over(partition by ��� order by ����) xl,
		num1 - ROW_NUMBER() over(partition by ��� order by ����) num2
	from t1
)
select ID, ����, ���
from t2
where num2 in(
	select num2 
	from
	t2
	group by num2
	having COUNT(1) > 3
)