-- 1. How many actors are there with the last name "Wahlberg"?
SELECT COUNT(last_name) AS Wahlbergers
FROM actor
WHERE last_name = 'Wahlberg';

--2. How many payments were made between $3.99 and $5.99?
SELECT COUNT(amount) AS Payments_between_399_599
FROM payment
WHERE amount BETWEEN 3.99 AND 5.99;

--3. What film does the store have the most of? (search in inventory)
--Looks like multiple were tied for most with 8, so there are multiple returns
SELECT film_id, COUNT(film_id)
FROM inventory
GROUP BY film_id
ORDER BY COUNT(film_id) DESC;

--4. How many customers have the name 'William'?
SELECT COUNT(last_name) AS Number_of_Wills
FROM customer
WHERE last_name LIKE 'William';

--5. What store employee (get the id) sold the most rentals?
SELECT staff_id, COUNT(staff_id) AS Rentals_Sold
FROM rental
GROUP BY staff_id
LIMIT 1;

--6. How many different district names are there?
SELECT COUNT(DISTINCT district) AS Num_Different_Districts
FROM address;

--7. What film has the most actors in it?
SELECT film_id AS Film_ID_with_most_actors, COUNT(film_id) AS Number_of_Actors
FROM film_actor
GROUP BY film_id
ORDER BY COUNT(film_id) DESC
LIMIT 1;

--8. From store_id 1, how many customers have a last name ending with 'es'?
SELECT COUNT(customer_id) AS Customers_with_last_names_ending_ES
FROM customer
WHERE store_id=1 AND last_name LIKE '%es';

--9. How many payment amounts (4.99, 5.99, etc.) had a number of rentals above 250 
--for customers with ids between 380 and 430 (group by and having > 250)
SELECT DISTINCT amount
FROM payment
WHERE customer_id BETWEEN 380 AND 430
GROUP BY amount
HAVING COUNT(amount)>250;


--10. Within the film table, how many rating categories are there?
SELECT COUNT(DISTINCT rating) AS Num_Rating_Categories
FROM film;

-- And what rating has the most movies total?
SELECT rating, COUNT(rating)
FROM film
GROUP BY rating
ORDER BY COUNT(rating) DESC
LIMIT 1;