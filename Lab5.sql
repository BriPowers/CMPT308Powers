Brian Powers
Alan Labouser
Febuary 21 2017
Lab 5

1. 
select a.city
from agents a inner join orders o on a.aid = o.aid
inner join customers c on o.cid = c.cid
where c.cid = 'c006'

2.
select p.pid
from products p inner join orders o on p.pid = o.pid
				inner join customers c on c.cid = o.cid
                inner join agents a on a.aid = o.aid
where c.city = 'Kyoto'
order by pid DESC;

3.
select distinct c.name
from orders o left outer join customers c on o.cid = c.cid
where ordnumber != 0;

4. 
select distinct c.name
from Customers c left outer join orders o on o.cid = c.cid
where ordnumber is null;

5. 
select distinct c.name, a.name
from orders o inner join customers c on o.cid = c.cid
			  inner join agents a on a.aid = o.aid
where a.city = c.city;

6. 
select distinct c.name as "Customer", a.name as "Agent" , a.city as "Common city"
from Agents a inner join customers c on a.city = c.city;

7.
select name, city
from customers
where city in (select city 
               from (select count(*),city
                     from products 
                     group by city
                     order by count (*) ASC,city 
                     limit 1
                    )sub2
               )
group by city, name;