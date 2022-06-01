create table F0303(
	���� int,
	���ű�� int not null,
	������� int not null
)

insert into F0303
values
(10,222,1500),
(20,223,1497),
(30,223,1499),
(40,223,1498),
(50,213,1497),
(60,224,1497),
(70,224,1497),
(80,220,1496),
(90,220,1496),
(100,224,0)

-- Ҫ�󣺰������������ڵ��У�����в�����ͬ�������ȡ�����������һ�м�¼
-- ��ƫ�ƿ���������LEAD(��ƫ�Ƶ��У���ǰƫ�������������������ص�Ĭ��ֵ) over()
with
tmp as(
	select *,
		LEAD(���ű��, 1, NULL) over(order by ����) LEAD_1,
		LEAD(���ű��, 2, NULL) over(order by ����) LEAD_2,
		LAG(���ű��, 1, NULL) over(order by ����) LAD_1
	from F0303
)
select ����,���ű��,�������
from tmp
where ���ű�� <> LEAD_1