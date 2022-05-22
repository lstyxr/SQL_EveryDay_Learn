create table F0411(
	DOCNUM int,
	STATUS varchar(26)
)

insert into f0411
values
(33, 'FULL'),
(33, 'NOFULL'),
(34, 'FULL'),
(35, 'FULL'),
(35, 'NOFULL'),
(36, 'FULL'),
(37, 'FULL'),
(38, 'FULL'),
(38, 'NOFULL')

-- 要求：只取状态为FULL的DOCNUM，如果同时为NOFULL则不取
with t1 as
(select *,
	count(*) over(partition by DOCNUM) num_count
from f0411)
select * from t1
where STATUS = 'FULL' and num_count = 1