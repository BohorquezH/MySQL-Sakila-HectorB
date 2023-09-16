use sakila;

-- para crear subquerys por pasos (common table expression (cte))
with ventas_por_tiendas as(
    SELECT 
        st.store_id,
        concat(a.address, " ", ci.city) as store,
        co.country,
        concat(sf.first_name," ", sf.last_name) as staff,
        p.amount, p.payment_date,
        year(p.payment_date) as year,
        month(p.payment_date) as month,
        dayofmonth(p.payment_date) as day
    from store as st
        join address as a using (address_id)
        join city as ci using (city_id)
        join country as co using(country_id)
        join staff as sf using(store_id)
        join payment as p using(staff_id)
), ventas_tienda_annoxmes as (
    select store, year, month, sum(amount) as amount
    from ventas_por_tiendas
    GROUP BY store, year, month
),  -- vamos a colocar las sumas de los meses en columnas (tipo tabla dinamica (PIVOT EN SQL SERVER))
ventasxtiendaxmes as (
    SELECT store, 
        SUM(case when year=2005 and month=5 then amount else 0 end) as may2005,
        SUM(case when year=2005 and month=6 then amount else 0 end) as jun2005,
        SUM(case when year=2005 and month=7 then amount else 0 end) as jul2005
    from ventas_tienda_annoxmes
    GROUP BY store
)
select *
from ventasxtiendaxmes
limit 5;
