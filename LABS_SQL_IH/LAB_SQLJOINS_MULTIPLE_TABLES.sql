-- Write a query to display for each store its store ID, city, and country.

select s.store_id,ci.city,co.country from sakila.store s 
join sakila.customer c on s.store_id = c.store_id
join sakila.address a on c.address_id = a.address_id
join sakila.city ci on a.city_id = ci.city_id
join sakila.country co on ci.country_id = co.country_id;

-- Write a query to display how much business, in dollars, each store brought in

select sum(p.amount) as total_money_in_dollars, s.store_id from sakila.store s 
join sakila.staff st on s.store_id = st.store_id
right join sakila.payment p on st.staff_id = p.staff_id
group by s.store_id;

-- What is the average running time of films by category?

select sum(f.length) as total_running_time,c.name from sakila.film f 
join sakila.film_category fc on f.film_id = fc.film_id
join sakila.category c on fc.category_id = c.category_id
group by c.name;


-- Which film categories are longest?

select sum(f.length) as total_running_time,c.name from sakila.film f 
join sakila.film_category fc on f.film_id = fc.film_id
join sakila.category c on fc.category_id = c.category_id
group by c.name
order by total_running_time desc
limit 5;

-- Display the most frequently rented movies in descending order

select count(*) as frequency_rented,f.title  from sakila.film f 
join sakila.inventory i on f.film_id = i.film_id
join sakila.rental r on i.inventory_id = r.inventory_id
group by f.title
order by frequency_rented desc;


-- List the top five genres in gross revenue in descending order
select sum(p.amount) as revenue,c.name from sakila.category c 
join sakila.film_category fc on c.category_id = fc.category_id 
join sakila.film f on fc.film_id = f.film_id 
join sakila.inventory i on f.film_id = i.film_id
join sakila.rental r on i.inventory_id = r.inventory_id
join sakila.payment p on r.customer_id = p.customer_id
group by c.name
order by revenue desc;


-- Is "Academy Dinosaur" available for rent from Store 1?

select distinct s.store_id,f.title,r.rental_date,r.return_date from sakila.film f 
right join sakila.inventory i on f.film_id = i.film_id
right  join sakila.store s on i.store_id = s.store_id 
right join sakila.staff st  on s.store_id = st.store_id
right join sakila.rental r on st.staff_id = r.staff_id;