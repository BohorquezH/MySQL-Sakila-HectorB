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

-- Dimension Tienda
CREATE TABLE IF NOT EXISTS  dim_store(
    store_key INT NOT NULL AUTO_INCREMENT,
    store_id TINYINT(8) NOT NULL,
    store VARCHAR(20) NOT NULL,
    district VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY(store_key),
    UNIQUE INDEX store_id(store_id)
);


-- Dimension Cliente
CREATE TABLE IF NOT EXISTS  dim_customer(
    customer_key INT NOT NULL AUTO_INCREMENT,
    customer_id SMALLINT(8) NOT NULL,
    customer VARCHAR(90) NOT NULL,
    district VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY(customer_key),
    UNIQUE INDEX store_id(customer_id)
);




CREATE TABLE IF NOT EXISTS fac_rental(
    rental_key INT(8) NOT NULL AUTO_INCREMENT,
    rental_id INT(11) NOT NULL,
    
    date_key INT(8) NOT NULL,
    store_key INT(8) NOT NULL,
    customer_key INT(8) NOT NULL,

    count_rental INT(11) NOT NULL,

    PRIMARY KEY(rental_key),
    UNIQUE INDEX rental_id (rental_id),
    INDEX store_key (store_key),
    FOREIGN KEY (store_key) REFERENCES dim_store(store_key) 
    INDEX customer_key (customer_key),
    FOREIGN KEY (customer_key) REFERENCES dim_customer(customer_key)
);

-- ALTER TABLE dim_time CHANGE column `dete_value` `date_value` date;