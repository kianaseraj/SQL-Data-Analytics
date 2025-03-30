# Churn Analysis Using SQL

This project explores a customer churn dataset using pure SQL. The analysis focuses on understanding customer behavior, billing patterns, service usage, and factors influencing churn. The data was explored, cleaned, enriched with engineered features, and analyzed across several business dimensions.

🔍 **Business Questions Explored**

A. What is the overall churn rate?

B. Which customer segments are more likely to churn (e.g., contract type, payment method)?

C. How does tenure affect churn likelihood?

D. Are high-spending customers more likely to churn?

E. What services are most used by churned customers?

F. Group customers based on revenue and retention?

G. Are there anomalies or inconsistencies in billing (overcharges or discounts)?


🧱 **Steps & Analysis Overview**

1. 🔢 **Data Inspection & Structure**
Explored table metadata using INFORMATION_SCHEMA
Checked column names, data types, and dimensions

2. 📐 **Categorical Dimension Exploration**
Extracted unique values for variables.

3. 📊 **Descriptive Statistics**
Calculated total customers
Computed averages, min, max, and standard deviation for:
tenure
MonthlyCharges
TotalCharges

4. 📈 **Distribution & Demographics**
Analyzed tenure distribution
Gender, partner status, and senior citizen demographics
Proportion of customers using different billing and payment methods

5. 🔁 **Correlation Analysis**
Estimated Pearson correlation between tenure and MonthlyCharges

6. 🧮 **Feature Engineering**
Created num_services: number of services used per customer
Classified customers into categories:
VIP, 
Regular,
New,
Engineered charge_diff: checks if total charge matches expected value based on tenure × monthly charge, indicating possible discounts or overcharges


7. 🔍 **Magnitude & Group-Based Analysis**
Churn rate by:
Contract,
PaymentMethod,
PaperlessBilling,
Average number of services by churn status,
Churn counts by VIP and New segments

8. 📦 **Part-to-Whole Service Usage**
Analyzed which services (Streaming, TechSupport, etc.) are most commonly used
Identified default services with limited modeling value (e.g., always-active services)




