--Creating database/tables, starting with tables that have no FK

CREATE TABLE customer(
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	payment_info VARCHAR(100)
);

--Movie table - showing which movie being attended 
CREATE TABLE movie(
	movie_id SERIAL PRIMARY KEY,
	start_time TIME,
	end_time TIME,
	screen_num INTEGER
);

--tickets_sold table 
CREATE TABLE tickets_sold(
	ticket_num SERIAL PRIMARY KEY,
	show_time TIME,
	ticket_type VARCHAR(50), --child/adult/senior
	ticket_price NUMERIC(5,2),
	customer_id SERIAL NOT NULL,
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
);

--movie_list table (listing of all movies/library/reference of movie info)
CREATE TABLE movie_list(
	movie_name VARCHAR(150) PRIMARY KEY,
	genre VARCHAR(100),
	rating VARCHAR(50),
	movie_id SERIAL NOT NULL,
	FOREIGN KEY(movie_id) REFERENCES movie(movie_id)
);

--concession_sales table
CREATE TABLE concession_sales(
	transaction_num SERIAL PRIMARY KEY,
	purchase_date DATE DEFAULT CURRENT_DATE,
	purchase_amount NUMERIC(8,2),
	customer_id SERIAL NOT NULL,
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
);