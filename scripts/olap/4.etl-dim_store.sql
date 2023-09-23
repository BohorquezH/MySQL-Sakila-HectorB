USE sakila;

INSERT INTO sakila_dwh.dim_store(
    store_id, store, district, city, country
) 
SELECT 
    st.store_id,
    CONCAT(ad.address_id) AS store, 
    ad.district, 
    ci.city_id,
    co.country
FROM store AS st
    JOIN address AS ad USING(address_id)
    JOIN city AS ci USING(city_id)
    JOIN country AS co USING(country_id)
LIMIT 5;

