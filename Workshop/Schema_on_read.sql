
// Step 1 Create table

USE ROLE ACCOUNTADMIN;
USE WAREHOUSE COMPUTE_WH;
use database DEMO_DB;
use schema PUBLIC;

CREATE OR REPLACE TABLE JSON_TABLE
(
  File_TS timestamp default current_timestamp(),
  File_NM VARCHAR,
  FILE_VARIANT VARIANT 
  
);


// Step 2 Create stage

create or replace stage my_s3_stage url='s3://csv.json/uploads/output/'
credentials=(aws_key_id='my_aws_key' aws_secret_key='my_aws_sercret_key')
file_format = JSON_FORMAT;

// Step 3 Create pipe

create or replace pipe pipe_json auto_ingest=true as
copy into JSON_TABLE(FILE_NM,FILE_VARIANT)
from (select metadata$filename, *  from @my_s3_stage)
pattern='.*.json';

// Show your pipes, 

show pipes;

//Note: Copy the notification_channel value to copy into your S3 bucket SQS (Amazon Simple Queue/Messaging Service) event notification
//so that the S3 bucket notifies Snowflake about a file

// Step 4 View my JSON table

select *
from "DEMO_DB"."PUBLIC"."JSON_TABLE_2"
order by FILE_TS desc;

// Step 5 create my table or view

create or replace view Result_view as
select
c.value:"  Climatescope Score (Decimal)"::VARCHAR as Clima_Score,
c.value:"Geography"::VARCHAR as Geo,
c.value:"Rank"::int as Rank,
c.value:"Region"::VARCHAR as Region
from JSON_TABLE_2
,lateral flatten(input => FILE_VARIANT) c
where FILE_NM='uploads/output/2022/03/01/CLIMATESCOPE 2021 GLOBAL RANKING.csv_223315.json';


create or replace view Result_view as
select
c.value:"Country/area"::VARCHAR as Country,
c.value:"Public Investments (2019 million USD)"::VARCHAR as Investments
from JSON_TABLE_2
,lateral flatten(input => FILE_VARIANT) c
where FILE_NM='uploads/output/2022/03/01/PUBFIN_Public_Energy_Investments_2000_2020.json';


select * 
from "DEMO_DB"."PUBLIC"."RESULT_VIEW"
where COUNTRY='Costa Rica';