USE sakila;
-- Drop column picture from staff
ALTER TABLE staff
DROP COLUMN picture;
-- A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
SELECT * FROM STAFF;
SELECT * FROM customer WHERE first_name='TAMMY' AND last_name='SANDERS';
INSERT INTO staff VALUES (3,'TAMMY','SANDERS',79,'TAMMY.SANDERS@sakilacustomer.org',2,1,'Tammy','3072','2006-01-25 05:41:16');

-- Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. 
select * from rental;
SELECT customer_id FROM sakila.customer
WHERE first_name = 'CHARLOTTE' AND last_name = 'HUNTER'; #customer_id = 130
SELECT * from staff; #staff=1
SELECT film_id FROM film WHERE title = 'Academy Dinosaur' ; #film_id=1
SELECT inventory_id From Inventory WHERE film_id=1; #1
insert into rental (rental_date, inventory_id, customer_id, staff_id)
values(curdate(), 1,130,1);

select * from rental;
-- Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted. Follow these steps:
-- Check if there are any non-active users
SELECT * FROM customer WHERE active=0;

-- Create a table backup table as suggested

CREATE TABLE deleted_users (
`customer_id` int(11) UNIQUE NOT NULL,
`email` VARCHAR(150),
`date` VARCHAR(150),
CONSTRAINT AUTO_INCREMENT PRIMARY KEY(`customer_id`));

-- Insert the non active users in the table backup table
USE deleted_users;
INSERT INTO deleted_users VALUES
(16, 'SANDRA.MARTIN@sakilacustomer.org', '2006-02-14 22:04:36'),
(64, 'JUDITH.COX@sakilacustomer.org', '2006-02-14 22:04:36'),
(124, 'SHEILA.WELLS@sakilacustomer.org', '2006-02-14 22:04:36'),
(169, 'ERICA.MATTHEWS@sakilacustomer.org', '2006-02-14 22:04:36'),
(241, 'HEIDI.LARSON@sakilacustomer.org', '2006-02-14 22:04:36'),
(271, 'PENNY.NEAL@sakilacustomer.org', '2006-02-14 22:04:36'),
(315, 'KENNETH.GOODEN@sakilacustomer.org', '2006-02-14 22:04:36'),
(368, 'HARRY.ARCE@sakilacustomer.org', '2006-02-14 22:04:36'),
(406, 'NATHAN.RUNYON@sakilacustomer.org', '2006-02-14 22:04:36'),
(446, 'THEODORE.CULP@sakilacustomer.org', '2006-02-14 22:04:36'),
(482, 'MAURICE.CRAWLEY@sakilacustomer.org', '2006-02-14 22:04:36'),
(510, 'BEN.EASTER@sakilacustomer.org', '2006-02-14 22:04:36'),
(534, 'CHRISTIAN.JUNG@sakilacustomer.org', '2006-02-14 22:04:36'),
(558, 'JIMMIE.EGGLESTON@sakilacustomer.org', '2006-02-14 22:04:36'),
(592, 'TERRANCE.ROUSH@sakilacustomer.org', '2006-02-14 22:04:36');

SELECT * FROM deleted_users;
-- Delete the non active users from the table customer
USE sakila;
SET FOREIGN_KEY_CHECKS=0; # Realizar algunas importaciones/actualizaciones de datos que puedan violar temporalmente las restricciones de clave externa
DELETE FROM customer WHERE active=0;      #tuve que desactiviar safe update en preferencias para poder borrarlos    
SET FOREIGN_KEY_CHECKS=1; #volver a habilitar las comprobaciones de clave externa
select * from customer;


