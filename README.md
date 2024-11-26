# Walmart_Sales_Analysis
A project to practice sales analysis using SQL on a fictive Walmart dataset.
The project data and questions are from [MohammedShehbazDamkar's Walmart-Sales-Data-Analysis--SQL-Project](https://github.com/MohammedShehbazDamkar/Walmart-Sales-Data-Analysis--SQL-Project)

## Overview
This project aims to provide insights into Walmart's sales transactions across three branches in Burma. The analysis covers product performance, customer segments, and sales trends.

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
![The sales analysis dashboard](/Users/zineb/Desktop/dashboard.png)


