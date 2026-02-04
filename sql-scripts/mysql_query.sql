-- ==========================================================
-- PROJECT: DQLab Store Sales Analysis (2009-2012)
-- DESCRIPTION: Performance Evaluation, Promotion Efficiency, and Customer Analytics
-- DATABASE: MySQL (Synthetic Dataset)
-- ==========================================================

-- ----------------------------------------------------------
-- 1. DQLab Store Overall Performance
-- ----------------------------------------------------------

-- A. Overall Performance by Product Sub Category
-- Objective: Identify top-performing sub-categories in 2011 and 2012 [cite: 2026-02-03].
SELECT 
    YEAR(order_date) AS years,
    product_sub_category,
    SUM(sales) AS sales
FROM dqlab_sales_store
WHERE (YEAR(order_date) = 2011 OR YEAR(order_date) = 2012)
    AND order_status = 'Order Finished'
GROUP BY 1, 2
ORDER BY 1, 3 DESC;

-- B. Overall Performance by Year
-- Objective: Track annual sales trends and order volumes (2009-2012) [cite: 2026-02-03].
SELECT
    YEAR(order_date) AS years,
    SUM(sales) AS sales,
    COUNT(order_id) AS number_of_order
FROM dqlab_sales_store
WHERE YEAR(order_date) BETWEEN 2009 AND 2012
    AND order_status = 'Order Finished'
GROUP BY 1
ORDER BY 1;


-- ----------------------------------------------------------
-- 2. DQLab Store Promotion Effectiveness and Efficiency
-- ----------------------------------------------------------

-- A. Promotion Effectiveness and Efficiency by Years
-- Objective: Compare sales performance during promotional periods (2011-2012) [cite: 2026-02-04].
SELECT 
    YEAR(order_date) AS years,
    product_sub_category,
    SUM(sales) AS sales
FROM dqlab_sales_store
WHERE (YEAR(order_date) = 2011 OR YEAR(order_date) = 2012)
    AND order_status = 'Order Finished'
GROUP BY 1, 2
ORDER BY 1, 3 DESC;

-- B. Promotion Effectiveness and Efficiency by Product Sub Category
-- Objective: Calculate the Burn Rate percentage for each category in 2012 [cite: 2026-02-04].
-- Business Logic: (Total Discount / Total Sales) * 100
SELECT
    YEAR(order_date) AS years,
    product_sub_category,
    product_category,
    SUM(sales) AS sales,
    SUM(discount_value) AS promotion_value,
    ROUND(((SUM(discount_value)/SUM(sales))*100),2) AS burn_rate_percentage
FROM dqlab_sales_store
WHERE YEAR(order_date) = 2012 
    AND order_status = 'Order Finished'
GROUP BY 1, 2, 3
ORDER BY sales DESC;


-- ----------------------------------------------------------
-- 3. Customer Analytics
-- ----------------------------------------------------------

-- A. Customers Transactions per Year
-- Objective: Analyze the growth of unique customers from 2009 to 2012 [cite: 2026-02-04].
SELECT
    YEAR(order_date) AS years,
    COUNT(DISTINCT customer) AS number_of_customer
FROM dqlab_sales_store
WHERE YEAR(order_date) BETWEEN 2009 AND 2012
    AND order_status = 'Order Finished'
GROUP BY 1;
