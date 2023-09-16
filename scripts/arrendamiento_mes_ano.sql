use sakila;

-- 1. unir los datos
WITH datos_alquiler as(
    SELECT
            film_id
            ,title
            ,category.name AS category,
            year(rental.rental_date) as rental_year,
            month(rental.rental_date) as rental_month,
            dayofmonth(rental.rental_date) as rental_day
        FROM inventory
            LEFT JOIN rental USING(inventory_id)
            LEFT JOIN film USING(film_id)
            LEFT JOIN film_category USING(film_id)
            LEFT JOIN category USING(category_id)
            -- GROUP BY film_id, title, category
), -- 2. agrupar por año mes 
datos_alquier_ano_mes as(
    SELECT title, rental_year, rental_month, count(*) as rental_times
    FROM datos_alquiler
    GROUP BY title, rental_year, rental_month
), -- 3. pasar algunas filas a columnas 
datos_alquiler_por_mes as(
    SELECT title, 
        SUM(CASE WHEN rental_year=2005 AND rental_month = 5 THEN rental_times ELSE 0 END) as may2005,
        SUM(CASE WHEN rental_year=2005 AND rental_month = 6 THEN rental_times ELSE 0 END) as jun2005
    FROM datos_alquier_ano_mes
    GROUP BY title
), -- 4. calcular diferencias y porcentajes de crecimiento
datos_alquiler_comparativo_mes as (
    SELECT title, may2005, jun2005, 
        (jun2005-may2005) as diffjun2005, 
        CASE WHEN may2005 <> 0 THEN 
            ((jun2005-may2005)/may2005) 
        ELSE 0 
        END AS porcjun2005
    FROM datos_alquiler_por_mes
)
SELECT * 
FROM datos_alquiler_comparativo_mes
LIMIT 5; 

