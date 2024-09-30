**Description**: This query ranks products based on their list price in descending order.
use bikeshop; 

SELECT 
  order_id,
  item_id,
  list_price,
  quantity,
  RANK() OVER (ORDER BY list_price DESC) as ranking
FROM order_items
ORDER BY ranking;

**Description: This query calculates the net total revenue per month, factoring in discounts.

SELECT
  SUM(quantity * list_price * (1 - discount)) AS 'NetTotal',
  DATE_FORMAT(order_date, '%Y-%m') AS 'TransactionMonth'
FROM order_items
JOIN orders ON order_items.order_id = orders.order_id
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY DATE_FORMAT(order_date, '%Y-%m');

**Description: This query calculates the total revenue per month without discounts.

SELECT
  SUM(quantity * list_price) AS 'TotalRevenue',
  DATE_FORMAT(order_date, '%Y-%m') AS 'TransactionMonth'
FROM order_items
JOIN orders ON order_items.order_id = orders.order_id
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY DATE_FORMAT(order_date, '%Y-%m');

**Description: This query calculates the total revenue for each day.

SELECT
  SUM(quantity * list_price) AS 'TotalRevenue',
  DATE(order_date) AS 'TransactionDay'
FROM order_items
JOIN orders ON order_items.order_id = orders.order_id
GROUP BY DATE(order_date)
ORDER BY DATE(order_date);

**Description: This query calculates the net total revenue for each day, factoring in discounts.

SELECT
  SUM(quantity * list_price * (1 - discount)) AS 'Net_Total',
  DATE(order_date) AS 'TransactionDay'
FROM order_items
JOIN orders ON order_items.order_id = orders.order_id
GROUP BY DATE(order_date)
ORDER BY DATE(order_date);

**Description: This query counts the number of orders placed by each customer and groups the results by state.

SELECT COUNT(orders.order_id) AS order_count, orders.customer_id, customers.customer_id, customers.state
 FROM orders
 INNER JOIN customers ON orders.customer_id = customers.customer_id
 GROUP BY orders.customer_id, customers.state
 ORDER BY order_count DESC;

**Description: This query counts the number of orders placed by each customer without ordering by count.

SELECT COUNT(orders.order_id) , orders.customer_id, customers.customer_id, customers.state
 FROM orders
 INNER JOIN customers ON orders.customer_id = customers.customer_id
 GROUP BY orders.customer_id, customers.state;

**Description: This query counts the number of orders placed at each store.

SELECT COUNT(orders.order_id), orders.store_id, stores.store_name
 FROM orders
 INNER JOIN stores ON Orders.store_id=stores.store_id
 GROUP BY store_id, stores.store_name;

**Description: This query retrieves all products with a list price greater than 3000.

WITH high_price_products AS (
    SELECT *
    FROM order_items
    WHERE list_price > 3000
)
SELECT * FROM high_price_products;

**Description: This query counts the number of high-priced products (list price > 3000) available in each store.

WITH high_price_products AS (
    SELECT *
    FROM order_items
    WHERE list_price > 3000
)
SELECT store_name, COUNT(*) AS high_price_product_count
FROM high_price_products
GROUP BY store_name;

**Description: This query counts the number of order items per product.

SELECT Count(order_items.order_id) AS order_items, products.product_id, products.product_name, order_items.quantity
FROM order_items
JOIN products ON order_items.product_id = products.product_id
GROUP BY products.product_id, products.product_name, order_items.quantity
ORDER BY order_items DESC;
