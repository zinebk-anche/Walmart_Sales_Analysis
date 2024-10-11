-- The cogs column provided seems to be incorrectly calculated (I believe the cogs column was mistakenly calculated as the total paid amount before tax (quantity * unit_price) instead of total costs, which could lead to inaccurate analysis of profitability)
-- Verification

-- Add a new column 'Total_Before_Tax' to store the total income pre-tax per invoice
ALTER TABLE sales 
ADD COLUMN Total_Before_Tax DECIMAL(12, 4);

-- Calculate 'Total_Before_Tax' as the product of 'quantity' and 'unit_price'
UPDATE sales 
SET Total_Before_Tax = quantity * unit_price;

-- Verify if there are any discrepancies between 'Total_Before_Tax' and 'cogs' (previously calculated)
-- This comparison is expected to return no rows, proving that 'cogs' was calculated as 'quantity * unit_price'
SELECT invoice_id, Total_Before_Tax, cogs 
FROM sales
WHERE Total_Before_Tax != cogs;

-- Uncomment and run if no differences are found between cogs and Total_Before_Tax
/*
-- Dropping the columns with inaccurate calculations (cogs, gross_margin_pct, and gross_income)
ALTER TABLE sales
DROP COLUMN cogs,
DROP COLUMN gross_margin_pct,
DROP COLUMN gross_income;
*/
