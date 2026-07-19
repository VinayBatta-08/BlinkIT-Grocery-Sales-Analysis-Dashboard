--PROJECT--

USE FSA_CLASS;

SELECT * FROM [BlinkIT Grocery Data (1)];

--DATA CLEANING--

UPDATE [BlinkIT Grocery Data (1)]
SET Item_Fat_Content =
CASE
WHEN Item_Fat_Content IN ('LF','low fat') then 'Low Fat'
WHEN Item_Fat_Content IN ('reg') then 'Regular'
ELSE 
Item_Fat_Content
END

--FINDING KPI'S--

SELECT CAST(SUM(Total_Sales)/1000000 AS Decimal(10,2)) AS Total_Sales from [BlinkIT Grocery Data (1)];

--AVERAGE SALES--

SELECT CAST(AVG(Total_Sales) AS INT) AS AVG_SALES FROM [BlinkIT Grocery Data (1)];

--NUMBER OF ITEMS--

SELECT COUNT(DISTINCT(Item_Identifier)) AS Total_Items from [BlinkIT Grocery Data (1)]; 

--AVERAGE RATING--

SELECT CAST(AVG(RATING) AS DECIMAL(10,1)) AS AVG_RATING_PER_PRODUCT FROM [BlinkIT Grocery Data (1)];

--GRANULAR REQUIREMENTS--

--Total Sales by Fat Content--

SELECT Item_Fat_Content,CAST(SUM(Total_Sales) AS INT) AS Total_Sales 
FROM [BlinkIT Grocery Data (1)]
GROUP BY Item_Fat_Content;

--Total Sales by Item Type--

Select Item_Type,CAST(SUM(Total_Sales) AS INT) AS Total_Sales from [BlinkIT Grocery Data (1)]
GROUP BY Item_Type
ORDER BY Total_Sales desc;

--Total Sales by Outlet Establishment--

Select Outlet_Establishment_Year,CAST(SUM(Total_Sales) AS INT) AS Total_Sales 
from [BlinkIT Grocery Data (1)]
GROUP BY Outlet_Establishment_Year
ORDER BY Total_Sales DESC;

--Total Sales by Outlet Location Using PARTITION BY--

Select DISTINCT(Outlet_Location_Type),
CAST(Sum(Total_Sales) OVER(PARTITION BY Outlet_Location_Type) AS INT) AS Location_Sales
from [BlinkIT Grocery Data (1)];


--All Metrics by Outlet Type--

Select Outlet_Type,CAST(SUM(Total_Sales)/1000000 AS Decimal(10,2)) AS Total_Sales,
CAST(AVG(Total_Sales) AS INT) AS AVG_SALES,
CAST(AVG(Total_Sales) AS INT) AS AVG_SALES,
CAST(AVG(RATING) AS DECIMAL(10,1)) AS AVG_RATING_PER_PRODUCT
from [BlinkIT Grocery Data (1)]
GROUP BY Outlet_Type;
