drop table region 

create table region(
	id serial primary key,  -- ����������
	rc varchar(20) not null, -- ����code
	pc varchar(20) not null, -- ������code
	nm varchar(20)			 -- ����
)

insert into region(rc,pc,nm) 
values
('110000', '0', '����'),
('110100', '110000', '����-����'),
('440000', '0', '����'),
('440100', '440000', '����-�人'),
('440101', '440100', '����-�人-���'),
('440200', '440000', '����-��ʯ'),
('440201', '440200', '����-��ʯ-��ʯ��'),
('440202', '440200', '����-��ʯ-��½')

with recursive tmp(id,rc,pc,nm,deep) as 
(
	select id,rc,pc,nm,1 as deep from region where id = 3
	union all 
	select t1.id, t1.rc, t1.pc, t1.nm, t2.deep + 1
		from region t1, tmp t2
		where t2.deep < 3  -- ����������Ϊ3
		and t2.rc = t1.pc
)
select * from tmp