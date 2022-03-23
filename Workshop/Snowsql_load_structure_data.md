
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

CREATE OR REPLACE TABLE DEMO_LOAD.PUBLIC.MY_TABLE (
id NUMBER(38,0),
name STRING(10),
country VARCHAR(20),
order_date DATE);

### 5.   Insert the following three rows into the table you created earlier:


INSERT INTO MY_TABLE VALUES(2, 'A','UK', '11/02/2005');
INSERT INTO MY_TABLE VALUES(4, 'C','SP', '11/02/2005');
INSERT INTO MY_TABLE VALUES(3, 'C','DE', '11/02/2005');

### 6.   Insert several more rows using a single INSERT INTO statement:


INSERT INTO MY_TABLE
VALUES(1, 'ORDERC007', 'JAPAN', '11/02/2005'),
(7, 'ORDERF821', 'UK', '11/03/2005'),
(12, 'ORDERB029', 'USA', '11/03/2005');

### 7.   Query the data in MY_TABLE and order it by ID:


SELECT * FROM MY_TABLE ORDER BY id;


## 11   Run a Script in SnowSQL

### 1.   Create a file called script.sql using a text editor that contains the following:


USE ROLE ACCOUNTADMIN;
USE WAREHOUSE COMPUTE_WH;
USE DATABASE DEMO_LOAD;
USE SCHEMA PUBLIC;
SELECT * FROM MY_TABLE;

### 2.   Return to Terminal, pass it your script (-f), and supply your password when requested:


snowsql -a yd64022.us-east-2.aws -u [user_name] -f Files/script.sql

 NOTE: You must either be in the same location as your script when you run it, or you must provide the full path to the script.

### 3.   You will see your output and then SnowSQL will exit.


### 9.  Exit the SnowSQL interface:


!exit
 
## Assignnment

### 1. Repeat the process but load the data from a file in your computer. Hint: Use the "Put" command