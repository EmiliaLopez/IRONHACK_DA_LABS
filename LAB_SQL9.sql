use sakila;
-- Create a table rentals_may to store the data from rental table with information for the month of May.
use sakila;
create table rentals_may (
rental_id int(11) unique not null,
rental_date datetime default null,
inventory_id int(11) default null,
customer_id int(11) default null,
return_date datetime default null,
staff_id int(11) default null,
last_update datetime default null,
constraint primary key (rental_id)
);

select * from rentals_may;

-- InSert values in the table rentals_may using the table rental, filtering values only for the month of May

insert into rentals_may
select * from rental
WHERE rental_date between '2005-05-01 00:00:00' and '2005-05-31 23:59:00';

select * from rentals_may;

-- Create a table rentals_june to store the data from rental table with information for the month of June.
create table rentals_june (
rental_id int(11) unique not null,
rental_date datetime default null,
inventory_id int(11) default null,
customer_id int(11) default null,
return_date datetime default null,
staff_id int(11) default null,
last_update datetime default null,
constraint primary key (rental_id)
);

select * from rentals_june;

-- Insert values in the table rentals_june using the table rental, filtering values only for the month of June.
insert into rentals_june
select * from rental
WHERE rental_date between '2005-06-01 00:00:00' and '2005-06-30 23:59:59';

select * from rentals_june;
-- Check the number of rentals for each customer for May.
SELECT customer_id, COUNT(*) as num_rentals
FROM rentals_may
GROUP BY customer_id;

--  Check the number of rentals for each customer for June.
SELECT customer_id, COUNT(*) as num_rentals
FROM rentals_june
GROUP BY customer_id;
