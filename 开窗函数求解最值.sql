create table F0531(
	order_id INT,
	customer_id INT,
	order_date VARCHAR(20)
)

insert into F0531 values
(1,1,'20190624'),
(2,2,'20190423'),
(3,3,'20190321'),
(4,3,'20190429'),
(5,4,'20190812'),
(6,4,'20190914')

select * from F0531

-- 要求：求出在表中订单数最多的客户对应的customer_id
select customer_id from
(select
customer_id, T, RANK() over(order by T DESC) R
from
	(select customer_id, COUNT(1) T
	from F0531
	group by customer_id) A
) B
where B.R=1