drop table region 

create table region(
	id serial primary key,  -- 主键，自增
	rc varchar(20) not null, -- 地区code
	pc varchar(20) not null, -- 父地区code
	nm varchar(20)			 -- 名称
)

insert into region(rc,pc,nm) 
values
('110000', '0', '北京'),
('110100', '110000', '北京-西城'),
('440000', '0', '湖北'),
('440100', '440000', '湖北-武汉'),
('440101', '440100', '湖北-武汉-武昌'),
('440200', '440000', '湖北-黄石'),
('440201', '440200', '湖北-黄石-黄石港'),
('440202', '440200', '湖北-黄石-下陆')

with recursive tmp(id,rc,pc,nm,deep) as 
(
	select id,rc,pc,nm,1 as deep from region where id = 3
	union all 
	select t1.id, t1.rc, t1.pc, t1.nm, t2.deep + 1
		from region t1, tmp t2
		where t2.deep < 3  -- 设置最大深度为3
		and t2.rc = t1.pc
)
select * from tmp