## Select the first name, last name, and email address of all the customers who have rented a movie.

use sakila;
select CONCAT(first_name, " ", last_name) AS name, email
from customer
join rental on customer.customer_id = rental.customer_id
group by name, email;

# What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made)

select customer.customer_id, CONCAT(first_name, " ", last_name) as name, AVG(amount) as Average_payment
from customer
join payment
on customer.customer_id = payment.customer_id
group by customer_id;

# Select the name and email address of all the customers who have rented the "Action" movies.

 #Write the query using multiple join statements. ite the query using sub queries with multiple WHERE clause and IN condition
 -- Solution a
select first_name, last_name, email
from customer
join rental on customer.customer_id = rental.customer_id
join inventory on rental.inventory_id = inventory.inventory_id
join film on film.film_id = inventory.film_id
join film_category on film_category.film_id = film.film_id
join category on category.category_id = film_category.category_id
where category.name = "Action"
group by first_name, last_name, email;
 
 -- Solution b
select CONCAT(first_name, " ", last_name) AS name, email
from customer where customer_id in
(select customer_id from rental where inventory_id in
(select inventory_id from inventory where film_id in
(select film_id from film_category join category using (category_id) where category.name="Action")));
 
 
 # Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment. If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be medium, and if it is more than 4, then it should be high.
 select payment_id, amount,
case
when amount >= 0 and amount <=2 then 'low'
when amount >2 and amount <=4 then 'medium'
when amount > 4 then 'high'
end as category_label
from payment;