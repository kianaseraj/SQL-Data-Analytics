/* Crating database and shemas
Purpose: 
The script creates new database named 'DataWarehouse' with a schema, called 'gold'.
*/


-- Create 'DataWarehouseAnaalytics' database
CREATE DATABASE DataWarehouseAnalytics;

-- Create schemas
CREATE SCHEMA gold;

-- Create a table named dim_customers
CREATE TABLE gold.dim_customers(
	customer_key int,
    customer_id int,
    customer_number nvarchar(50),
    first_name nvarchar(50),
    last_name nvarchar(50),
    country nvarchar(50),
    marital_status nvarchar(50),
    gender nvarchar(50),
    birthdate date,
    create_date date
);
-- Create a table named fact_sales
CREATE TABLE gold.fact_sales(
	order_number nvarchar(50),
	product_key int,
	customer_key int,
	order_date date,
	shipping_date date,
	due_date date,
	sales_amount int,
	quantity tinyint, 
	price int
);

-- Create table named dim_products
CREATE TABLE gold.dim_products(
	product_key int ,
	product_id int ,
	product_number nvarchar(50) ,
	product_name nvarchar(50) ,
	category_id nvarchar(50) ,
	category nvarchar(50) ,
	subcategory nvarchar(50) ,
	maintenance nvarchar(50) ,
	cost int,
	product_line nvarchar(50),
	start_date date 
);

-- Remove all rows of the table
TRUNCATE TABLE gold.dim_customers;

-- Import data from a text file into the empty table
LOAD DATA LOCAL INFILE '/PATH/to/gold.dim_customers.csv'
INTO TABLE gold.dim_customers
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

TRUNCATE TABLE gold.fact_sales;


LOAD DATA LOCAL INFILE '/PATH/to/gold.fact_sales.csv'
INTO TABLE gold.fact_sales
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES; 

TRUNCATE TABLE gold.dim_products;

LOAD DATA LOCAL INFILE '/PATH/to/gold.dim_products.csv'
INTO TABLE gold.dim_products
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;


