--  List the number of films per category
USE sakila;
select * from sakila.category;
select * from sakila.film_category;
select count(fc.film_id) as number_of_films,name from sakila.category c 
join film_category fc on c.category_id = fc.category_id
group by name
order by number_of_films desc;

-- Display the first and the last names, as well as the address, of each staff member
select first_name,last_name,address from sakila.staff s 
join address a on s.address_id = a.address_id;

-- Display the total amount rung up by each staff member in August 2005
select sum(amount) as total_amount, staff_id from sakila.payment
where date_format(payment_date,'%m') = 8 and date_format(payment_date,'%y') = 5
group by staff_id;

-- List all films and the number of actors who are listed for each film
select count(*) as number_of_actors,fa.film_id,title from sakila.film_actor fa
join sakila.film f on fa.film_id = f.film_id
group by fa.film_id
order by number_of_actors desc;

-- Using the payment and the customer tables as well as the JOIN command, list the total amount paid by each customer. List the customers alphabetically by their last names.

select sum(amount),first_name,last_name from sakila.payment p 
join sakila.customer c on p.customer_id = c.customer_id
group by c.customer_id
order by last_name;



