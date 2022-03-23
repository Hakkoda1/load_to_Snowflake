
# Load structure data using Snowsql

## Login and create table

### 1. Open Terminal 

snowsql -a [your_account] -u [user_name]

for example: snowsql -a yd64022.us-east-2.aws -u [user_name]

### 2. Introduce your password


### 3.Verify that your current role is set to AccountAdmin :

SELECT CURRENT_ROLE();

### 4.   Create a table if you hadn’t already in your database. But if not we’ll create it now:


USE WAREHOUSE COMPUTE_WH;
CREATE DATABASE IF NOT EXISTS DEMO_LOAD;
USE DATABASE DEMO_LOAD;

CREATE OR REPLACE TABLE SNOWSQL_JSON_TABLE
(
  FILE_VARIANT VARIANT 
);

### 5.   Insert the following three rows into the table you created earlier:


create or replace file format SNOW_SQL_JSON_FORMAT
type = json;

### 6.   Insert several more rows using a single INSERT INTO statement:


insert into SNOWSQL_JSON_TABLE 
    select to_variant(parse_json('[{
        "sepal_length": "5.1",
        "sepal_width": "3.5",
        "petal_length": "1.4",
        "petal_width": "0.2",
        "species": "setosa"
    }],'));

### 7.   Query the data in ORDERS and order it by ID:


SELECT * FROM SNOWSQL_JSON_TABLE;

### 7. Create a table from the Json file

select 
c.value:petal_length::numeric(38,2) as p_length,
c.value:petal_width::float as p_width,
c.value:sepal_length::int as s_length
from SNOWSQL_JSON_TABLE
,lateral flatten(input => FILE_VARIANT) c;

### 9.  Exit the SnowSQL interface:


!exit
 
## Assignnment

### 1. Repeat the process but load the data from a file in your computer. Hint: Use the "Put" command
