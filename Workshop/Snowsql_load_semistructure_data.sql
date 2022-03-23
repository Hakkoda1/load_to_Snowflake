
// 1. Create table

USE ROLE ACCOUNTADMIN;
USE WAREHOUSE COMPUTE_WH;
USE DATABASE DEMO_LOAD;
USE SCHEMA PUBLIC;

CREATE OR REPLACE TABLE JSON_TABLE
(
  FILE_VARIANT VARIANT 
);


// 2.Create file format

create or replace file format JSON_FORMAT
type = json;

// 3.Query my results

create or replace view Result_iris as
select 
c.value:petal_length::numeric(38,2) as p_length,
c.value:petal_width::float as p_width,
c.value:sepal_length::int as s_length
from JSON_TABLE
,lateral flatten(input => FILE_VARIANT) c;



//Note: By default, precision is 38 and scale is 0 (i.e. NUMBER(38, 0)). Note that precision limits the range of 
//values that can be inserted into (or cast to) columns of a given type. For example, the value 999 fits into NUMBER(38,0) but not into NUMBER(2,0).
//The maximum scale (number of digits to the right of the decimal point) is 37. 


drop table SNOWSQL_JSON_TABLE;
drop table JSON_TABLE;
