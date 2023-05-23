-- Get all pairs of actors that worked together.
USE sakila;

SELECT DISTINCT a1.actor_id AS actor1_id, a1.first_name AS actor1_first_name, a1.last_name AS actor1_last_name,
                a2.actor_id AS actor2_id, a2.first_name AS actor2_first_name, a2.last_name AS actor2_last_name,
                f.title AS film_title
FROM sakila.actor a1
JOIN sakila.film_actor fa1 ON a1.actor_id = fa1.actor_id
JOIN sakila.film f ON fa1.film_id = f.film_id
JOIN sakila.film_actor fa2 ON f.film_id = fa2.film_id
JOIN sakila.actor a2 ON fa2.actor_id = a2.actor_id
WHERE a1.actor_id < a2.actor_id;


-- Get all pairs of customers that have rented the same film more than 3 time

select * from customer;
select * from rental;
select * from inventory;

create temporary table client1
select r.customer_id, r.inventory_id, i.film_id, f.title from rental r
join inventory i on r.inventory_id = i.inventory_id
join film f on f.film_id = i.film_id;

select * from client1;

create temporary table client2
select r.customer_id, r.inventory_id, i.film_id, f.title from rental r
join inventory i on r.inventory_id = i.inventory_id
join film f on f.film_id = i.film_id;

select * from client2;

select client1.customer_id, client2.customer_id, count(*) as coincidences from client1
join client2 on client1.film_id = client2.film_id
where client1.customer_id <> client2.customer_id
group by client1.customer_id, client2.customer_id
having count(*) > 3
order by client1.customer_id, client2.customer_id;

-- Get all possible pairs of actors and films.

SELECT a.actor_id, a.first_name, a.last_name, f.title
FROM actor a
CROSS JOIN film f
order by 1;


