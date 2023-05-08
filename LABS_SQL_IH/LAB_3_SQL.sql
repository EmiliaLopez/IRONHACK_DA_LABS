-- How many distinct (different) actors' last names are there?
use sakila;
SELECT DISTINCT last_name FROM actor;
-- In how many different languages where the films originally produced? (Use the column language_id from the film table)
SELECT DISTINCT language_id as languages FROM film;
-- How many movies were released with "PG-13" rating?
SELECT COUNT(*) as num_movies FROM film WHERE rating = 'PG-13';
-- Get 10 the longest movies from 2006.
SELECT * FROM FILM WHERE SUBSTR(release_year, 1, 4) >= '2006' ORDER BY length DESC
LIMIT 10;
-- How many days has been the company operating (check DATEDIFF() function)?
select * from customer;
SELECT DATEDIFF('2006-02-15','2006-02-14');
-- Show rental info with additional columns month and weekday. Get 20.
SELECT rental_id, inventory_id, customer_id, rental_date, return_date, MONTH(rental_date) as Month, DAYNAME(rental_date) as Weekday
FROM rental LIMIT 20;
-- Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
SELECT rental_id, rental_date,
CASE WHEN DAYOFWEEK(rental_date) IN (1,7) THEN 'weekend' ELSE 'workday' END as day_type
FROM rental;
-- How many rentals were in the last month of activity?
SELECT rental_date FROM rental;
SELECT COUNT(*) AS total_rentas_ultimo_mes FROM rental
WHERE rental_date BETWEEN '2005-04-31' AND '2005-05-31';





























































































































































