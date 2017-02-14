Brian Powers
Alan Labouser
Febuary 14 2017
Lab 4

1. 
select city
from Agents
where aid in (select aid
              from orders
              where cid = 'c006'
             );
2. 
select distinct pid
from Orders
where aid in (select aid 
			  from Orders																																																																																																																																																					
              where cid in (select cid
                           from Customers
                           where city = 'Kyoto')
			  )
order by pid DESC;
3. 
select distinct cid 
from orders
where cid in (select cid
              from orders
              where pid = 'p01')
and cid in (select cid
            from orders
            where pid = 'p07');

4. 
select distinct cid 
from orders
where cid in (select cid
              from orders
              where pid = 'p01')
and cid in (select cid
            from orders
            where pid = 'p07');
5. 
select distinct pid
from Orders
where cid not in (select cid 
			      from Orders
                  where aid = 'a08')
                  order by pid DESC;
6.
select name as "Customer", discount as "%off", city
from Customers
where cid  in (select cid
               from orders
               where aid in (select aid
                             from Agetns
                             where city = 'Tokyo' and city = 'New York')
			   );
7. 
select name as "customer"
from customers
where discount in (select discount
                   from customers
                   where city = 'Duluth' or city = 'Lodon');
8. 
Hey Alan,
	Let me tell you about Check constraints.  Check constraints are an integrity constraint that 
	sets a requirement for each row in the database's tables.  Check constraints are great because 
	they can keep businesses afloat; For instance, a database can check if a business has a product
	when a customer orders that product.  But there are some bad uses of check constraints; Say 
	we are making a database for a sports team and two of the colums are titled "Date Joined" and 
	"Date Departed" and you set a check constraint that makes it so either column can not be null 
	we could experence problems when adding a new player because thier "Date Departed" would be null.