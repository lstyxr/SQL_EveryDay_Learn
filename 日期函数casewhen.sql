create table F0321(
	Ա���� nvarchar(10),
	���� nvarchar(10),
	�Ա� nvarchar(2),
	��� nvarchar(10),
	��ְ���� date
)

insert into F0321
values
('1001','����','��','��ͨ','2021-08-03'),
('1002','����','Ů','����','2021-08-18'),
('1003','����','��','��ͨ','2021-08-19'),
('1004','����','Ů','����','2021-08-04')

/*
1) ���Ա��������ǡ���ͨ������Ա���ġ�ת�����ڡ�Ϊ����ְ���ڡ��������£�
   ���Ա��������ǡ���������Ա���ġ�ת�����ڡ�Ϊ����ְ���ڡ��������£�
2) �������ְ���ڡ���15�ż���ǰ�����籣�����·ݡ�Ϊ���£�
   �������ְ���ڡ���15���Ժ����籣�����·ݡ�Ϊ���£�   
*/

select *,
	case when ��� = '��ͨ' 
		then DATEADD(MONTH, 3, ��ְ����)
		else DATEADD(MONTH, 6, ��ְ����)
	end as ת������,
	case when DATEPART(DAY, ��ְ����) <= 15
		then CONVERT(char(7), ��ְ����, 120)
		else CONVERT(char(7), dateadd(month, 1, ��ְ����), 120)
	end as �籣�����·�
from F0321

-- ���ں����÷�
select DATEADD(MONTH,1,GETDATE())
select DATEADD(MONTH,-1,GETDATE())

select DATEPART(YEAR, GETDATE())
select DATEPART(WEEK, GETDATE())
select DATEPART(WEEKDAY, GETDATE())
select DATENAME(WEEKDAY, GETDATE())
select DATENAME(QUARTER, GETDATE())