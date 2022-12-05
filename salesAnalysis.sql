SELECT 
  * 
FROM 
  SalesAnalysis.inputdata;
/* 1. let s create culomn for year and month from date date culomn*/
select 
  *, 
  day(
    STR_TO_DATE(date, '%m/%d/%Y')
  ) as day, 
  Month(
    STR_TO_DATE(date, '%m/%d/%Y')
  ) as Month, 
  year(
    STR_TO_DATE(date, '%m/%d/%Y')
  ) as Year 
from 
  SalesAnalysis.inputdata;
/*2. let s join the two tables*/
SELECT 
  *, 
  DAY(
    STR_TO_DATE(date, '%m/%d/%Y')
  ) AS day, 
  MONTH(
    STR_TO_DATE(date, '%m/%d/%Y')
  ) AS Month, 
  YEAR(
    STR_TO_DATE(date, '%m/%d/%Y')
  ) AS Year 
FROM 
  SalesAnalysis.inputdata AS md 
  JOIN SalesAnalysis.masterdata AS id ON md.PRODUCT_ID = id.PRODUCT_ID;
/*3. add new column for total buying values and total selling value*/
select 
  *, 
  (QUANTITY * BUYING_PRIZE) as Total_Buying_Value, 
  (QUANTITY * SELLING_PRICE) * (1 - DISCOUNT) as Total_Selling_Value 
from 
  SalesAnalysis.inputdata as md 
  join SalesAnalysis.masterdata as id on md.PRODUCT_ID = id.PRODUCT_ID;
/* 4. create mesure for profit and profit%*/
with total as (
  select 
    sum(QUANTITY * BUYING_PRIZE) as totalbuying, 
    sum(
      (QUANTITY * SELLING_PRICE) * (1 - DISCOUNT)
    ) as totalselling 
  from 
    SalesAnalysis.inputdata as md 
    join SalesAnalysis.masterdata as id on md.PRODUCT_ID = id.PRODUCT_ID
) 
select 
  (totalselling - totalbuying) as profit, 
  (
    (totalselling - totalbuying)/ totalbuying
  )* 100 as profit_poutage 
from 
  total;
