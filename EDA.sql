/*
Database Exploration
To exploer the structure of the dataset and the columns of the tables
*/

-- Explore all tables in the dataset
SELECT * FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'gold';

-- Explore all columns in the tables;
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'gold';

-- Explore the column of customers' table
DESCRIBE gold.dim_customers;
 
 /*
 Dimension exploration; explorring categorical variables
 */
-- Exploring customers countries
SELECT DISTINCT country FROM gold.dim_customers;

-- Explore all the categoies in our products, order by the level of categories
SELECT DISTINCT category, subcategory, product_name FROM gold.dim_products
ORDER BY 1,2,3;

/*
Date exploration
*/
-- Identifying the boudnries (latest and earliest dates)
SELECT
 MIN(order_date) AS first_order_date, 
 MAX(order_date) AS last_order_date,
 TIMESTAMPDIFF(year, MIN(order_date), MAX(order_date)) AS order_range_years
 FROM gold.fact_sales;
  
-- Finding the oldest and youngest customers
 SELECT 
 MIN(birthdate) AS oldest_birthdate, 
 MAX(birthdate) AS youngest_birthdate,
 DATEDIFF(year, MAX(birthdate), GETDATE()) AS youngest_age
 FROM gold.dim_customers;

 
 /*
 Explore measures; doing some aggregattoins to obtain information
 */
 
 -- Find the total sales
 SELECT SUM(sales_amount) AS total_sales FROM gold.fact_sales;
 
 -- Find how many items are sold
 SELECT SUM(quantity) AS total_quantity FROM gold.fact_sales;
 
-- Find the average selling price
SELECT AVG(price) AS avg_price FROM gold.fact_sales;

-- Find the total number of orders, as an order may contain multiple items, we will use distinct
SELECT COUNT(DISTINCT order_number) AS total_orders FROM  gold.fact_sales;

-- Find the total number of products
SELECT COUNT(product_key) AS total_products FROM gold.dim_products;

-- Find the total number of customers
SELECT COUNT(customer_key) AS total_customer FROM gold.dim_customers;

-- Total number of customers placed an order
 SELECT COUNT(DISTINCT customer_key) AS total_customers FROM gold.fact_sales;
 
 -- Generate a report that shows all key metrics  
 SELECT 'Total Sales' AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
 UNION ALL
 SELECT 'Total Quantity', SUM(quantity) FROM gold.fact_sales
 UNION ALL
 SELECT 'Average Price', AVG(price) FROM gold.fact_sales
 UNION ALL
 SELECT 'Total No. Orders', COUNT(DISTINCT order_number) FROM gold.fact_sales
 UNION ALL
 SELECT 'Total No. Products', COUNT(product_name) FROM gold.dim_products
 UNION ALL
 SELECT 'Total No. Customers', COUNT(customer_key) FROM gold.dim_customers;
 
 /*
 Magnitude analysis; compare different measures by categories
 */
 
 -- Find total customers by countries
 SELECT 
 country,
 COUNT(customer_key) AS total_customers
 FROM gold.dim_customers
 GROUP BY country
 ORDER BY total_customers DESC;
 
 -- Find total customers by gender
 SELECT 
 gender, 
 COUNT(customer_key) AS total_customers
 FROM gold.dim_customers
 GROUP BY gender
 ORDER BY total_customers DESC;
 
 -- Find total products by category
 SELECT
 category,
 COUNT(product_key) AS total_products
 FROM gold.dim_products
 GROUP BY category
 ORDER BY total_products DESC;
 
 -- Average cost in each category
 SELECT 
 category,
 AVG(cost) AS avg_costs
 FROM gold.dim_products
 GROUP BY category
 ORDER BY avg_costs DESC;
 
 -- Total revenue generated for each category
 SELECT
 p.category,
 SUM(f.sales_amount) total_revenue
 FROM gold.fact_sales f
 LEFT JOIN gold.dim_products p
 ON p.product_key = f.product_key
 GROUP BY p.category
 ORDER BY total_revenue DESC;
 
 -- Total revenue spent by each customr,  top spenders
 SELECT 
 c.customer_key,
 c.first_name,
 c.last_name,
 SUM(f.sales_amount) AS total_revenue
 FROM gold.fact_sales f
 LEFT JOIN gold.dim_customers c
 ON c.customer_key = f.customer_key 
 GROUP BY 
 c.customer_key,
 c.first_name,
 c.last_name
 ORDER BY total_revenue DESC;
 
 -- The distribution of sold items across countries, as the number of dimensions is low they are low cardinality dimensions
 SELECT 
 c.country,
 SUM(f.quantity) AS total_sold_items
 FROM gold.fact_sales f
 LEFT JOIN gold.dim_customers c
 ON c.customer_key = f.customer_key 
 GROUP BY c.country
 ORDER BY total_sold_items DESC;
 
 /*
 Ranking analysis; 1.group by 2.window function
 */
 -- Which 5 products made the highest revenue
 SELECT 
 p.product_name,
 SUM(f.sales_amount) total_revenue
 FROM gold.fact_sales f
 LEFT JOIN gold.dim_products p
 ON p.product_key = f.product_key
 GROUP BY p.product_name 
 ORDER BY total_revenue DESC
 LIMIT 5;
 
 -- 5 products made the worst revenue
 SELECT
 p.product_name,
 SUM(f.sales_amount) total_revenue
 FROM gold.fact_sales f
 LEFT JOIN gold.dim_products p
 ON p.product_key = f.product_key
 GROUP BY p.product_name
 ORDER BY total_revenue
 LIMIT 5;
 
 
 
 
 
 
 
 
 
 
 
 



