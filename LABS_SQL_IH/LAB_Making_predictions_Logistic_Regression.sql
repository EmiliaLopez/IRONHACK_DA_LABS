-- Create a query or queries to extract the information you think may be relevant for building the prediction model. It should include some film features and some rental features.
use sakila;
select * from film;

select film_id, release_year, language_id, rental_duration, rental_rate, length, rating, special_features from film;

select * from rental;
select * from inventory;

select i.inventory_id, i.film_id, r.rental_id, r.rental_date
from inventory i 
join rental r on i.inventory_id=r.inventory_id;



-- Read the data into a Pandas dataframe.
-- Analyze extracted features and transform them. You may need to encode some categorical variables, or scale numerical variables.
-- Create a query to get the list of films and a boolean indicating if it was rented last month. This would be our target variable.
-- Create a logistic regression model to predict this variable from the cleaned data.
--- Evaluate the results.