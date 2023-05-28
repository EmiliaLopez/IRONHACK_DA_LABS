-- How many copies of the film Hunchback Impossible exist in the inventory system?
Use sakila;
SELECT i.film_id, f.title as Titulo, Count(i.film_id) AS 'number_of_copies' 
FROM inventory AS i
JOIN film as f
ON i.film_id = f.film_id
WHERE f.title = 'Hunchback Impossible'
GROUP BY i.film_id, f.title;

-- List all films whose length is longer than the average of all the films.
SELECT title, length FROM film
WHERE length > (SELECT AVG(length) FROM film);

-- Use subqueries to display all actors who appear in the film Alone Trip.

SELECT * from (
select fa.film_Id, f.title AS Titulo , CONCAT(a.first_name, ' ', a.last_name) as Actor
FROM film_actor AS fa
JOIN film as f ON fa.film_id = f.film_id
JOIN actor as a ON fa.actor_id = a.actor_id) AS sub1
WHERE Titulo = 'Alone Trip';

-- Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
SELECT fc.category_id as ID, c.name AS categoria , f.title AS titulo  FROM film as f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
WHERE c.name = 'Family';

-- Get name and email from customers from Canada using subqueries. Do the same with joins. 
-- Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.

SELECT * FROM (
SELECT CONCAT(c.first_name, ' ', c.last_name) AS nombre , c.email AS email , co.country AS pais
FROM customer AS c
JOIN address AS a on c.address_id = a.address_id
JOIN city AS ci ON ci.city_id = a.city_id 
JOIN country as co ON ci.country_id = co.country_id) AS sub1
WHERE Pais = 'Canada';



SELECT CONCAT(c.first_name, ' ', c.last_name) , c.email , co.country
FROM customer AS c
JOIN address AS a on c.address_id = a.address_id
JOIN city AS ci ON ci.city_id = a.city_id 
JOIN country as co ON ci.country_id = co.country_id
WHERE co.country = 'Canada';


-- Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. 
-- First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.
SELECT fa.actor_id as ID , CONCAT(a.first_name,' ' , a.last_name) AS Nombre,  COUNT(*) as Num
FROM film_actor AS fa
JOIN actor AS a ON fa.actor_id = a.actor_id
GROUP BY fa.actor_id
ORDER BY num DESC LIMIT 1 ;

SELECT f.title ,CONCAT(a.first_name,' ' ,a.last_name) ,COUNT(a.actor_id) OVER (PARTITION BY a.actor_id) AS Num_Actuaciones # el count es solo para que se muestre el numero de peliculas
from film as f
JOIN film_actor as fa ON fa.film_id = f.film_id
JOIN actor as a ON fa.actor_id = a.actor_id
WHERE a.actor_id = ( SELECT ID FROM (
 SELECT fa.actor_id as ID , CONCAT(a.first_name,' ' , a.last_name) AS Nombre,  COUNT(*) as Num
FROM film_actor AS fa
JOIN actor AS a ON fa.actor_id = a.actor_id
GROUP BY fa.actor_id
ORDER BY num DESC LIMIT 1)as sub1);

-- Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments
SELECT c.customer_id AS ID,  CONCAT( c.first_name, ' ' , c.last_name) AS Nombre , SUM(p.amount)  AS Monto
FROM customer AS c
JOIN payment as p ON c.customer_id = p.customer_id
GROUP BY c.first_name, c.last_name, c.customer_id
ORDER BY Monto DESC  ;

SELECT DISTINCT f.title AS Titulo , CONCAT(c.first_name,' ' ,c.last_name) AS Nombre , COUNT(c.customer_id) OVER (PARTITION BY c.customer_id) AS Num_rentadas, SUM(P.AMOUNT) as Monto # El count solo para ver cuantas peliculas ha rentado y cuanto ha gastado 
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
JOIN customer AS c ON r.customer_id = c.customer_id
JOIN payment as p ON c.customer_id = p.customer_id
WHERE c.customer_id = (select ID FROM ( 
SELECT c.customer_id AS ID,  CONCAT( c.first_name, ' ' , c.last_name) AS Nombre , SUM(p.amount)  AS Monto
FROM customer AS c
JOIN payment as p ON c.customer_id = p.customer_id
GROUP BY c.first_name, c.last_name, c.customer_id
ORDER BY Monto DESC LIMIT 1) as sub1) 
GROUP BY c.customer_id, f.title,c.first_name, c.last_name; 



-- Get the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client.

SELECT c.customer_id AS ID,  CONCAT( c.first_name, ' ' , c.last_name) AS Nombre , SUM(p.amount)  AS Monto
FROM customer AS c
JOIN payment as p ON c.customer_id = p.customer_id
GROUP BY c.first_name, c.last_name, c.customer_id
ORDER BY Monto DESC  ;

SELECT AVG(MONTO) FROM (SELECT c.customer_id AS ID,  CONCAT( c.first_name, ' ' , c.last_name) AS Nombre , SUM(p.amount)  AS Monto
FROM customer AS c
JOIN payment as p ON c.customer_id = p.customer_id
GROUP BY c.first_name, c.last_name, c.customer_id
ORDER BY Monto DESC ) AS sub1;

SELECT c.customer_id,   CONCAT( c.first_name, ' ' , c.last_name) AS Nombre, SUM(p.amount) as total_amount
FROM customer as c
JOIN payment as p ON c.customer_id = p.customer_id 
GROUP BY c.customer_id
HAVING SUM(p.amount) > ( SELECT AVG(MONTO) FROM (SELECT c.customer_id AS ID,  CONCAT( c.first_name, ' ' , c.last_name) AS Nombre , SUM(p.amount)  AS Monto
FROM customer AS c
JOIN payment as p ON c.customer_id = p.customer_id
GROUP BY c.first_name, c.last_name, c.customer_id
ORDER BY Monto DESC ) AS sub1 )
ORDER BY total_amount DESC;