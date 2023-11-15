----SQL PROJECT --*
----BUSINESS INSIGHTS: Improvements made from the company stakeholders?--
--producing top states that made sales profitable to get their annual income
--total annual revenue from the above sales--

--QUERY 1:LOOKING AT THE TOP 10 STATES THAT MADE INCOME FROM THEIR SALES--
SELECT TOP 10 State,Category,[Product Name],Sales,Profit,SUM(Sales + Profit) as TOTAL_INCOME
FROM Orders$
GROUP BY State,Category,[Product Name],Sales,Profit
ORDER BY Sales desc;

--QUERY 2:APPLYING RANKS TO EACH PRODUCT--
SELECT [Product Name],Quantity,[Product ID],[Ship Mode],
RANK() OVER (ORDER BY [Product Name],Quantity,[Product ID],[Ship Mode]) AS RANKS 
FROM Orders$
GROUP BY [Product Name],Quantity,[Product ID],[Ship Mode]
ORDER BY [Product Name] ASC;

--QUERY 3:CALCULATE THE TOTAL SALES THAT WAS MADE IN EACH MONTH OF THE YEAR--
WITH monthlysales AS(
SELECT [Customer ID],Sales,SUM(Sales/12) AS monthlysales
FROM Orders$
GROUP BY [Customer ID], Sales
) --ORDER BY SALES DESC
SELECT SUM(monthlysales) AS TOTAL_MONTHLY_INCOME
FROM monthlysales

--QUERY 4:IDENTIFYING DATE DIFFERENCE FROM THE ORDER DATE TO THE SHIPPING DATE--
SELECT [Order Date],[Ship Date],
(SELECT DATEDIFF(DAYOFYEAR,1,31)) AS DAYDIFF,
(SELECT DATEDIFF(WEEKDAY,1,4)) AS WEEKDIFF,
(SELECT DATEDIFF(MONTH,1,31)) AS MONTHDIFF,
(SELECT DATEDIFF(YEAR,'2014','2015')) AS YEARDIFF
FROM Orders$

--QUERY 5:CALCULATE THE SUM OF SALES PLUS PROFIT TO GET THE ANNUAL REVENUE
--(USING CTE)
WITH TOTAL_INCOME AS(
SELECT [Customer ID],[Order Date],SUM(Sales +Profit) AS TOTAL_INCOME
FROM Orders$
GROUP BY [Customer ID],[Order Date]
)
SELECT SUM(TOTAL_INCOME)AS YEARLY_REVENUE
FROM TOTAL_INCOME 


