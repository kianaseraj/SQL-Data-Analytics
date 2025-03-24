/*
===============================================================================
Churn Report
===============================================================================
Purpose:
    - This report consolidates features contributing to customer's subscription terimination, churn.
    three features of: Customer demographics, Billing methods and Services

Highlights:
    1. Gathers essential fields such as names, ages, and transaction details.
	2. Segments customers into categories (VIP, Regular, New) and marital groups.
    3. Aggregates customer-level metrics:
	   - total orders
	   - total sales
	   - total quantity purchased
	   - total products
	   - lifespan (in months)
    4. Calculates valuable KPIs:
	    - recency (months since last order)
		- average order value
		- average monthly spend
===============================================================================
*/

-- =============================================================================
-- Create Report: report_churn
-- =============================================================================


use DataWarehouseAnalytics;
select * from gold.report_customers;