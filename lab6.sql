Brian Powers
Alan Labouseur
lab 6 
27/2/17

1. 
select name, city
from customers
where city in (select city 
               from (select count(*),city
                     from products 
                     group by city
                     order by count (*) DESC,city 
                     limit 1
                    )sub2
               )
group by city, name;


2.
select name
from products
where priceusd > (select avg(priceusd)
                     from products
                     )
order by name DESC;


3. 
select distinct c.name as "Customers", p.pid, sum(totalusd)
from orders o inner join products p on p.pid = o.pid
			  inner join customers c on o.cid = c.cid
              group by c.name, p.pid
              order by sum(totalusd) ASC;

4. 
select c.name as "Customers", coalesce (sum(qty),0)
from Customers c full join orders o on o.cid = c.cid
group by c.name;


5.
select c.name as "Customers", p.name as "Products", a.name "Agents"
from customers c
join orders o on c.cid = o.cid
join products p on p.pid = o.pid
join agents a on a.aid = o.aid
where a.city = 'Newark';


6. 
select ((p.priceusd * o.qty)*(1-(c.discount/100))) as "wrong prices" 
from orders o inner join products p on p.pid = o.pid
			  inner join customers c on c.cid = o.cid
where o.totalusd != ((p.priceusd * o.qty)*(1-(c.discount/100)));


7.  
select *
from orders o
left join Products p on o.pid = p.pid
where Products.priceUSD > .75;
-- left joins grab all information from the left table and any information that matches the condition on the join


select *
from orders o
right join Products p on o.pid = p.pid
where Products.priceUSD > .75;
-- right joins grab all information from the right table and any information that matches the condition on the join --
