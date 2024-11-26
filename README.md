# Walmart_Sales_Analysis
A project to practice sales analysis using SQL on a fictive Walmart dataset.
The project data and questions are from [MohammedShehbazDamkar's Walmart-Sales-Data-Analysis--SQL-Project](https://github.com/MohammedShehbazDamkar/Walmart-Sales-Data-Analysis--SQL-Project)

## Overview
This project aims to demonstrate analysis techniques using SQL and Power B. Using a Walmart's fictive sales data I answered 35 retail business-related questions to practice querying in SQL, and then created a dashboard of the results to practice communicating findings using Power Bi. 

## Data
The dataset `WalmartSalesData.csv` contains 17 columns and 1000 rows of sales data from Walmart branches located in Mandalay, Yangon, and Naypyitaw.

### Columns:
- `invoice_id`: Unique ID for each sales transaction
- `branch`: Branch identifier
- `city`: Branch location
- `customer_type`: Type of customer (Membership or Normal)
- `gender`: Customer gender
- `product_line`: Product category
- `unit_price`: Price of each product
- `quantity`: Number of units sold
- `tax_pct`: Tax percentage on the sale
- `total`: Total sale amount
- `date`: Date of transaction
- `time`: Time of transaction
- `payment`: Payment method
- `rating`: Customer satisfaction rating
- **Derived Columns:** `Total_Before_Tax`, `Sales_Status`, `time_of_day`, `day_of_week`, `month`

## Analysis Objectives
1. Product Analysis
2. Sales Analysis
3. Customer Analysis

## SQL Scripts
All SQL scripts for data loading, cleaning, feature engineering, and analysis can be found in the `sql_scripts/` folder.

## Dashboard 
![The sales analysis dashboard](The_sales_analysis_dashboard.png)
Since the data is fictive, the point of this project is not to show analysis results but to demonstrate analysis techniques. 



