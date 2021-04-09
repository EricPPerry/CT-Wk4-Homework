--CREATING FUNCTIONS
--CREATE FUNCTION to add_customer with provided parameters
CREATE OR REPLACE FUNCTION add_customer(
	_customer_id INTEGER,
	_first_name VARCHAR,
	_last_name VARCHAR,
	_billing_info VARCHAR,
	_address VARCHAR
)
RETURNS void
AS $$
BEGIN
	INSERT INTO customer(customer_id, first_name,last_name,billing_info,address)
	VALUES(_customer_id, _first_name, _last_name, _billing_info, _address);
END;
$$
LANGUAGE plpgsql;

--CREATE FUNCTION to add sales people to salesperson staff list/table
CREATE OR REPLACE FUNCTION add_salesperson(
	_sales_id INTEGER,
	_first_name VARCHAR,
	_last_name VARCHAR
)
RETURNS void
AS $ANYTHINGYOUWANT$
BEGIN
	INSERT INTO salesperson(sales_id, first_name, last_name)
	VALUES(_sales_id, _first_name, _last_name);
END;
$ANYTHINGYOUWANT$
LANGUAGE plpgsql;

--CREATE FUNCTION to add car into inventory
CREATE OR REPLACE FUNCTION add_car(
	_dealer_id INTEGER,
	_make VARCHAR(100),
	_model VARCHAR(100),
	_year INTEGER,
	_color VARCHAR(100),
	_price NUMERIC(8,2),
	_status VARCHAR(15)
)
RETURNS void
AS $SERIOUSLYANYTHINGGOESHERE$
BEGIN
	INSERT INTO dealer_car(dealer_id, make, model, year_, color, price, status)
	VALUES(_dealer_id, _make, _model, _year, _color, _price, _status);
END;
$SERIOUSLYANYTHINGGOESHERE$
LANGUAGE plpgsql;

--CREATE FUNCTION to generate invoice for car sale
CREATE OR REPLACE FUNCTION add_invoice(
	_invoice_id INTEGER,
	_sales_id INTEGER,
	_dealer_id INTEGER,
	_customer_id INTEGER
)
RETURNS void
AS $$
BEGIN
	INSERT INTO invoice(invoice_id, sales_id, dealer_id, customer_id)
	VALUES(_invoice_id, _sales_id, _dealer_id, _customer_id);
END;
$$
LANGUAGE plpgsql;

--CREATE FUNCTION to add a customer's car to the service database/table
CREATE OR REPLACE FUNCTION add_customer_service_car(
	_car_id INTEGER,
	_make VARCHAR,
	_model VARCHAR,
	_year INTEGER,
	_color VARCHAR(100),
	_mileage INTEGER,
	_customer_id INTEGER
)
RETURNS void
AS $$
BEGIN
	INSERT INTO c_car(car_id, make, model, year_, color, mileage, customer_id)
	VALUES(_car_id, _make, _model, _year, _color, _mileage, _customer_id);
END;
$$
LANGUAGE plpgsql;

--CREATE FUNCTION to add aprt to inventory/warehouse
CREATE OR REPLACE FUNCTION add_part(
	_parts_id INTEGER,
	_type VARCHAR,
	_cost NUMERIC(6,2)
)
RETURNS void
AS $$
BEGIN
	INSERT INTO parts(parts_id, type_, cost_)
	VALUES(_parts_id, _type, _cost);
END;
$$
LANGUAGE plpgsql;

--CREATE FUNCTION to add mechanic to table/when mechanic is hired
CREATE OR REPLACE FUNCTION add_mechanic(
	_mechanic_id INTEGER,
	_first_name VARCHAR,
	_last_name VARCHAR
)
RETURNS void
AS $$
BEGIN
	INSERT INTO mechanic(mechanic_id, first_name, last_name)
	VALUES(_mechanic_id, _first_name, _last_name);
END;
$$
LANGUAGE plpgsql;

--CREATE FUNCTION to create invoice for work done by mechanics 
CREATE OR REPLACE FUNCTION add_service_ticket(
	_service_id INTEGER,
	_service_type VARCHAR,
	_service_cost NUMERIC(6,2),
	_status VARCHAR,
	_car_id INTEGER,
	_mechanic_id INTEGER,
	_parts_id INTEGER
)
RETURNS void
AS $$
BEGIN
	INSERT INTO service_ticket(service_id, service_type, service_cost, status, car_id, mechanic_id, parts_id)
	VALUES(_service_id, _service_type, _service_cost, _status, _car_id, _mechanic_id, _parts_id);
END;
$$
LANGUAGE plpgsql;


------CALLING STORED FUNCTIONS TO POPULATE TABLES

--CALLING STORED FUNCTION TO INSERT CUSTOMER INFORMATION
SELECT add_customer(1,'Eric','Perry','4040-8080-0000-1111','123 Fake Street, Townville USA');
SELECT add_customer(2,'Robert', 'Secondcustomerson', '2244-0404-1111-0000', '1 King St, Cooltopa USA');
SELECT add_customer(3,'Boris', 'Brokemycar', '4444-1231-1111-0000', 'Former USSR');
SELECT add_customer(4,'Oldman', 'Jenkins', '000-0000-0000-0001', '1 State Street, Chicago IL');

--CALLING STORED FUNCTION TO INSERT SALESPERSON
SELECT add_salesperson(1,'Vincent', 'Adultman');
SELECT add_salesperson(2,'Dewey', 'Ripemoff');
SELECT add_salesperson(3,'Ron', 'Swanson');

--CALLING STORED FUNCTION TO ADD CARS TO INVENTORY
SELECT add_car(1, 'Volkswagen', 'GTI', '2018', 'Great Falls Green', '20', 'USED');
SELECT add_car(2, 'Tesla', 'Gofast', '2021', 'Elon Orange', '500000', 'NEW');


--CALLING STORED FUNCTION TO ADD INVOICES FOR CAR SALES
SELECT add_invoice(1, 1, 1, 1);
SELECT add_invoice(2, 1, 1, 3);

--CALLING STORED FUNCTION TO ADD NEW CARS TO SERVICE LIST/SERVICE DEPT TABLE
SELECT add_customer_service_car(1, 'Saturn', 'Rustbucket', '1984', 'Beige', '223142', '3');
SELECT add_customer_service_car(2, 'Buick', 'Lebroken', '1994', 'Goldish', '114142', '4');


--CALLING STORED FUNCTION TO ENTER NEW PARTS TO WAREHOUSE/SHOP
SELECT add_part(1, 'Blinker Fluid', '9.99');
SELECT add_part(2, 'New Engine', '4499.99');
SELECT add_part(3, 'Headlight', '89.99');


--CALLING STORED FUNCTION TO ENTER NEW HIRED MECHANICS
SELECT add_mechanic(1, 'Johnny', 'Hammerhands')
SELECT add_mechanic(2, 'William', 'Wrenchworth')

SELECT add_service_ticket(1, 'old timey tune up', '500', 'COMPLETED', 1, 2, NULL); --for repair that required no part
SELECT add_service_ticket(2, 'everything is broken', '8000', 'INPROGRESS', 1, 2, 2); --for repair that required no parts yet
SELECT add_service_ticket(3, 'needs a new engine', '5000', 'COMPLETED', 2, 2, 2);



--Playing with JOINs to show invoice id #, salesperson id # and make/model of car for customers with last name 'Perry'
SELECT customer.first_name, customer.last_name, invoice.invoice_id, invoice.sales_id AS salesperson_id, dealer_car.make, dealer_car.model
FROM customer
FULL JOIN invoice
ON customer.customer_id = invoice.customer_id
FULL JOIN dealer_car
ON invoice.dealer_id = dealer_car.dealer_id
WHERE customer.last_name = 'Perry';


--JOIN to show all work done and mechanic involved for customer_id 3
SELECT customer.first_name AS customer_firstname, customer.last_name AS customer_lastname, c_car.car_id, c_car.model, service_type, service_cost, mechanic.first_name AS mechanic_name
FROM customer 
FULL JOIN c_car
ON customer.customer_id = c_car.customer_id
FULL JOIN service_ticket
ON c_car.car_id = service_ticket.car_id
FULL JOIN mechanic
ON service_ticket.mechanic_id = mechanic.mechanic_id
WHERE customer.customer_id = 3;
