create table F0224(
	ID int,
	��� int
)

insert into f0224 
values
(2,30),
(3,30),
(4,30),
(11,9),
(12,1),
(13,1),
(14,15),
(15,33),
(16,5),
(17,8),
(18,14),
(19,3)

-- Ҫ�󣺲�ѯ����һ����¼��ʼ���ڼ�����¼���ۼƽ��պó���100��

-- �ⷨ1
with 
tmp as(
	select *,
		sum(���) over(order by ID) ����ۼ�
	from f0224
)
select *, min(ID) 
from tmp 
where ����ۼ� > 100

-- ������
with
tmp as(
	select B.ID BID, A.ID AID, A.���, sum(A.���) ���_sum  
	from f0224 A
	join f0224 B
	on B.ID >= A.ID
	group by B.ID 
)
select * from tmp where ���_sum > 100 limit 1
