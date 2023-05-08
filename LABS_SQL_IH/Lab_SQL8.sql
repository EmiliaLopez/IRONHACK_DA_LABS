use sakila;
-- Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output
SELECT title, length, rank() over(order by length desc) as 'RANK'
FROM film
WHERE length IS NOT NULL;

-- Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank
SELECT title, length, rating, rank() over(order by length desc) as 'RANK'
FROM film
WHERE length IS NOT NULL;

-- How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category". NECESITO UNIR FILM, FILM_CATEGORY  Y CATEGORY
SELECT fc.category_id, c.name, COUNT(f.film_id) as num_peliculas
FROM film as f
inner join film_category as fc ON f.film_id = fc.film_id
INNER JOIN category as C ON c.category_id = fc.category_id
GROUP BY  category_id, c.name
ORDER BY c.name;

SELECT DISTINCT title, category_id, rating AS category, RANK() OVER(ORDER BY rating DESC) as 'RANK'
FROM film f
INNER JOIN film_category AS fc ON f.rating=fc.category_id;


-- Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears

SELECT first_name, last_name, a.actor_id, count(*) AS total_films
FROM actor a
INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.last_name
ORDER BY count(*) DESC LIMIT 1;


-- Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer
SELECT c.customer_id,  c.first_name as nombre, c.last_name as apellido,  COUNT(r.rental_id) as total_rentas
FROM customer as c
INNER JOIN rental as r ON c.customer_id = r.customer_id
GROUP BY c.customer_id
ORDER BY total_rentas DESC LIMIT 1;

#Bonus: Which is the most rented film? (The answer is Bucket Brotherhood).
SELECT f.film_id, f.title as Titulo, count(rental_id) as num_rentas
FROM inventory as i
inner join rental as r ON i.inventory_id=r.inventory_id
INNER JOIN film as f ON f.film_id = i.film_id
GROUP BY  f.film_id, f.title
Order by  num_rentas DESC LIMIT 1 ;