create table F0518(
	��Ʒ nvarchar(22),
	���� date,
	���� int,
	���� int
)

insert into F0518
values
('����', '2022-01-01',100,1),
('����', '2022-01-01',50,4),
('����', '2022-01-02',100,2),
('����', '2022-01-02',105,1)

-- Ҫ�󣺲���ÿ����Ʒ ���һ�� ����ƽ������
with
t1 as(
	select *,
		DENSE_RANK() over(partition by ��Ʒ order by ���� desc) RK
	from F0518
)
select ��Ʒ,����,
	SUM(����*����)*1.0 / SUM(����) as ƽ����
from t1
where RK = 1
group by ��Ʒ,����