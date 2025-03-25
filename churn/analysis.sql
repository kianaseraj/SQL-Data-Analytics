use ChurnAnalytics;

SELECT * FROM churn_data;

DESC churn_data;


-- table info
SELECT * FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'churn_data';

-- columns info
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'churn_data';

/*
Dimension exploration
*/

-- payment types:
SELECT DISTINCT PaymentMethod FROM churn_data;

-- contradct types
SELECT DISTINCT Contract FROM churn_data;

-- Internt service types
SELECT DISTINCT InternetService FROM churn_data;

/*
Explore measures
*/

-- An overview of data distribution
SELECT 
    COUNT(*) AS total_customers,
    AVG(tenure) AS avg_tenure,
    MAX(tenure) AS max_tenure,
    MIN(tenure) AS min_tenure,
    STDDEV(tenure) AS std_tenure,

    AVG(MonthlyCharges) AS avg_monthly_charge,
    MAX(MonthlyCharges) AS max_monthly_charge,
    MIN(MonthlyCharges) AS min_monthly_charge,
    STDDEV(MonthlyCharges) AS std_monthly_charge,

    AVG(TotalCharges) AS avg_total_charge,
    MAX(TotalCharges) AS max_total_charge,
    MIN(TotalCharges) AS min_total_charge,
    STDDEV(TotalCharges) AS std_total_charge
FROM churn_data;


-- Dist analysis;how customers are distributed based on their tenure
SELECT  COUNT(*) AS customer_count, tenure 
FROM churn_data
GROUP BY tenure
ORDER BY customer_count DESC;

-- customer demographics
SELECT 
'Male' AS 'Demographic category',
SUM(CASE WHEN gender = 'Male' THEN 1 ELSE 0 END)/COUNT(*) AS percecntage
FROM churn_data
UNION ALL

SELECT 
'SeniorCitizen',
SUM(CASE WHEN SeniorCitizen = 1 THEN 1 ELSE 0 END)/COUNT(*)
FROM churn_data
UNION ALL

SELECT
'Partner',
SUM(CASE WHEN Partner = 'Yes'THEN 1 ELSE 0 END)/COUNT(*)
FROM churn_data; 



-- billing information
SELECT
'PaperlessBilling' AS 'category',
SUM(CASE WHEN PaperlessBilling = 'Yes' THEN 1 ELSE 0 END)/COUNT(*) AS Percentage
FROM churn_data
UNION ALL

SELECT
'Electronic check payment',
SUM(CASE WHEN PaymentMethod = 'Electronic check' THEN 1 ELSE 0 END )/COUNT(*) 
FROM churn_data
UNION ALL

SELECT
'Bank transfer payment',
SUM(CASE WHEN PaymentMethod = 'Bank transfer (autom' THEN 1 ELSE 0 END )/COUNT(*) 
FROM churn_data
UNION ALL


SELECT
'Mailed check payment',
SUM(CASE WHEN PaymentMethod = 'Mailed check' THEN 1 ELSE 0 END )/COUNT(*) 
FROM churn_data
UNION ALL

SELECT
'Credit card payment',
SUM(CASE WHEN PaymentMethod = 'Credit card (automat' THEN 1 ELSE 0 END )/COUNT(*) 
FROM churn_data
UNION ALL


SELECT 
'Above avg payment',
SUM(CASE WHEN MonthlyCharges > 64.76 THEN 1 ELSE 0 END)/COUNT(*)
FROM churn_data
UNION ALL

SELECT 
'Above avg total revenue',
SUM(CASE WHEN TotalCharges > 2279.75 THEN 1 ELSE 0 END)/COUNT(*)
FROM churn_data
;


-- correlation analysis; does tnure affect the charges
SELECT 
    (SUM(tenure * MonthlyCharges) - SUM(tenure) * SUM(MonthlyCharges) / COUNT(*)) /
    (SQRT((SUM(tenure * tenure) - SUM(tenure) * SUM(tenure) / COUNT(*)) *
          (SUM(MonthlyCharges * MonthlyCharges) - SUM(MonthlyCharges) * SUM(MonthlyCharges) / COUNT(*))))
    AS correlation
FROM churn_data;

/*
Magnitude analysis;
*/

-- Find total customers by their contract
SELECT COUNT(customerID) AS customer_count, 
Contract
FROM churn_data
GROUP BY Contract
ORDER BY customer_count DESC;

-- Find customers by their payment method
SELECT COUNT(customerID) AS customer_count, 
PaymentMethod
FROM churn_data
GROUP BY PaymentMethod
ORDER BY customer_count DESC;

-- churn and billing method
SELECT 
    Churn,
    PaperlessBilling,
    COUNT(*) AS customer_count
FROM churn_data
WHERE Churn IS NOT NULL AND PaperlessBilling IS NOT NULL
GROUP BY Churn, PaperlessBilling
ORDER BY Churn DESC, PaperlessBilling DESC;

-- counting number of sevices customers use
SELECT 
    service_count,
    COUNT(*) AS customer_count
FROM (
    SELECT 
        ((PhoneService = 'Yes') + 
         (InternetService <> 'No') +  
         (OnlineSecurity = 1) +       
         (OnlineBackup = 'Yes') + 
         (DeviceProtection = 'Yes') + 
         (TechSupport = 'Yes') + 
         (StreamingTV = 'Yes') + 
         (StreamingMovies = 'Yes')
        ) AS service_count
    FROM churn_data
) AS subquery
GROUP BY service_count
ORDER BY customer_count DESC;

-- add a column of number of services a customer uses
ALTER TABLE churn_data ADD COLUMN num_services INT;

UPDATE churn_data
SET num_services = 
    ( (PhoneService = 'Yes') + 
      (InternetService <> 'No') +  
      (OnlineSecurity = 1) +       
      (OnlineBackup = 'Yes') + 
      (DeviceProtection = 'Yes') + 
      (TechSupport = 'Yes') + 
      (StreamingTV = 'Yes') + 
      (StreamingMovies = 'Yes')
    );

select * from churn_data;

-- average of number of services customers by churn have
SELECT 
AVG(num_services) AS avg_services,
Churn
FROM churn_data
GROUP BY Churn;

/*
customers clustering based on their rertention and monthly payment
*/

ALTER TABLE churn_data ADD COLUMN category VARCHAR(10);

UPDATE churn_data
SET category = 
    CASE 
        WHEN tenure >= 33 AND MonthlyCharges > 65 THEN 'VIP'
        WHEN tenure >= 13 THEN 'Regular'
        WHEN tenure <= 12 THEN 'New'
        ELSE 'Unknown' -- Optional: Handles unexpected cases
    END;


-- Finding discounts or extra charges customers may have

ALTER TABLE churn_data ADD COLUMN charge_diff VARCHAR(30);
select * from churn_data;
UPDATE churn_data
SET charge_diff =
	CASE
		WHEN tenure * MonthlyCharges - TotalCharges > 0 THEN 
			CONCAT('$',FORMAT(ABS(tenure * MonthlyCharges - TotalCharges),2), ' Extra charge')
		WHEN tenure * MonthlyCharges - TotalCharges = 0 THEN
			'No extra charge'
        WHEN tenure * MonthlyCharges - TotalCharges < 0 THEN
			CONCAT('$',FORMAT(ABS(tenure * MonthlyCharges - TotalCharges),2), ' Discount')
	END;

-- finding out how many of vip customers had churn and how many of the new customers had churn
SELECT 
    category,
    COUNT(*) AS customer_count
FROM churn_data
WHERE  Churn= 'Yes' AND category IN ('VIP', 'New') -- Filters both 'VIP' and 'New'
GROUP BY category;

/*Part to whole: finding the momstly used service by the users*/
-- online security has 100% uased which seems to be provided by default for all customers and has no pedictive power in modelling

SELECT
  'PhoneService' AS service,
  SUM(CASE WHEN PhoneService = 'Yes' THEN 1 ELSE 0 END) AS yes_count,
  SUM(CASE WHEN PhoneService = 'Yes' THEN 1 ELSE 0 END)/ COUNT(*) AS percentage
FROM churn_data

UNION ALL

SELECT
  'InternetService',
  SUM(CASE WHEN InternetService <> 'No' THEN 1 ELSE 0 END),
  SUM(CASE WHEN InternetService <> 'No' THEN 1 ELSE 0 END)/ COUNT(*)
FROM churn_data

UNION ALL

SELECT
  'OnlineSecurity',
  SUM(CASE WHEN OnlineSecurity = 'Yes' THEN 1 ELSE 0 END),
  SUM(CASE WHEN OnlineSecurity = 'Yes' THEN 1 ELSE 0 END)/ COUNT(*)
FROM churn_data

UNION ALL

SELECT
  'OnlineBackup',
  SUM(CASE WHEN OnlineBackup = 'Yes' THEN 1 ELSE 0 END),
  SUM(CASE WHEN OnlineBackup = 'Yes' THEN 1 ELSE 0 END)/ COUNT(*)
FROM churn_data

UNION ALL

SELECT
  'DeviceProtection',
  SUM(CASE WHEN DeviceProtection = 'Yes' THEN 1 ELSE 0 END),
  SUM(CASE WHEN DeviceProtection = 'Yes' THEN 1 ELSE 0 END)/ COUNT(*)
FROM churn_data

UNION ALL

SELECT
  'TechSupport',
  SUM(CASE WHEN TechSupport = 'Yes' THEN 1 ELSE 0 END),
  SUM(CASE WHEN TechSupport = 'Yes' THEN 1 ELSE 0 END)/ COUNT(*)
FROM churn_data

UNION ALL

SELECT
  'StreamingTV',
  SUM(CASE WHEN StreamingTV = 'Yes' THEN 1 ELSE 0 END),
  SUM(CASE WHEN StreamingTV = 'Yes' THEN 1 ELSE 0 END)/ COUNT(*)
FROM churn_data

UNION ALL

SELECT
  'StreamingMovies',
  SUM(CASE WHEN StreamingMovies = 'Yes' THEN 1 ELSE 0 END),
  SUM(CASE WHEN StreamingMovies = 'Yes' THEN 1 ELSE 0 END)/ COUNT(*)

FROM churn_data;










