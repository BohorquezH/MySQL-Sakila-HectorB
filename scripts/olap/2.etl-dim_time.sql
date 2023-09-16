-- USAR LAS TABLAS CON EL NOMBRE DEL ESQUEMA
-- SAKILA.RENTAL
-- INSERTAMOS DE LA OLTP A LA OLAP


INSERT INTO sakila_dwh.dim_time(
    date_key, date_value, month_number, month_name, year4, day_of_week, day_of_week_nam
)
SELECT 
    TO_DAYS(date) AS date_key,
    date AS date_value,
    MONTH(date) AS month_number,
    MONTHNAME(date) AS month_name,
    YEAR(date) AS year4,
    DAYOFWEEK(date) AS day_of_week,
    DAYNAME(date) AS day_of_week_nam
FROM (
    SELECT DISTINCT DATE(rental_date) AS DATE
    FROM sakila.rental
) AS fechas;


