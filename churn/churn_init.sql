CREATE DATABASE ChurnAnalytics;

USE ChurnAnalytics;



CREATE TABLE churn_data (
customerID VARCHAR(20),
gender VARCHAR(10),
SeniorCitizen BOOLEAN,
Partner VARCHAR(10),
Dependents VARCHAR(10),
tenure INT,
PhoneService VARCHAR(10),
MultipleLines VARCHAR(10),
InternetService VARCHAR(20),
OnlineSecurity BOOLEAN,
OnlineBackup VARCHAR(10),
DeviceProtection VARCHAR(10),
TechSupport VARCHAR(10),
StreamingTV VARCHAR(10),
StreamingMovies VARCHAR(10),
Contract VARCHAR(20),
PaperlessBilling VARCHAR(10),
PaymentMethod VARCHAR(20),
MonthlyCharges FLOAT,
TotalCharges FLOAT,
Churn VARCHAR(10)
);

LOAD DATA LOCAL INFILE '/PATH/to/Telco_Customer_Churn.csv'
INTO TABLE ChurnAnalytics.churn_data
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;







