--WEEK 4 DAY 3 HOMEWORK

--1. List all customers who live in Texas
---Answer (ID, first_name, last_name): 
--6 Jennifer Davis, 118 Kim Cruz 
--305 Richard Mccrary
--400 Bryand Hardison 
--561 Ian Still
--Query used to solve:
SELECT customer_id, first_name, last_name, address, district
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
WHERE address.district = 'Texas';

--2. Get all payments above $6.99 with the Customer's Full Name

SELECT first_name, last_name, amount, payment_id
FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id
WHERE payment.amount > 6.99
ORDER BY last_name;

---to help narrow it down a little more, grouping by names and sorting by the count of payments above $6.99
SELECT first_name, last_name, COUNT(amount)
FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id
WHERE payment.amount > 6.99
GROUP BY first_name, last_name
ORDER BY COUNT(payment.amount) DESC;



--3. Show all customers names who have made payments over $175 (use subqueries)
SELECT *
FROM customer
WHERE customer_id IN(
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
);



--4. List all customers that live in nepal (use the city table)
--Answer: 1 customer - Kevin Schuler

SELECT customer.first_name, customer.last_name, country
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id
FULL JOIN city
ON address.city_id = city.city_id
FULL JOIN country
ON city.country_id = country.country_id
WHERE country = 'Nepal';

--5. Which staff member had that most transactions?
--Answer: Mike Hillyer
SELECT first_name, last_name, COUNT(payment_id)
FROM staff
INNER JOIN payment 
ON staff.staff_id = payment.staff_id
GROUP BY first_name, last_name
ORDER BY COUNT(payment.payment_id)
LIMIT 1;




--6. How many movies of each rating are there?
--Answer: PG-13 - 223, NC-17 - 210, R - 195, PG - 194, G - 178 
SELECT rating, COUNT(rating) AS num_movies 
FROM film
GROUP BY rating
ORDER BY COUNT(rating) DESC;


--7. Show all customers who have made a single payment above $6.99 (use subqueries)
SELECT first_name, last_name
FROM customer
WHERE customer_id IN(
	SELECT customer_id
	FROM payment
	GROUP BY customer_id, amount
	HAVING amount > 6.99
)
ORDER BY last_name;

--8. How many free rentals did our stores give away?
--Answer: 24

SELECT COUNT(rental.rental_id) AS num_free_rentals
FROM rental
INNER JOIN payment
ON rental.rental_id = payment.rental_id
WHERE amount = 0;
