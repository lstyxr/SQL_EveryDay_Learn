create table F0324(
	USEID int,
	OPERATION varchar(10),
	DATE date
)

insert into F0324
values
(1001,'��������','2021/1/1'),
(1001,'֧������','2021/1/2'),
(1001,'ȷ���ջ�','2021/1/5'),
(1002,'��������','2021/1/1'),
(1002,'֧������','2021/1/3'),
(1003,'��������','2021/1/2')

/*
Ҫ������һ��������
��ν������
	ͬ��USEID��DATE��С���������ÿ������������Ϊ��ʼ���ڣ��������ڵ���һ��������Ϊ�������ڣ�
	���磺USEIDΪ1001�飬��һ��������2021/1/1���ڶ���������2021/1/2����ô��һ������2021/1/1��
	��������Ϊ2021/1/2���Դ����ƣ���������һ�����ڣ���ô��������Ĭ��Ϊ9999/12/31
*/

with
t1 as(
	select *,
		ROW_NUMBER() over(partition by USEID order by DATE) row_num
	from F0324
)
select 
	A.USEID,
	A.OPERATION,
	A.DATE Start_Date,
	ISNULL(B.DATE,'9999-12-31') End_Date
from t1 A
left join t1 B
on A.row_num + 1 = B.row_num
and A.USEID = B.USEID

-- ���ں����ĵڶ���д������partition by ����һ��order by
with
t1 as(
	select *,
		ROW_NUMBER() over(order by USEID,DATE) row_num
	from F0324
)
select 
	A.USEID,
	A.OPERATION,
	A.DATE Start_Date,
	ISNULL(B.DATE,'9999-12-31') End_Date
from t1 A
left join t1 B
on A.row_num + 1 = B.row_num
and A.USEID = B.USEID