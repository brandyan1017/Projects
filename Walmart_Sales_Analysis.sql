/*
CREATED BY: Brandy Nolan
CREATED ON: June 10,2024
DESCRIPTION: This dataset focuses on Walmart's customer transactions, capturing detailed information on user demographics, 
product categories, and purchase amounts. 
*/

-- Spending totals based upon gender.
SELECT 
	CASE
	WHEN Gender = 'M' THEN 'Male'
    ELSE 'Female'
    END Gender, 
	CONCAT("$ ",round(AVG(Purchase),2)) Avg_Purchase_Amt
FROM 
	walmart
GROUP BY Gender
ORDER BY 2 DESC

-- Total purchase count and amount based upon Age group. 
SELECT
	Age,
    COUNT(Purchase) Purchase_Count,
    CONCAT(ROUND(COUNT(Purchase) * 100.0 / SUM(COUNT(Purchase)) OVER (), 2),"%") AS Purchase_Count_Percentage,
    SUM(Purchase) Total_Purchase_Amt,
	CONCAT(ROUND(SUM(Purchase) * 100.0 / SUM(SUM(Purchase)) OVER (),2),"%") AS Purchase_Sum_Percentage
FROM 
	walmart
GROUP BY Age
ORDER BY 1

-- Average Purchase amount based upon Maritial Status
SELECT 
	CASE 
    WHEN marital_status = 1 THEN 'Yes'
    ELSE 'No'
    END Marital_Status, 
    COUNT(*) Total_Count,
    ROUND(AVG(Purchase),2) Average_Purchase_Amt
FROM 
	walmart
GROUP BY Marital_Status

-- Top 5 most purchased product_id
SELECT 
	Product_ID,
    COUNT(*) Total_Count
FROM
	walmart
GROUP BY Product_ID
ORDER BY 2 DESC
LIMIT 5

-- Number of different City Categories
SELECT COUNT(DISTINCT City_Category)
FROM  walmart

-- Does how long you stay in a city coorelate to how much you buy
SELECT Gender, Stay_In_Current_City_Years, COUNT(*) Total_Purchases, ROUND(AVG(Purchase),2) Average_Purchase_Amt
FROM walmart
GROUP BY Gender, Stay_In_Current_City_Years
ORDER BY 1 ,2,3 DESC, 4 DESC


