create table F0415(
	UserID int,
	CheckIn datetime
)

delete from demo.f0415

insert into f0415 
values
(1, '2018/12/1 8:25'),
(1, '2018/12/1 8:26'),
(1, '2018/12/1 17:02'),
(1, '2018/12/2 8:27'),
(2, '2018/12/1 8:26'),
(2, '2018/12/1 17:03'),
(2, '2018/12/1 17:29'),
(2, '2018/12/1 18:01'),
(2, '2018/12/1 17:30')

/*
	Ҫ��1��ÿ������8��00 - 9��00������ 16��00 - 18��00������ʱ����ڵ�����һ�μ�¼��Ϊ����Ч����
		2����������ʱ�����������������ʾΪ���ظ���,����Ϊ����Ч��  
*/

select date(now())

with 
t1 as
(select *,
	case when -- �ϡ�����ֱ����ϱ�ǩ1��2
		time(CheckIn) between '08:00' and '09:00' then 1  -- ʱ���λӦ��λ��������'8:00',���� '08:00'
		when 
		time(CheckIN) between '16:00' and '18:00' then 2
		else 0
	end as ״̬
from f0415),
t2 as
(-- ���û���״̬�����ڽ��з�����
select *,
	row_number() over (partition by t1.UserID, date(t1.CheckIn), t1.״̬ order by t1.CheckIn) as ״̬2
from t1)
select *,
	case when ״̬=0 then '��Ч' 
		 when ״̬>0 and ״̬2=1 then '��Ч'
		 when ״̬>0 and ״̬2>=2 then '�ظ�'
	end as ��״̬
from t2