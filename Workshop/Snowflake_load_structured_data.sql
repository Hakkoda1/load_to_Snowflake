// 1. Select the right warehouse, create database and use the database

USE WAREHOUSE COMPUTE_WH;
CREATE DATABASE IF NOT EXISTS DEMO_LOAD;
USE DATABASE DEMO_LOAD;
USE SCHEMA PUBLIC;

// 2. Create the table structure

CREATE OR REPLACE TABLE IRIS
(
  sepal_length NUMERIC(38,1),
  sepal_width NUMERIC,
  petal_length NUMERIC,
  petal_width NUMERIC, 
  species VARCHAR
);


//3. Create file format

create or replace file format mycsvformat
  type = 'CSV'
  field_delimiter = ','
  skip_header = 1;



// 3. Load the data into the table using the menu

//4. Query results

select * from "DEMO_LOAD"."PUBLIC"."IRIS";

//4. Delete table

drop table IRIS;
drop table Orders;
drop table MY_TABLE;
drop table Structure_tbl;
drop view result_iris;

//Note: By default, precision is 38 and scale is 0 (i.e. NUMBER(38, 0)). Note that precision limits the range of 
//values that can be inserted into (or cast to) columns of a given type. For example, the value 999 fits into NUMBER(38,0) but not into NUMBER(2,0).
//The maximum scale (number of digits to the right of the decimal point) is 37. 


