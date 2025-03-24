/*
 Change over time, trend analysis
 */

-- Considering the fact table, as we have the dates and measures there! analyzing sales performance over time
SELECT
YEAR(order_date) AS order_year,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) AS total_customer, 
SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date) 
ORDER BY YEAR(order_date);

-- Seasonal pattern of the business
SELECT
MONTH(order_date) AS order_month,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) AS total_customer,
SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY MONTH(order_date)
ORDER BY MONTH(order_date);

/* 
cumulative analysis; aggregate the data progressively over time helps to understand how our business is growing or declining over time
*/

-- calculate the total sales per monnth 
SELECT
DATE_FORMAT(order_date, '%Y-%m-01') AS order_date,
SUM(sales_amount) AS total_sales
FROM gold.fact_sales	
WHERE order_date IS NOT NULL
GROUP BY DATE_FORMAT(order_date, '%Y-%m-01')
ORDER BY DATE_FORMAT(order_date, '%Y-%m-01');

-- finding running total sales over time
SELECT 
	order_date,
	total_sales,
	SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales
FROM 
(
	SELECT
	DATE_FORMAT(order_date, '%Y-%m-01') AS order_date,
	SUM(sales_amount) AS total_sales
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY DATE_FORMAT(order_date, '%Y-%m-01')
) AS sales_summery;


/*
Analyzing the yearly performance of products by comparing each product's sale to both its average sales prformance and the previous year's sales
*/

-- comparing currrent sales with yearly average sales and previous year's sales:
-- CTE; Current sales
WITH yearly_prorduct_sales AS (
SELECT 
YEAR(f.order_date) AS order_year,
p.product_name, 
SUM(f.sales_amount) AS current_sales
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_products AS p
ON f.product_key = p.product_key
WHERE f.order_date IS NOT NULL
GROUP BY
YEAR(f.order_date),
p.product_name
)
SELECT
order_year,
product_name,
current_sales,
AVG(current_sales) OVER (PARTITION BY product_name) AS avg_sales,
current_sales - AVG(current_sales) OVER (PARTITION BY product_name) diff_avg,
CASE WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) > 0 THEN 'Above avg'
	WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) < 0 THEN 'Below avg'
	ELSE 'avg'
END avg_change,
LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS py_sales,
current - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) diff_py,
CASE WHEN current - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) > 0 THEN 'Increase'
	WHEN current - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) < 0 THEN 'Decrease'
    ELSE 'No Change'
END py_change
FROM yearly_product_sales
ORDER BY product_name, oder_year;

/*
part to whole analysis; how one category contributes to the others.
*/

-- Which categories contributes to the overal sales the most
WITH category_sales AS (
SELECT
category,
SUM(sales_amount) total_sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p 
ON p.product_key = f.product_key
GROUP BY category)
SELECT 
category, 
total_sales,
SUM(total_sales) OVER() AS overall_sales,
CONCAT(ROUND((CAST(total_sales AS FLOAT) / SUM(total_sales) OVER())* 100,2),'%') AS percentage_of_total
FROM category_sales
ORDER BY total_sales DESC;


/*
Data segmentation; group data based on a specific range.
*/

-- Segment products into cost ranges and count how many products fall into each segment
WITH product_segments AS ( 
SELECT 
product_key, 
product_name,
cost, 
CASE WHEN cost < 100 THEN 'Below 100'
	WHEN cost BETWEEN 100 AND 500 THEN '100-500'
    WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'
    ELSE 'Above 1000'
END cost_range
FROM gold.dim_products)
SELECT
cost_range,
COUNT(product_key) AS total_products
FROM product_segments
GROUP BY cost_range
ORDER BY total_products DESC;

/*
Group customers into three segments based on their spending behavior:
	- VIP: Customers with at least 12 months of history and spending more than $5000.
    - Regular: Customers witht at least 12 months of history but spending $5000 or less.
    - New: Custerms with a lifespan less than 12 months.
And find the total number of customers by each group.
*/
WITH customer_spending AS (
SELECT 
c.customer_key,
SUM(f.sales_amount) AS total_spending,
MIN(order_date) AS first_order,
MAX(order_date) AS last_order,
TIMESTAMPDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON f.customer_key = c.customer_key
GROUP BY c.customer_key
)
SELECT
customer_segment,
COUNT(customer_key) AS total_customers
FROM(
	SELECT
	customer_key,
	total_spending,
	lifespan,
	CASE WHEN lifespan >= 12 AND total_spending > 5000 THEN 'VIP'
		WHEN lifespan >= 12 AND total_spending <= 5000 THEN 'Regular'
		ELSE 'New'
	END customer_segment
	FROM customer_spending)t
GROUP BY customer_segment
ORDER BY total_customers DESC 







 