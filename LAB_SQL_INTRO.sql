use sakila;
SELECT * FROM actor;
SELECT * FROM film;
SELECT * FROM customer;
SELECT title FROM film;
SELECT DISTINCT language_id AS language FROM film;
SELECT title, name AS language
FROM film
JOIN language
ON film.language_id = language.language_id;
SELECT COUNT(*) AS STORE_ID FROM Store;
SELECT COUNT(staff_id) FROM staff;
SELECT first_name FROM staff;