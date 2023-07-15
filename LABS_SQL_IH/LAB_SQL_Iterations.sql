-- Write a query to find what is the total business done by each store.
USE sakila;
SELECT i.store_id, SUM(p.amount) AS total_business FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
GROUP BY store_id;

-- Convert the previous query into a stored procedure.

DROP PROCEDURE IF EXISTS total_business;
DELIMITER //
CREATE PROCEDURE total_business()
BEGIN
SELECT i.store_id, SUM(p.amount) AS total_business FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
GROUP BY store_id;
END //

DELIMITER ;
CALL total_business();

-- Convert the previous query into a stored procedure that takes the input for store_id and displays the total sales for that store.
DROP PROCEDURE IF EXISTS total_business_input;

DELIMITER //
CREATE PROCEDURE total_business_input(IN param1 INTEGER)
BEGIN
SELECT i.store_id , SUM(p.amount) AS total_business FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
WHERE store_id = param1
GROUP BY store_id;
END //
DELIMITER ;
CALL total_business_input("1");

-- Update the previous query. Declare a variable total_sales_value of float type, that will store the returned result (of the total sales amount for the store).
-- Call the stored procedure and print the results.
DROP PROCEDURE IF EXISTS total_sales_value;
DELIMITER //
CREATE PROCEDURE total_sales_value(IN param1 INTEGER, OUT param2 FLOAT)
BEGIN
DECLARE total_sales FLOAT;
SELECT ROUND(SUM(p.amount),2) INTO param2 FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
WHERE i.store_id = param1
GROUP BY i.store_id;
END //
DELIMITER ;
CALL total_sales_value("2",@x);
SELECT @x AS total_sales;
 
-- In the previous query, add another variable flag. If the total sales value for the store is over 30.000, then label it as green_flag, otherwise label is as red_flag. 
-- Update the stored procedure that takes an input as the store_id and returns total sales value for that store and flag value.
 drop procedure if exists store_flag;
delimiter //
create procedure store_flag(in store_input integer, out flag varchar(20))
begin
declare total_sales_value float default 0.0;
declare flag varchar(20) default "";
select sum(p.amount) into total_sales_value
from store as s
join staff as st
	on s.store_id=st.store_id
join payment as p
	on st.staff_id=p.staff_id
where s.store_id = store_input
group by s.store_id;
case
	when total_sales_value > 30000 then
		set flag = 'green';
	else
		set flag = 'red';
  end case;  
  select flag into flag;
select flag;    
end //
delimiter ;

call store_flag(1, @x);