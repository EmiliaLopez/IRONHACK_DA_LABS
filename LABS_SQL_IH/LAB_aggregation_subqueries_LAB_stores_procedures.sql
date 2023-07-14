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

-- Lab | Stored procedures

-- Inthe previous lab we wrote a query to find first name, last name, and emails of all the customers who rented Action movies. Convert the query into a simple stored procedure. Use the following query: 
DROP PROCEDURE IF EXISTS get_action_movie_customers;
DELIMITER //

CREATE PROCEDURE get_action_movie_customers()
BEGIN
  SELECT first_name, last_name, email
  FROM customer
  JOIN rental ON customer.customer_id = rental.customer_id
  JOIN inventory ON rental.inventory_id = inventory.inventory_id
  JOIN film ON film.film_id = inventory.film_id
  JOIN film_category ON film_category.film_id = film.film_id
  JOIN category ON category.category_id = film_category.category_id
  WHERE category.name = 'Action'
  GROUP BY first_name, last_name, email;
END //

DELIMITER ;


CALL get_action_movie_customers();

-- Update the stored procedure in a such manner that it can take a string argument for the category name and return the results for all customers that rented movie of that category/genre. For eg., it could be action, animation, children, classics, etc.

DELIMITER //

CREATE PROCEDURE get_rental_category(in cat_name varchar(20))
BEGIN
  SELECT first_name, last_name, email
  FROM customer
  JOIN rental ON customer.customer_id = rental.customer_id
  JOIN inventory ON rental.inventory_id = inventory.inventory_id
  JOIN film ON film.film_id = inventory.film_id
  JOIN film_category ON film_category.film_id = film.film_id
  JOIN category ON category.category_id = film_category.category_id
  WHERE category.name = cat_name
  GROUP BY first_name, last_name, email;
END //

DELIMITER ;

CALL get_rental_category('Animation');

-- Write a query to check the number of movies released in each movie category. Convert the query in to a stored procedure to filter only those categories that have movies released greater than a certain number. Pass that number as an argument in the stored procedure.

DELIMITER //

CREATE PROCEDURE movie_count_by_category (IN min_movie_count int)
BEGIN
  SELECT category.category_id, sakila.category.name, COUNT(*) AS movie_count
  FROM category
  JOIN sakila.film_category ON sakila.category.category_id = sakila.film_category.category_id
  GROUP BY category.category_id
  HAVING movie_count > min_movie_count;
END //

DELIMITER ;

CALL movie_count_by_category(55);