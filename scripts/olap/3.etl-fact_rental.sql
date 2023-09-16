INSERT INTO sakila_dwh.fac_rental(
    rental_id, date_key, count_rental
)
SELECT 
    rental_id,
    TO_DAYS(rental_date) AS date_key,
    1 as count_rental
FROM (
    SELECT
        rental_id,
        rental_date
    FROM
        sakila.rental
) rental
