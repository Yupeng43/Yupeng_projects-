SELECT * 
	FROM pizza_sales.dbo.pizza_sales


-- Total Revenue-----------------------
SELECT 
	SUM(total_price) AS Revenue
FROM dbo.pizza_sales;

-- Average Order Value------------
SELECT 
	
	SUM(total_price)/COUNT(DISTINCT (order_id)) AS Average_Order_Value
FROM dbo.pizza_sales;

--Total Pizzas Sold----------------
SELECT SUM(quantity)AS Total_Pizzas_Sold
	FROM dbo.pizza_sales ;

-- Daily Trend for total orders -------------------
SELECT 
    DATENAME(DW, order_date) AS order_day,
    COUNT(DISTINCT order_id) AS order_count
FROM dbo.pizza_sales
GROUP BY DATENAME(DW, order_date)
ORDER BY  order_count  DESC;

--Monthly Trend for total orders--------------
SELECT 
	DATENAME(MONTH,order_date) AS order_month,
	COUNT(DISTINCT order_id) AS order_count
	FROM dbo.pizza_sales
GROUP BY DATENAME(MONTH,order_date)
ORDER BY  order_count  DESC;

-- Percentage of Sales by Pizza Category-------------
SELECT
	pizza_category,
	SUM(total_price) AS total,
	ROUND(SUM(total_price)*100 / (SELECT SUM(total_price) FROM dbo.pizza_sales ) ,2)AS percentage

FROM dbo.pizza_sales

GROUP BY pizza_category
ORDER BY percentage DESC;

--Top 5 best sellers by Revenue-----------
SELECT 
    TOP 5 
	pizza_name,
	SUM(total_price) AS Revenue
FROM dbo.pizza_sales
GROUP BY pizza_name
ORDER BY Revenue DESC ;


