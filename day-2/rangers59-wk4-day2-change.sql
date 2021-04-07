UPDATE movie_list
SET rating = 'R'
WHERE movie_name = 'Godzilla'

--ADD EMAIL OPTION FOR CUSTOMERS, TO PROMOTE SIGN UP FOR REWARDS
ALTER TABLE customer
ADD customer_email VARCHAR(150);
--Update existing customer ID with email
UPDATE customer
SET customer_email = 'throwawayemail@gmail.com'
WHERE customer_id = 1

