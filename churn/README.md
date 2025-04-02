#  Churn Analysis Using SQL

This project investigates customer churn behavior using **pure SQL**. The analysis focuses on key business questions such as churn rate, behavioral patterns, billing irregularities, and service usage. The dataset was cleaned, enriched through feature engineering, and analyzed across multiple business dimensions to extract actionable insights.



###  Business Questions Explored

A. What is the overall churn rate?  
B. Which customer segments are more likely to churn (e.g., by contract type, payment method)?  
C. How does tenure influence the likelihood of churn?  
D. Are high-spending customers more likely to churn?  
E. What services are most frequently used by churned customers?  
F. Can customers be grouped based on revenue and retention?  
G. Are there anomalies or inconsistencies in billing (e.g., overcharges, discounts)?

---

###  Steps & Analysis Overview

#### 1.  Data Inspection & Structure  
- Explored table metadata using `INFORMATION_SCHEMA`  
- Reviewed column names, data types, and dataset dimensions  

#### 2.  Categorical Dimension Exploration  
- Extracted and reviewed unique values for categorical variables  

#### 3.  Descriptive Statistics  
- Calculated total number of customers  
- Computed summary statistics (mean, min, max, standard deviation) for:
  - `tenure`  
  - `MonthlyCharges`  
  - `TotalCharges`  

#### 4.  Distribution & Demographics  
- Analyzed tenure distribution  
- Reviewed demographic breakdown by:
  - Gender  
  - Partner status  
  - Senior citizen status  
- Examined proportions of billing and payment method types  

#### 5.  Correlation Analysis  
- Estimated Pearson correlation between `tenure` and `MonthlyCharges`  

#### 6.  Feature Engineering  
- Created `num_services`: total number of services subscribed by each customer  
- Segmented customers into:
  - **VIP**  
  - **Regular**  
  - **New**  
- Engineered `charge_diff`: compares `TotalCharges` to `tenure × MonthlyCharges` to identify potential discounts or overcharges  

#### 7.  Group-Based Churn Analysis  
- Analyzed churn rate by:
  - Contract type  
  - Payment method  
  - Paperless billing status  
- Compared the average number of services used by churned vs. retained customers  
- Evaluated churn rate by customer segment (VIP, New, etc.)  

#### 8.  Service Usage Patterns  
- Identified most frequently used services by churned customers (e.g., streaming, tech support)  
- Highlighted default services with low variability and limited modeling value  

---

