# Creacion del esquema de la Bodega de Datos

CREATE DATABASE IF NOT EXISTS sakila_dwh;
USE sakila_dwh;

-- Dimension de tiempo
CREATE TABLE IF NOT EXISTS dim_time(
    date_key INT(8) NOT NULL, 
    date_value DATE NOT NULL,
    month_number INT(3) NOT NULL,
    month_name CHAR(12) NOT NULL,
    year4 INT(5) NOT NULL,
    day_of_week INT(5) NOT NULL,
    day_of_week_nam CHAR(12) NOT NULL,

    PRIMARY KEY (date_key), 
    UNIQUE INDEX date_value (date_value)
    
);
-- TODO FK deberia tener una llave

CREATE TABLE IF NOT EXISTS fac_rental(
    rental_key INT(8) NOT NULL AUTO_INCREMENT,
    rental_id INT(11) NOT NULL,
    date_key INT(8) NOT NULL,
    count_rental INT(11) NOT NULL,

    PRIMARY KEY(rental_key),
    UNIQUE INDEX rental_id (rental_id),

    INDEX date_key (date_key),
    FOREIGN KEY (date_key) REFERENCES dim_time(date_key) 
);

-- ALTER TABLE dim_time CHANGE column `dete_value` `date_value` date;