create table F0307(
	ID int,
	PRODUCTNAME varchar(64),
	PARENTID int
)

insert into F0307
values
(1,'����',NULL),
(2,'����', 1),
(3,'������',1),
(4,'����',2),
(5,'��ʻ��',2),
(6,'�����',2),
(7,'����',3),
(8,'����',3)

-- Ҫ�󣺸��ݸ�ID��PARENTID��������ʾ��Ʒ���Ͳ㼶���
/*ʲô�ǵݹ�
���ٰ���������ѯ����һ����ѯΪ�����Ա�������Աֻ��һ��������Ч��Ĳ�ѯ�����ڵݹ�Ļ�����λ��
				  �ڶ�����ѯΪ�ݹ��Ա��ʹ�ò�ѯ��Ϊ�ݹ��Ա���Ƕ�CTE���Ƶĵݹ������Ǵ���
				  ���߼��Ͽ��Խ�CTE���Ƶ��ڲ�Ӧ�����Ϊǰһ����ѯ�Ľ����
*/

with
CTE as(
	--�����Ա
	select ID, PARENTID,PRODUCTNAME,
		0 CTELEVEL, CAST(ID AS varchar) OrderID
	from F0307 where ID=1
	union all
	-- �ݹ��Ա
	select A.ID, A.PARENTID, A.PRODUCTNAME,
		B.CTELEVEL + 1,CAST(B.OrderID + '->' + LTRIM(A.ID) as varchar)
	from F0307 A
	join CTE B on B.ID = A.PARENTID  -- ����CTE�Լ���ͨ������ID�븸ID���й���
)
select ID, PARENTID,
	RIGHT('      ',4*CTELEVEL) + PRODUCTNAME PRODUCTNAME, OrderID
from CTE
order by OrderID