/*
1. Define the variable
2. Create a CTE (common table expression) that rounds the avg views per video
3. Select the columns that are requiredfor the analysis
4. Filter the results by the YouTube channels with the highest subsciber bases
5. Order by net_profit (DESC)
*/


-- 1.
SET @coversionRate = 0.02;		 -- the conversion rate at 2%
SET @productCost = 5.0;  		 -- the product cost at $5
SET @campaignCost = 100000.0;	 -- the campaign cost at $50,000


-- 2. 
WITH ChannelData AS (
	SELECT
    Username,
    Views,
    Uploads,
    ROUND((Views / Uploads), -4) AS rounded_avg_views_per_video
FROM 
	view_youtube_top100

)


-- 3, 4, 5

SELECT
	Username,
    rounded_avg_views_per_video,
    ROUND((rounded_avg_views_per_video * @coversionRate), 2) AS potential_units_sold_per_video,
    ROUND((rounded_avg_views_per_video * @coversionRate * @productCost), 2) AS potential_revenue_per_video,
    ROUND(((rounded_avg_views_per_video * @coversionRate * @productCost) - @campaignCost), 2) AS net_profit
FROM 
	ChannelData
WHERE 
	Username IN ('MrBeast', 'T-Series', 'Cocomelon-Nursery Rhymes')
ORDER BY
	net_profit DESC;










