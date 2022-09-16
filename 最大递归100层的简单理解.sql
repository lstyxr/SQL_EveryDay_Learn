create table F0617(
	ID INT,
	EndTime DATETIME
)

insert into F0617
values
(1,'2020/5/26 16:00'),
(2,'2020/5/26 17:30')

-- Ҫ��ÿ����¼ÿ������30���ӣ�����3�Σ��õݹ飩
with
CTE AS(
	select ID, EndTime, 1 as NUM
	from F0617
	UNION ALL
	select ID, DATEADD(MINUTE,30,c.EndTime), c.NUM+1
	from CTE c
	where NUM<101 -- ���ݹ�100��
)
select * from
CTE c
order by c.ID, c.EndTime