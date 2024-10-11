-- Creating the 'sales' table with the necessary columns
CREATE TABLE IF NOT EXISTS sales(
    invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,    -- Invoice ID as the primary key
    branch VARCHAR(5) NOT NULL,                      -- Branch identifier (A, B, C)
    city VARCHAR(30) NOT NULL,                       -- City where the branch is located
    customer_type VARCHAR(30) NOT NULL,              -- Customer type (e.g., Member, Normal)
    gender VARCHAR(30) NOT NULL,                     -- Gender of the customer
    product_line VARCHAR(100) NOT NULL,              -- Product line category (e.g., Food, Fashion)
    unit_price DECIMAL(10,2) NOT NULL,               -- Price per unit of the product
    quantity INT NOT NULL,                           -- Quantity of products sold
    tax_pct FLOAT(6,4) NOT NULL,                     -- Tax percentage applied to the sale
    total DECIMAL(12, 4) NOT NULL,                   -- Total price including tax
    date DATETIME NOT NULL,                          -- Date of the transaction
    time TIME NOT NULL,                              -- Time of the transaction
    payment VARCHAR(15) NOT NULL,                    -- Payment method (e.g., Cash, Ewallet)
    cogs DECIMAL(10,2) NOT NULL,                     -- Cost of Goods Sold (Will be dropped later)
    gross_margin_pct FLOAT(11,9),                    -- Gross margin percentage (Will be dropped later)
    gross_income DECIMAL(12, 4),                     -- Gross income (Will be dropped later)
    rating FLOAT(3, 1)                               -- Customer rating of the product or service
);
