#  Sales Analysis Using SQL

###  Overview

This project presents an in-depth analysis of a sales dataset using **pure SQL**, focusing on key performance indicators (KPIs), customer behavior, product trends, and time-based insights. The goal is to demonstrate the power of structured queries in uncovering business insights and to showcase a wide range of analytical techniques commonly used in real-world dashboards and business reporting.

The analysis includes trend detection, segmentation, ranking, comparative performance, and part-to-whole contributions—mimicking what professional data analysts do when supporting decision-makers.

---

###  Interactive Tableau Dashboard

Explore the interactive **Tableau Dashboard** built on top of SQL queries and views designed during this project:

👉 [**View Live Dashboard**](https://public.tableau.com/app/profile/kianaseraj/viz/SalesDashboard_17433614085850/SalesDashboard)

#### The dashboard includes:

- **Sales Overview**
  - Total Sales, Profit, and Quantity for 2023
  - Percentage change vs. 2022
  - Highlighted Max/Min months for each KPI

- **Sales & Profit by Subcategory**
  - Horizontal bar chart comparing 2023 vs. 2022
  - Color-coded profit vs. loss per subcategory

- **Sales & Profit Over Time**
  - Monthly trends for sales and profit
  - Segmentation of above vs. below average months
  - Annotations for key benchmarks (e.g., Avg. $14K/month)

---

###  Dataset Structure

The SQL database includes the following key tables:

- `fact_sales`: Transactional sales data (order date, sales, quantity, product/customer keys)
- `dim_customers`: Customer demographics and details
- `dim_products`: Product metadata (category, subcategory, cost)

Plus, two custom views for reporting:

- `report_products`
- `report_customers`

*Note:* Metadata was explored using `INFORMATION_SCHEMA`.

---

###  Key Business Questions Answered

####  **Trend & Time-Based Analysis**
- How has sales performance evolved year-over-year?
- What seasonal patterns are visible in monthly sales?
- How is cumulative revenue growing over time?

####  **Product & Category Analysis**
- Which products are top or low performers in revenue and volume?
- How do different categories contribute to total sales?
- What’s the average cost across product categories?

####  **Customer Insights**
- Who are our VIP, Regular, or New customers?
- How do purchasing behaviors differ by age or country?
- What are the RFM (Recency, Frequency, Monetary) metrics?

####  **Inventory & Sales Distribution**
- What’s the cost distribution of products?
- How do sales differ across countries?

####  **Magnitude & Performance Metrics**
- What are the total sales, quantity, and order count?
- What is the average selling price?
- How many unique products and customers are there?

####  **Ranking Analysis**
- What are the top 5 and bottom 5 products by revenue and quantity sold?

---

###  Summary Reports

#### **report_products**
A product-level summary report for performance evaluation and segmentation.

**Purpose:** Understand product behavior and trends.

**Metrics:**
- Total orders, sales, quantity, number of customers
- Product lifespan
- Recency (months since last sale)
- AOR (Average Order Revenue)
- Average Monthly Revenue

**Segmentations:**
- Revenue-based:
  - High-Performer
  - Mid-Range
  - Low-Performer

---

#### **report_customers**
A comprehensive customer view for behavioral and demographic profiling.

**Purpose:** Analyze engagement and customer value.

**Metrics:**
- Total orders, products purchased, quantity, total sales
- Recency, customer lifespan, AOV (Average Order Value)
- Average Monthly Spend

**Segmentations:**
- Lifecycle:
  - VIP
  - Regular
  - New
- Age Groups:
  - Under 20
  - 20–29
  - 30–39
  - etc.

---

###  Tools & Skills Used

- **SQL (MySQL dialect)**
- Aggregations & Filtering
- **CTEs & Views**
- **Window Functions** (`LAG`, `AVG OVER`, `SUM OVER`)
- **Date Functions** (`DATE_FORMAT`, `TIMESTAMPDIFF`, `MIN/MAX`)
- Conditional Logic & Segmentation (`CASE`, nested logic)
