INSERT INTO sakila_dwh.fac_rental(
    rental_id,
    date_key,
    store_key,
    customer_key,
    count_rental
)
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
SELECT 
    rental_id,
    date_key,
    store_key,
    customer_key,
    1 AS count_rental
FROM datos  
