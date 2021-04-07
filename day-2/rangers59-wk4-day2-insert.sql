--INSERTING DATA INTO HOMEWORK TABLES

--Inserts for customer table
INSERT INTO customer(
	customer_id,
	first_name,
	last_name,
	payment_info
) VALUES(
	1,
	'Eric',
	'Perry',
	'4040-4040-1111-2222'
);

--Inserts for movie showing table
INSERT INTO movie(
	movie_id,
	start_time,
	end_time,
	screen_num
) VALUES (
	1,
	'08:00:00',
	'10:00:00',
	1
);

--Inserts for tickets_sold
INSERT INTO tickets_sold(
	ticket_num,
	show_time,
	ticket_type,
	ticket_price,
	customer_id
) VALUES(
	1,
	'08:00:00',
	'adult',
	8.99,
	1
);

--Inserts into movie_list
INSERT INTO movie_list(
	movie_name,
	genre,
	rating,
	movie_id
) VALUES(
	'Godzilla',
	'Action',
	'PG13',
	1
);

--Inserts into concession_sales
INSERT INTO concession_sales(
	transaction_num,
	purchase_amount,
	customer_id
) VALUES(
	1,
	50.00,
	1
);