drop table f0406

create table F0406(
	��Ʒ varchar(10),
	�������� varchar(20),
	���� int
)

insert into f0406
values
('A', '2018-11-01', 100),
('A', '2018-10-01', 120),
('A', '2018-12-01', 115),
('B', '2018-11-01', 99),
('B', '2018-09-01', 88)

-- ���β�����µ��ۣ��ϴε��ۣ����ϴε��ۣ��������������0���
with 
t_over as
(select *,
	row_number() over(partition by ��Ʒ order by �������� desc) sort_num
from f0406)
select
	t1.*, 
	case when t2.���� is null then 0 else t2.���� end as ��һ�ε���,
	case when t3.���� is null then 0 else t3.���� end as ���ϴ�
from
(select ��Ʒ, ���� ���µ��� from t_over where sort_num=1) as t1
left join t_over as t2 on t2.��Ʒ = t1.��Ʒ and t2.sort_num=2
left join t_over as t3 on t3.��Ʒ = t1.��Ʒ and t3.sort_num=3