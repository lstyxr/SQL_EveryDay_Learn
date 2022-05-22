create table F0408(
	UID int not null,
	CALLBACK_DATE date not null 
)

insert into f0408 
values
(1, '2020-4-1'),
(1, '2020-4-5'),
(1, '2020-4-10'),
(1, '2020-4-19'),
(2, '2020-4-1'),
(2, '2020-4-15'),
(2, '2020-4-20'),
(2, '2020-4-16')

/*
要求：第一次召回不计费，后续如果间隔大于7天计费，否则不计费，
	 再后续距离上一次计费大于7天计费，否则不计费，以此类推	  
*/

select *,
case when 
	lag(CALLBACK_DATE) over
	(partition by UID order by CALLBACK_DATE) is null
	or 
	datediff(
		CALLBACK_DATE, 
		lag(CALLBACK_DATE) over
		(partition by uid order by CALLBACK_DATE)
	)<7
	then '不计费' 
	else '计费'
end as CHARGE 
from f0408 
group by UID, CALLBACK_DATE