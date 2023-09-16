USE sakila;

WITH ventas_por_cliente AS (
    SELECT
            film_id
            ,title
            ,category.name AS category,
            CONCAT(first_name, ' ', last_name) AS customer,
            rental_date
        FROM inventory
            LEFT JOIN rental USING(inventory_id)
            LEFT JOIN film USING(film_id)
            LEFT JOIN film_category USING(film_id)
            LEFT JOIN category USING(category_id)
            LEFT JOIN customer USING(customer_id)
), -- separamos la fecha
ventas_por_fecha AS (
    SELECT customer,
        year(rental_date) AS rental_year,
        month(rental_date) AS rental_month,
        COUNT(*) as rental_times
    FROM ventas_por_cliente
    GROUP BY customer,rental_month,rental_year
), -- TRANSPONEMOS LAS COLUMNAS DE MESES 
clientes_comparativo_mes AS (
    SELECT customer,
        SUM(CASE WHEN rental_year=2005 AND rental_month = 5 THEN rental_times ELSE 0 END) as may2005,
        SUM(CASE WHEN rental_year=2005 AND rental_month = 6 THEN rental_times ELSE 0 END) as jun2005,
        SUM(CASE WHEN rental_year=2005 AND rental_month = 7 THEN rental_times ELSE 0 END) as jul2005
    FROM ventas_por_fecha
    GROUP BY customer
), --   DIFERENCIAS Y PORCENTAJE DE CRECIMIENTO
diferencias_porcentaje AS (
    SELECT customer, (jun2005 - may2005) AS diffjun2005, ((jun2005-may2005)/may2005) AS porcjun2005, (jul2005 - jun2005) AS diffjul2005, ((jul2005-jun2005)/jun2005) AS porcjul2005
    FROM clientes_comparativo_mes
)
SELECT * 
FROM diferencias_porcentaje 
LIMIT 5;   