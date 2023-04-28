USE sakila;
SELECT * FROM actor WHERE first_name = 'Scarlett';
SELECT * FROM actor WHERE last_name = 'Johansson';
SELECT COUNT(inventory_id)  FROM inventory;
SELECT COUNT(inventory_id) AS num_rentals FROM rental;
SELECT max(length) as max_duration FROM film;
SELECT min(length) as min_duration FROM film;
SELECT AVG(length) AS avg_duration FROM film;
SELECT CONCAT(FLOOR(AVG(length) / 60), 'h ', AVG(length) % 60, 'm') AS avg_duration
FROM film;
SELECT COUNT(*) FROM film WHERE 'lenght' > 180;
SELECT CONCAT(first_name, ' ', UPPER(last_name), ' - ', LOWER(email)) AS formatted_info
FROM customer;
SELECT MAX(LENGTH(title)) AS max_length
FROM film;