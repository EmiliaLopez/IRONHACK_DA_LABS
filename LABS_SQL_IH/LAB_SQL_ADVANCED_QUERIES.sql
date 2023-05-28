-- List each pair of actors that have worked together.

use sakila;

select * from film_actor;
select distinct film.film_id,actor.actor_id from sakila.film_actor actor 
join sakila.film_actor film on actor.actor_id <> film.actor_id
and actor.film_id = film.film_id;

create temporary table tabla_2
select test1.actor_id as actor1, test1.film_id as peli1, test2.actor_id as actor2, test2.film_id as peli2 from film_actor test1, film_actor test2
where test1.film_id = test2.film_id;

select * from tabla_2;

create temporary table tabla_3
select actor1, actor2 from tabla_2
where actor1 <> actor2 and actor2 > actor1;

select * from tabla_3;

-- For each film, list actor that has acted in more films.

select * from film_actor;

select actor_id,count(*) number_of_films from film_actor
group by actor_id
order by number_of_films desc;