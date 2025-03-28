📊 Sales Analysis Using MySQL

📝 Overview
This project explores and analyzes a sales dataset using SQL, focusing on key performance indicators (KPIs), customer behavior, product trends, and temporal patterns. The aim is to demonstrate the power of structured queries for business insight extraction and to practice a wide range of analytical techniques in SQL.

The analysis touches upon various areas including trend analysis, segmentation, comparative performance, ranking, and part-to-whole contributions — mimicking what real-world data analysts do for business dashboards and reporting.

[Tableau Dahboard](https://public.tableau.com/app/profile/kianaseraj/viz/first_dashboard_17419718005270/SalesDashboard)


🗃️ Dataset Structure
The database contains the following key tables:

fact_sales: transactional sales data (order date, sales amount, quantity, customer/product references)

dim_customers: customer demographics and details

dim_products: product metadata including category, subcategory, cost

Views (reports): report_products, report_customers

Metadata accessed via INFORMATION_SCHEMA for structure exploration

❓ Key Business Questions Answered
📅 Trend & Time-Based Analysis
How has sales performance evolved year-over-year?

What seasonal patterns exist in monthly sales?

How is cumulative revenue growing over time?

📈 Product & Category Analysis
Which products perform the best or worst in revenue and sales volume?

How does each category contribute to total sales?

What is the average cost across categories?

👥 Customer Insights
Who are our VIP, Regular, or New customers?

How do customers' purchase patterns differ across age groups or countries?

What are the recency, frequency, and monetary (RFM) behaviors?

📦 Inventory & Sales Distribution
What is the distribution of products by cost range?

How are products selling across different countries?

🔢 Magnitude & Performance Metrics
What are the total sales, quantity, and number of orders?

What is the average selling price?

How many unique products and customers do we have?

🏆 Ranking Analysis
What are the top 5 and bottom 5 products in terms of revenue and quantity sold?



📑 Summary Reports
📌 report_products
A structured view of product-level KPIs.

Purpose: Summarize product behavior and segment performance

Metrics:

Total orders, sales, quantity, customers

Product lifespan

Recency (months since last sale)

Average Order Revenue (AOR)

Average Monthly Revenue

Segmentation:

Revenue-based performance: High-Performer, Mid-Range, Low-Performer

📌 report_customers
A comprehensive customer view for behavioral and demographic segmentation.

Purpose: Profile customer engagement and spending

Metrics:

Total orders, products, quantity, sales

Recency, lifespan, AOV (Average Order Value), Avg. Monthly Spend

Segmentation:

Lifecycle segments: VIP, Regular, New

Age groups: Under 20, 20-29, 30-39, etc.




🛠️ Tools & Skills Used
SQL (MySQL dialect)

Aggregation & Filtering

CTEs and Views

Window Functions: LAG, AVG OVER, SUM OVER

Date Functions: DATE_FORMAT, TIMESTAMPDIFF, MIN/MAX

Segmentation and Case Logic
