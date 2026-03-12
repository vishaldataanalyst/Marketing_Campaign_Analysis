/*
Business Problem Statement - 

1-How can companies optimize their marketing campaigns to improve conversion rates and maximize return on investment (ROI)?

2-Companies invest significant budgets in marketing campaigns across different channels and campaign types.
 However, not all campaigns perform equally. The goal of this analysis is to identify which campaign strategies, 
 channels, and target audiences generate the highest marketing performance.
 */
 
create schema marketing_analysis;
use marketing_analysis;
select * from marketing limit 3;
-- total_records
select count(*) as total_rows from marketing;
-- campaign type
SELECT DISTINCT campaign_type
FROM marketing;
-- channen used for campaigning
SELECT DISTINCT channel_used
FROM marketing;
-- customer segment
SELECT DISTINCT customer_segment
FROM marketing;
-- conversion rate
SELECT 
MIN(conversion_rate) AS min_conversion,
MAX(conversion_rate) AS max_conversion,
AVG(conversion_rate) AS avg_conversion
FROM marketing;
-- conversion rate by campaign type
select 
Campaign_Type, avg(Conversion_Rate)*100 as  avg_conversion_rate from marketing
group by Campaign_Type
order by avg(Conversion_Rate)*100 desc;

select * from marketing limit 3;

-- ROI by channel used
 select 
 Channel_Used , avg(ROI) as Avg_ROI
 from marketing
 group by Channel_Used
 order by avg(ROI) desc;
-- conversion rate by gender
 select
 Gender , avg(Conversion_Rate)*100 as avg_convertion_rate
 from marketing
 group by Gender
 order by avg(Conversion_Rate)*100 desc;
 -- conversion rate by age group
 select
 Age_Group , avg(Conversion_Rate)*100 as avg_convertion_rate
 from marketing
 group by Age_Group
 order by avg(Conversion_Rate)*100 desc;
 -- Engagement Score by Campaign Type
 select
 Campaign_Type,avg(Engagement_Score) as Avg_Engagement_Score
 from marketing
 group by  Campaign_Type
 order by avg(Engagement_Score) desc;
 
 select * from marketing limit 3;

-- Marketing Cost Analysis
select 
Campaign_Type, avg(Acquisition_Cost) as Avg_Acquisition_Cost from marketing
group by Campaign_Type
order by avg(Acquisition_Cost) desc;
-- Campaigns by Year
SELECT 
    YEAR(date) AS year,
    MONTH(date) AS Month,  -- Use MONTH() for standard MySQL
    COUNT(*) AS total_campaigns, round(avg(Acquisition_Cost),0) as Avg_Acquisition_Cost ,round(avg(Total_Revenue),0) as Avg_Total_Revenue
FROM marketing
GROUP BY YEAR(date), MONTH(date) 
order by COUNT(*) desc ;
-- Top Performing Customer Segments
SELECT 
customer_segment,
round(AVG(conversion_rate)*100,3) AS avg_conversion_rate,
round(AVG(roi),4) AS avg_roi
FROM marketing
GROUP BY customer_segment
ORDER BY avg_conversion_rate DESC;

select * from marketing limit 3;

-- Revenue by Campaign Type
select
Campaign_Type,round(sum(Total_Revenue),0) as Total_Revenue from marketing
group by Campaign_Type
order by sum(Total_Revenue) desc;
-- Revenue by Channel
select
Channel_Used,round(sum(Total_Revenue),0) as Total_Revenue from marketing
group by Channel_Used
order by sum(Total_Revenue) desc;

-- Most Profitable Customer Segment
select
Customer_Segment,round(sum(Total_Revenue),0) as Total_Revenue from marketing
group by Customer_Segment
order by sum(Total_Revenue) desc;
-- CTR by Channel
SELECT
Channel_Used,
ROUND(AVG(CTR),3) AS Avg_CTR
FROM marketing
GROUP BY Channel_Used
ORDER BY  Avg_CTR DESC;
-- Campaign Efficiency (Revenue vs Cost)
SELECT
Campaign_Type,
ROUND(SUM(Total_Revenue),0) AS total_revenue,
ROUND(SUM(Acquisition_Cost),0) AS total_cost,
ROUND(SUM(Total_Revenue) - SUM(Acquisition_Cost),0) AS total_profit
FROM marketing
GROUP BY Campaign_Type
ORDER BY total_profit DESC;
-- Best Channel by Conversion + ROI
SELECT
Channel_Used,
ROUND(AVG(Conversion_Rate)*100,4) AS avg_conversion_rate,
ROUND(AVG(ROI),3) AS avg_roi
FROM marketing
GROUP BY Channel_Used
ORDER BY avg_roi DESC;
-- Top 10 Highest Revenue Campaigns
SELECT
Campaign_ID,
Company,
Campaign_Type,
Channel_Used,
ROUND(Total_Revenue,0) AS revenue
FROM marketing
ORDER BY Total_Revenue DESC
LIMIT 10;
-- Engagement vs Conversion Relationship
SELECT
Engagement_Score,
ROUND(AVG(Conversion_Rate)*100,4) AS avg_conversion_rate
FROM marketing
GROUP BY Engagement_Score
ORDER BY Engagement_Score;
-- Top Campaigns per Channel
SELECT *
FROM (
    SELECT
        Channel_Used,
        Campaign_ID,
        ROUND(Total_Revenue,0) AS revenue,
        RANK() OVER(PARTITION BY Channel_Used ORDER BY Total_Revenue DESC) AS rank_in_channel
    FROM marketing
) t
WHERE rank_in_channel <= 3;