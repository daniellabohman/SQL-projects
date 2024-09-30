**Description: This query retrieves the dates of the first and last transactions recorded in the sales data.

SELECT 
    MIN(transaction_date) AS FirstTransaction,
    MAX(transaction_date) AS LastTransaction
FROM 
    `coffee-shop-sales`;

**Description: This query ranks product details within each product type based on their details in descending order.

SELECT product_type, product_detail, dense_rank() 
OVER ( partition by product_type order by product_detail desc ) 
AS 'product_detail_rank' 
FROM `coffee-shop-sales`;

**Description: This query calculates total revenue for each store, grouped by transaction date and store ID.

SELECT
  SUM(transaction_qty * unit_price) AS 'TotalRevenue',
  DATE(transaction_date) AS 'TransactionDay',
  store_id AS 'Store'
FROM `coffee-shop-sales`
GROUP BY DATE(transaction_date), store_id
ORDER BY DATE(transaction_date), store_id;

**Description: This query counts the number of transactions for each store, sorted by transaction count in descending order.

SELECT 
    COUNT(transaction_id) AS transactions, 
    store_id AS store_id
FROM 
    `coffee-shop-sales`
GROUP BY 
    store_id
ORDER BY 
    transactions DESC;

**Description: This query calculates total revenue for a specific store (store ID = "8").

SELECT 
    SUM(transaction_qty * unit_price) AS TotalRevenue, 
    store_id AS store_id
FROM 
    `coffee-shop-sales`
    WHERE store_id = "8"
    
GROUP BY 
    store_id;

**Description: This query retrieves distinct unit prices along with the minimum and maximum unit prices.

SELECT DISTINCT unit_price ,
MIN(unit_price) AS min_unitprice,
MAX(unit_price) AS max_unitprice
FROM `coffee-shop-sales`
GROUP BY unit_price
ORDER BY min_unitprice;


**Description: This query calculates total revenue by month for each store.

SELECT 
    SUM(transaction_qty * unit_price) AS TotalRevenue, 
    DATE_FORMAT(transaction_date, '%Y-%m') AS month_,
    store_id AS store_id
FROM 
    `coffee-shop-sales`
GROUP BY 
    store_id, 
    DATE_FORMAT(transaction_date, '%Y-%m')
ORDER BY 
    TotalRevenue DESC;

**Description: This query counts products grouped by category and type, using the WITH ROLLUP modifier for subtotals.

SELECT COUNT(*), product_category, product_type
  FROM `coffee-shop-sales`
  GROUP BY product_category, product_type WITH ROLLUP;

**Description: This query counts the number of products that fall into high and low price categories based on unit price.
****Description: This query calculates a cumulative sum of transaction counts over time.

SELECT product_id,
COUNT(CASE WHEN unit_price > 10 THEN 1 END) AS high_price,
COUNT(CASE WHEN unit_price <= 10 THEN 1 END) AS low_price
FROM `coffee-shop-sales`
GROUP BY product_id;

with data as (
  select
    date(transaction_date) as day_,
    count(transaction_id) as transaction_count
  from `coffee-shop-sales`
  group by day_
)

select
  day_,
  transaction_count,
  sum(transaction_count) over (order by day_) as cumulative_sum
from data;

**Description: This query retrieves all products with a unit price greater than 15.

WITH high_price_products AS (
    SELECT *
    FROM `coffee-shop-sales`
    WHERE unit_price > 15
)
SELECT * FROM high_price_products;

Description: This query counts the number of high-priced products available at each store location.

WITH high_price_products AS (
    SELECT *
    FROM `coffee-shop-sales`
    WHERE unit_price > 15
)
SELECT store_location, COUNT(*) AS high_price_product_count
FROM high_price_products
GROUP BY store_location;