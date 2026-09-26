-- Query number 1
SELECT COUNT(*) AS total_rows FROM raw_transactions;

--Query number 2
CREATE TABLE clean_transactions AS
SELECT *
FROM raw_transactions
WHERE InvoiceNo NOT LIKE 'C%'
  AND Quantity > 0
  AND UnitPrice > 0
  AND CustomerID IS NOT NULL;
  
 -- Query number 3
 UPDATE clean_transactions
SET Country = 'Ireland'
WHERE Country = 'EIRE';

-- 4. Added a calculated revenue column (Quantity × UnitPrice)
ALTER TABLE clean_transactions ADD COLUMN Revenue REAL;
UPDATE clean_transactions SET Revenue = Quantity * UnitPrice;

-- 5. Summary table: monthly sales trend
DROP TABLE IF EXISTS sales_by_month;

CREATE TABLE sales_by_month AS
SELECT 
  substr(InvoiceDate, instr(InvoiceDate,' ')-4, 4) || '-' || 
  printf('%02d', CAST(substr(InvoiceDate, 1, instr(InvoiceDate,'/')-1) AS INTEGER)) AS month,
  SUM(Revenue) AS total_revenue,
  COUNT(DISTINCT InvoiceNo) AS num_orders
FROM clean_transactions
GROUP BY month
ORDER BY month;

-- 6. Summary table: top products by revenue
CREATE TABLE sales_by_product AS
SELECT Description AS product,
       SUM(Quantity) AS units_sold,
       SUM(Revenue) AS total_revenue
FROM clean_transactions
GROUP BY Description
ORDER BY total_revenue DESC;

-- 7. Summary table: sales by country
CREATE TABLE sales_by_country AS
SELECT Country,
       SUM(Revenue) AS total_revenue,
       COUNT(DISTINCT CustomerID) AS num_customers
FROM clean_transactions
GROUP BY Country
ORDER BY total_revenue DESC;

SELECT Quantity, UnitPrice, Revenue FROM clean_transactions LIMIT 5;
