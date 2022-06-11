create table F0310(
	order_id varchar(10),
	price int,
	oldkey varchar(20)
)

insert into F0310
values
('1001',10,'80-100'),
('1001',20,'90-200'),
('1002',30,'70-130'),
('1002',40,'80-140'),
('1002',50,'90-150')

-- ��ͬ order_id �� oldkey�ϲ�Ϊһ��
select *,
STUFF(
	(select ',' + b.oldkey from F0310 b
	where a.order_id = b.order_id 
	for xml path('')
	), 
	1, 1, ''
) new_key
from F0310 a

-- FOR XML PATH ʾ��
select ',' + oldkey result
from f0310
for xml path('')

/*
STUFF(string1, startIndex, length, string2)
��string1���� startIndex(SQL�ж��Ǵ�1��ʼ������0)��
ɾ��length���ȵ��ַ���Ȼ����string2�滻ɾ�����ַ�
*/
-- STUFFʾ��
select STUFF('abcdef', 2, 3, '*****************')
select STUFF(',80-100,90-200', 1, 1, '')