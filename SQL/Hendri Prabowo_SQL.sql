---	A customer wants to know the films about “astronauts”. How many recommendations could you give for him?
select count(*) 
from film 
where lower(description) like '%astronaut%'

----I wonder, how many films have a rating of “R” and a replacement cost between $5 and $15?
select count(*) 
from film 
where rating='R' and replacement_cost between 5 and 15;

----We have two staff members with staff IDs 1 and 2. We want to give a bonus to the staff member that handled the most payments.How many payments did each staff member handle? And how much was the total amount processed by each staff member?
select s.staff_id, count(p.payment_id) as num_of_payment, sum(p.amount) as total_payment 
from staff as s 
inner join payment as p on s.staff_id=p.staff_id 
group by s.staff_id   
order by num_of_payment desc 

----Corporate headquarters is auditing the store! They want to know the average replacement cost of movies by rating!
select rating, avg(replacement_cost) as avg_replacement_cost 
from film 
group by rating 

----We want to send coupons to the 5 customers who have spent the most amount of money. Get the customer name, email and their spent amount!
select concat(c.first_name,' ',c.last_name) as customer_name, c.email, sum(p.amount) as spent_amount
from customer as c 
inner join payment as p on c.customer_id=p.customer_id 
group by c.customer_id 
order by spent_amount desc 
limit 5

----We want to audit our stock of films in all of our stores. How many copies of each movie in each store, do we have?
select f.title, i.store_id, count(i.film_id) as num_copies 
from inventory as i 
inner join film as f on f.film_id = i.film_id 
group by f.film_id, i.store_id  
order by f.film_id, i.store_id

----We want to know what customers are eligible for our platinum credit card. The requirements are that the customer has at least a total of 40 transaction payments. Get the customer name, email who are eligible for the credit card!
select concat(c.first_name,' ',c.last_name) as customer_name, c.email
from customer as c
inner join payment as p on c.customer_id =p.customer_id 
group by c.customer_id 
having count(p.payment_id)>40