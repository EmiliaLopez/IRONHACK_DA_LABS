-- Get number of monthly active customers.
Use sakila;
select * from rental;
WITH customer_activity AS (
  SELECT customer_id, 
         CONVERT(rental_date, DATE) AS Activity_date,
         DATE_FORMAT(CONVERT(rental_date, DATE), '%Y') AS Activity_year,
         DATE_FORMAT(CONVERT(rental_date, DATE), '%M') AS Activity_Month,
         DATE_FORMAT(CONVERT(rental_date, DATE), '%m') AS Activity_Month_Number
  FROM sakila.rental
)
SELECT COUNT(DISTINCT customer_id) AS Active_users, Activity_year, Activity_Month
FROM customer_activity
GROUP BY Activity_year, Activity_Month, Activity_Month_Number
ORDER BY Activity_year, Activity_Month_Number;

-- Active users in the previous month.
with customer_activity as (
  select customer_id, convert(rental_date, date) as Activity_date,
  date_format(convert(rental_date,date), '%Y') as Activity_year,
  date_format(convert(rental_date,date), '%M') as Activity_Month,
  date_format(convert(rental_date,date), '%m') as Activity_Month_Number
  from sakila.rental
),
monthly_active_users as (
  select count(distinct customer_id) as Active_users, Activity_year, Activity_Month_Number
  from customer_activity
  group by Activity_year, Activity_Month_Number
  order by Activity_year, Activity_Month_Number
),
cte_activity as (
  select Active_users, lag(Active_users,1) over (partition by Activity_year) as last_month, Activity_year, Activity_Month_Number  from monthly_active_users
)
select * from cte_activity
where last_month is not null;


-- Percentage change in the number of active customers.
with customer_activity as (
  select customer_id, convert(rental_date, date) as Activity_date,
  date_format(convert(rental_date,date), '%Y') as Activity_year,
  date_format(convert(rental_date,date), '%M') as Activity_Month,
  date_format(convert(rental_date,date), '%m') as Activity_Month_Number
  from sakila.rental
),
monthly_active_users as (
  select count(distinct customer_id) as Active_users, Activity_year, Activity_Month_Number
  from customer_activity
  group by Activity_year, Activity_Month_Number
  order by Activity_year, Activity_Month_Number
),
cte_activity as (
  select Active_users, lag(Active_users,1) over (partition by Activity_year) as last_month, Activity_year, Activity_Month_Number
  from monthly_active_users
)
select (Active_users-last_month)/Active_users*100 as percentage_change, Activity_year, Activity_Month_Number
from cte_activity
where last_month is not null;

-- Retained customers every month.
WITH customer_activity AS (
  SELECT customer_id, 
         CONVERT(rental_date, DATE) AS Activity_date,
         DATE_FORMAT(CONVERT(rental_date, DATE), '%M') AS Activity_Month,
         DATE_FORMAT(CONVERT(rental_date, DATE), '%Y') AS Activity_year,
         CONVERT(DATE_FORMAT(CONVERT(rental_date, DATE), '%m'), UNSIGNED) AS month_number
  FROM sakila.rental
),
distinct_users AS (
  SELECT DISTINCT customer_id, Activity_month, Activity_year, month_number
  FROM customer_activity
)
SELECT COUNT(DISTINCT d1.customer_id) AS Retained_customers, d1.Activity_month, d1.Activity_year
FROM distinct_users d1
JOIN distinct_users d2 ON d1.customer_id = d2.customer_id AND d1.month_number = d2.month_number + 1
GROUP BY d1.Activity_month, d1.Activity_year, d1.month_number
ORDER BY d1.Activity_year, d1.month_number;
