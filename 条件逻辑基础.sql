create table F0215(
	StuID int,
	CID varchar(10),
	Course int
)

insert into F0215
values
(1, '001', 67),
(1, '002', 89),
(1, '003', 94),
(2, '001', 95),
(2, '004', 78),
(3, '001', 94),
(3, '002', 77),
(3, '003', 90)

/*
Ҫ���ҳ�001��003��ѧ����ѧ��id
*/

-- ����д��, CID����001Ҳ��003��
-- �����߼����󣬷��ؽ��Ϊ�գ�û�н����������
select * from F0215
where CID = '001' and CID = '003'

-- CID��001 ������ 003
-- ���������⣬IDΪ2��ѧ��ֻѧ��001��ûѧ��003����Ӧ�÷���
select * from F0215
where CID = '001' or CID = '003'

-- ˼·1�� ȡ������
with 
t1 as(
	select * from F0215 where CID = '001'
),
t2 as(
	select * from F0215 where CID = '003'
)
select * from t1 inner join t2 on t1.StuID = t2.StuID

-- �����ӣ�����
select * from F0215 A, F0215 B  -- �Ͽ�������
where A.StuID = B.StuID         -- ��ѧ��ID����ɸѡ�����߼������ݣ���Ϊͬһ��ѧ��ID��ͬ������ 
and A.CID = '003'               -- �ٷֱ�ɸѡ001 �� 003 ���ų������ģ������е�����
and B.CID = '001'               -- ʵ�ʾ�����������CID�����е�����ɸѡ�� �ڵ��ӱ�������ʵ��

-- ȡ������ ������ķ�ʽ
select SC.StuID
from F0215 SC
where SC.CID = '001'
intersect
select SC.StuID
from F0215 SC
where SC.CID = '003'

-- ��򵥵Ľⷨ
select StuID
from F0215
where CID in ('001', '003')
group by StuID
having COUNT(StuID) = 2

-- ��򵥵Ľⷨ����
with 
tmp as(
	select * from F0215 where CID = '001'
	union all
	select * from F0215 where CID = '003'
)
select StuID, COUNT(CID) CID_COUNT from tmp 
group by StuID 
having COUNT(StuID) = 2


-- ˼·2������
with
t1 as( 
	select * from F0215
	where CID = '001' or CID = '003'
)
select distinct StuID from
	(select *,
		COUNT(*) over(partition by StuID) CID_COUNT
	from t1) t2
where CID_COUNT = 2
