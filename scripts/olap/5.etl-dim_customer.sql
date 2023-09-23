USE sakila;

INSERT INTO sakila_dwh.dim_customer(
    customer_id, customer, district, city, country
) 
SELECT 
    c.customer_id,
    CONCAT(c.last_name,' ',c.first_name) AS customer,
    ad.district, 
    ci.city,
    co.country
FROM customer AS c
    JOIN address AS ad USING(address_id)
    JOIN city AS ci USING(city_id)
    JOIN country AS co USING(country_id)
;

