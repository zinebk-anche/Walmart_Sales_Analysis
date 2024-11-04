-- Active: 1726263965451@@127.0.0.1@3306@walmartSales
-- Creating the sales table
CREATE TABLE IF NOT EXISTS sales (
    invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6, 4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10, 2) NOT NULL,
    gross_margin_pct FLOAT(11, 9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(3, 1)
);

-- Loading the data
LOAD DATA INFILE '/Users/zineb/Downloads/WalmartSalesData.csv'
INTO TABLE sales
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(invoice_id, branch, city, customer_type, gender, product_line, unit_price, quantity, tax_pct, total, date, time, payment, cogs, gross_margin_pct, gross_income, rating);

-- Creating total_before_tax column
ALTER TABLE sales ADD COLUMN total_before_tax DECIMAL(12, 4);
UPDATE sales SET total_before_tax = quantity * unit_price;

-- Comparing total_before_tax to cogs
SELECT invoice_id, total_before_tax, cogs
FROM sales
WHERE total_before_tax != cogs;

-- Dropping incorrect columns
ALTER TABLE sales
DROP COLUMN cogs,
DROP COLUMN gross_margin_pct,
DROP COLUMN gross_income;

-- Verifying if there are any NULL values
SELECT *
FROM sales
WHERE invoice_id IS NULL
   OR branch IS NULL
   OR city IS NULL
   OR customer_type IS NULL
   OR gender IS NULL
   OR product_line IS NULL
   OR unit_price IS NULL
   OR quantity IS NULL
   OR tax_pct IS NULL
   OR total IS NULL
   OR date IS NULL
   OR time IS NULL
   OR payment IS NULL
   OR rating IS NULL;

-- Feature Engineering
-- Seeing the `time_of_day` column
SELECT
    time,
    CASE
        WHEN time BETWEEN "00:00:00" AND "12:00:00" THEN 'Morning'
        WHEN time BETWEEN "12:01:00" AND "16:00:00" THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_of_day
FROM sales;

-- Adding new columns
ALTER TABLE sales
ADD COLUMN time_of_day VARCHAR(10),
ADD COLUMN day_of_week VARCHAR(10),
ADD COLUMN month VARCHAR(10);

-- Updating the `time_of_day` column
UPDATE sales
SET time_of_day = CASE
    WHEN time BETWEEN "00:00:00" AND "12:00:00" THEN 'Morning'
    WHEN time BETWEEN "12:01:00" AND "16:00:00" THEN 'Afternoon'
    ELSE 'Evening'
END;

-- Updating the `day_of_week` column
UPDATE sales SET day_of_week = DAYNAME(date);

-- Updating the `month` column
UPDATE sales SET month = MONTHNAME(date);

-- Exploratory Data Analysis
-- Generic Questions

-- Q1: Number of unique cities
SELECT COUNT(DISTINCT city) AS number_of_unique_cities FROM sales;

-- Q2: Which city is each branch in?
SELECT DISTINCT branch, city FROM sales;

-- Product Questions

-- Q1: Number of unique product lines
SELECT COUNT(DISTINCT product_line) AS nb_product_line FROM sales;

-- Q2: Most common payment method
SELECT payment, COUNT(*) AS count_payment
FROM sales
GROUP BY payment
ORDER BY count_payment DESC;

-- Q3: Most selling product line
SELECT product_line, SUM(quantity) AS global_quantity
FROM sales
GROUP BY product_line
ORDER BY global_quantity DESC;

-- Q4: Total revenue by month
SELECT month, SUM(quantity * unit_price) AS total_income
FROM sales
GROUP BY month;

-- Q5: Product line with the largest revenue
SELECT product_line, SUM(total_before_tax) AS total_revenue
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC;

-- Q6: City with the largest revenue
SELECT city, SUM(total_before_tax) AS total_revenue
FROM sales
GROUP BY city
ORDER BY total_revenue DESC;

-- Q7: Product line with the largest VAT
SELECT product_line, MAX(tax_pct) AS largest_tax
FROM sales
GROUP BY product_line
ORDER BY largest_tax DESC;

-- Q8: Product line quality - "Good" if greater than average sales
SELECT AVG(total_before_tax) AS avg_sales FROM sales;

ALTER TABLE sales ADD COLUMN sales_status VARCHAR(10);

UPDATE sales
SET sales_status = CASE
    WHEN total_before_tax >= 307.58738000 THEN "GOOD"
    ELSE "BAD"
END;

SELECT product_line, total_before_tax, sales_status FROM sales;

-- Q9: Branch with more products sold than average
SELECT branch, SUM(quantity) AS sold_products_number
FROM sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(total_quantity) FROM (SELECT SUM(quantity) AS total_quantity FROM sales GROUP BY branch) AS branch_sales)
ORDER BY sold_products_number DESC;

-- Q10: Most common product line by gender
SET SESSION sql_mode = (SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));

SELECT gender, product_line, product_count
FROM (
    SELECT gender, product_line, COUNT(*) AS product_count,
           RANK() OVER (PARTITION BY gender ORDER BY COUNT(*) DESC) AS ranking
    FROM sales
    GROUP BY gender, product_line
) AS ranked_products
WHERE ranking = 1;

-- Q11: Average rating of each product line
SELECT product_line, AVG(rating) AS average_rating
FROM sales
GROUP BY product_line
ORDER BY average_rating;

-- Sales Questions

-- Q1: Sales made in each time of the day per weekday
SELECT time_of_day, SUM(total_before_tax) AS number_of_sales
FROM sales
GROUP BY time_of_day
ORDER BY number_of_sales DESC;

-- Q2: Customer type bringing the most revenue
SELECT customer_type, SUM(total_before_tax) AS total_revenue,
       RANK() OVER (ORDER BY SUM(total_before_tax) DESC) AS ranking
FROM sales
GROUP BY customer_type;

-- Q3: City with the highest tax percentage
SELECT city, MAX(tax_pct) AS highest_tax_pct
FROM sales
GROUP BY city
ORDER BY highest_tax_pct DESC;

-- Q4: Customer type paying the most VAT
SELECT customer_type, SUM(tax_pct * total_before_tax) AS amount_paid_tax
FROM sales
GROUP BY customer_type
ORDER BY amount_paid_tax DESC;

-- Customer Questions

-- Q1: Number of unique customer types
SELECT COUNT(DISTINCT customer_type) AS number_of_customer_types FROM sales;

-- Q2: Number of unique payment methods
SELECT COUNT(DISTINCT payment) AS number_of_payment_methods FROM sales;

-- Q3: Most common customer type
SELECT customer_type, COUNT(*) AS customer_type_count
FROM sales
GROUP BY customer_type
ORDER BY customer_type_count DESC;

-- Q4: Customer type buying the most by quantity and income
SELECT customer_type, SUM(quantity) AS quantity_bought
FROM sales
GROUP BY customer_type
ORDER BY quantity_bought DESC;

SELECT customer_type, SUM(total_before_tax) AS paid_untaxed
FROM sales
GROUP BY customer_type
ORDER BY paid_untaxed DESC;

-- Q5: Gender of most customers
SELECT gender, COUNT(*) AS customer_count
FROM sales
GROUP BY gender
ORDER BY customer_count DESC;

-- Q6: Gender distribution per branch
SELECT branch, gender, COUNT(*) FROM sales
GROUP BY branch, gender
ORDER BY branch;

-- Q7: Time of day with most ratings
WITH ranked_ratings AS (
    SELECT time_of_day, COUNT(rating) AS ratings_count,
           RANK() OVER (ORDER BY COUNT(rating) DESC) AS ranking
    FROM sales
    GROUP BY time_of_day
)
SELECT time_of_day, ratings_count
FROM ranked_ratings
ORDER BY ranking;

-- Q8: Time of day with most ratings per branch
WITH ranked_rating AS (
    SELECT branch, time_of_day, COUNT(rating) AS count_rating,
           RANK() OVER (PARTITION BY branch ORDER BY COUNT(rating) DESC) AS ranking
    FROM sales
    GROUP BY branch, time_of_day
)
SELECT branch, time_of_day, count_rating
FROM ranked_rating
WHERE ranking = 1
ORDER BY count_rating DESC;

-- Q9: Day of the week with the best average ratings
WITH ranked_avg_ratings AS (
    SELECT day_of_week, AVG(rating) AS avg_ratings,
           RANK() OVER (ORDER BY AVG(rating) DESC) AS ranking
    FROM sales
    GROUP BY day_of_week
)
SELECT day_of_week, avg_ratings
FROM ranked_avg_ratings
ORDER BY ranking;