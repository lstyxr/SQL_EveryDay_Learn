create table F0507(
	DATE1 datetime
)

-- ѭ����������
declare @DATE1 datetime
set @DATE1 = '2021-01-25'
while @DATE1 < GETDATE()
begin
	insert into F0507
	values
	(@DATE1)
	select @DATE1 = DATEADD(M,1,@DATE1)
end

select * from F0507

-- Ҫ�󣺽������зֳ����У����������·�һ�У�ż���·�һ��
with
tmp as(
	select ROW_NUMBER() over(order by DATE1) ID, * from F0507
)
select A.DATE1, B.DATE1 DATE2
from
(select ROW_NUMBER() over(order by DATE1) ID, DATE1 
from tmp where ID%2=1) A
join
(select ROW_NUMBER() over(order by DATE1) ID, DATE1
from tmp where ID%2=0) B
on A.ID = B.ID