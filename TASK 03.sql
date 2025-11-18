USE mydb;
SELECT customer_id, customer_name, city
FROM customers
LIMIT 10;
SELECT *
FROM orders
WHERE YEAR(order_date) = 2019;
SELECT o.order_id, SUM(oi.sales) AS order_total
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id
ORDER BY order_total DESC
LIMIT 10;
SELECT p.category,
       SUM(oi.sales) AS total_sales,
       COUNT(DISTINCT o.order_id) AS orders_count
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id
GROUP BY p.category
ORDER BY total_sales DESC;
		SELECT p.category, COUNT(DISTINCT oi.order_id) AS orders_count, SUM(oi.sales) AS sales
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
HAVING orders_count > 50
ORDER BY sales DESC;
SELECT oi.order_id,
       c.customer_name,
       p.product_name,
       oi.quantity,
       oi.sales
FROM order_items oi
INNER JOIN orders o ON oi.order_id = o.order_id
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN products p ON oi.product_id = p.product_id
LIMIT 50;
SELECT p.product_name AS Product, SUM(oi.profit) AS TotalProfit
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY TotalProfit DESC
LIMIT 5;
SELECT YEAR(o.order_date) AS yr,
       MONTH(o.order_date) AS mn,
       SUM(oi.sales) AS revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY yr, mn
ORDER BY yr DESC, mn DESC;
SELECT order_id,
       order_date,
       ship_date,
       DATEDIFF(ship_date, order_date) AS days_to_ship
FROM orders
WHERE ship_date IS NOT NULL
ORDER BY days_to_ship DESC
LIMIT 20;
-- top customers this year: total sales, orders count, average order value
SELECT c.customer_id,
       c.customer_name,
       COUNT(DISTINCT o.order_id) AS orders_count,
       SUM(oi.sales) AS total_sales,
       ROUND(SUM(oi.sales)/COUNT(DISTINCT o.order_id),2) AS avg_order_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE YEAR(o.order_date) = YEAR(CURDATE())
GROUP BY c.customer_id, c.customer_name
HAVING orders_count > 1
ORDER BY total_sales DESC
LIMIT 20;









