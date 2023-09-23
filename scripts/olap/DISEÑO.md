# Diseño de la Bodega de datos

## Alquiler

**NORA:** LLave surrogada es una llave diseñada para ser lo mas rapido posible
- un numero, pequeño, con cierto orden
- no va a cambiar a pesar que la llave del negocio luego cambie

**Dim_Tiempo**
|Columna        |Tipo       |Restricciones  |
|-----------    |-------    |---------------|
|date_key       |int        |PK,NN          |
|date_value     |date       |NN             |
|month_number   |int        |NN             |
|month_name     |char(12)   |NN             |
|year4          |int        |NN             |
|day_of_week    |int        |NN             |
|day_of_week_nam|char(12)   |NN             |

**Dim_Store**
|Columa         |Tipo             |Restricciones            |
|---------------|-----------      |---------------          |
|store_key      |int              |PK,NN, AI                |
|store_id       |tinyint unsigned |UK,NN                    |
|store          |varchar(20)      |NN                       |
|district       |varchar(20)      |NN                       |
|city           |varchar(50)      |NN                       |
|country        |varchar(50)      |NN                       |
|last_update    |timestamp        |NN, default CURRENT_TS   |

**Dim_Customer**
|Columa         |Tipo             |Restricciones            |
|---------------|-----------      |---------------          |
|customer_key   |int              |PK,NN, AI                |
|customer_id    |tinyint unsigned |UK,NN                    |
|customer       |varchar(20)      |NN                       |
|district       |varchar(20)      |NN                       |
|city           |varchar(50)      |NN                       |
|country        |varchar(50)      |NN                       |
|last_update    |timestamp        |NN, default CURRENT_TS   |


**Fact_Alquiler**
|Columna        |Tipo       |Restricciones      |
|-----------    |-------    |---------------    |
|rental_key     |int(8)     |PK,NN              |
|rental_id      |int        |UK,NN              |
|date_key       |int        |FK(dim_date), NN   |
|count_rental   |int        |NN                 |

