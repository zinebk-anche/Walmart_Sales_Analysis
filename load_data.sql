-- Load data from the CSV file into the 'sales' table
-- Ensure that the file path is correct for your system
LOAD DATA INFILE '/Users/zineb/Downloads/WalmartSalesData.csv (1).csv'
INTO TABLE sales
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(`invoice_id`, `branch`, `city`, `customer_type`, `gender`, `product_line`, `unit_price`, `quantity`, `tax_pct`, `total`, `date`, `time`, `payment`, `cogs`, `gross_margin_pct`, `gross_income`, `rating`);
