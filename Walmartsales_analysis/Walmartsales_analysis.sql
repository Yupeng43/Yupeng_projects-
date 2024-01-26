CREATE DATABASE SalesDataWalmart;
CREATE TABLE IF NOT EXISTS sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_incomsalessalese DECIMAL(12, 4),
    rating FLOAT(2, 1)
);

--  -------------------------------------------------------------------------------------
-- -----------------Feature Engineering-------------

-- time_of_day
 
SELECT 
    time,
    CASE
         WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
          WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
           ELSE 'Evening'
	 END
     AS time_of_date
From sales;

ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);

UPDATE sales
SET time_of_day=(
CASE
         WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
		 WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
		 ELSE 'Evening'
           
END
);

-- day_name

SELECT 
   date,
   DAYNAME(date) AS day_name
    
   FROM sales;

ALTER TABLE sales ADD COLUMN day_name VARCHAR(15);

UPDATE sales
SET day_name= DAYNAME(date);

-- month_name

SELECT 
    date,
    MONTHNAME(date)
FROM sales;

ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);

UPDATE sales
SET month_name= MONTHNAME(date);

-- --------------Generic Questions------------------

-- How many unique cities does the data have?

SELECT COUNT(DISTINCT city)
FROM sales;

-- In which city is each branch?

SELECT DISTINCT branch,
city
FROM sales;

-- -------------Product questions---------------

-- How many unique product lines does the data have?
SELECT 
   DISTINCT product_line
From sales;

-- What is the most common payment method?
SELECT
  payment,
  COUNT(payment) AS cnt
FROM sales
GROUP BY  payment
ORDER BY cnt DESC ;

-- What is the most selling product line?
SELECT
    product_line,
    COUNT(product_line) AS cnt
    FROM sales
    GROUP BY product_line
    ORDER BY cnt DESC;

-- What is the total revenue by month?
SELECT 
   month_name AS month ,
   SUM(total) AS total_revenue
FROM sales
GROUP BY month_name
ORDER BY total_revenue DESC;

-- What month had the largest COGS?
SELECT 
   month_name AS month,
   SUM(cogs) AS cogs
FROM sales
GROUP BY month_name
ORDER BY cogs DESC;

-- What product line had the largest revenue?
SELECT 
    product_line,
    SUM(total) AS total_revenue
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC;

-- What is the city with the largest revenue?
SELECT 
    city,
    SUM(total) AS total_revenue
FROM sales
GROUP BY city
ORDER BY total_revenue DESC;

-- Which branch sold more products than average product sold?
SELECT 
    branch,
    SUM(quantity) as qty
FROM sales
GROUP BY branch
HAVING  qty > AVG(quantity);

-- What is the most common product line by gender?
SELECT 
    product_line,
    gender,
    COUNT(product_line) AS cnt
FROM sales
GROUP BY gender,product_line 
ORDER BY cnt DESC;

-- What is the average rating of each product line?
SELECT 
     product_line,
     ROUND(AVG(rating),2)  AS avg_rating
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;

-- ------------Sales---------

-- Number of sales made in each time of the day per weekday
SELECT
    
    time_of_day,
    COUNT(*) AS total_sales
FROM sales
GROUP BY time_of_day
ORDER BY total_sales DESC;

-- Which of the customer types brings the most revenue?
SELECT 
    customer_type,
    SUM(total) AS total_revenue
FROM sales
GROUP BY customer_type
ORDER BY total_revenue DESC;

-- -------------Customer---------
-- What is the most common customer type?
SELECT 
   customer_type,
   COUNT(customer_type) AS cnt 
FROM sales
GROUP BY customer_type
ORDER BY cnt DESC;


    
    
    
    
    
    
    
    
    
    
    
    
