WITH datos AS (
        SELECT
            rental_id, rental_date,
            to_days(rental_date) AS date_key,
            customer_id, customer_key,
            store_id,
            store_key
        FROM
            sakila.rental
            JOIN sakila_dwh.dim_customer USING(customer_id)
            JOIN sakila.staff USING(staff_id)
            JOIN sakila_dwh.dim_store USING(store_id)
)
SELECT * 
FROM datos 
LIMIT 5; 
