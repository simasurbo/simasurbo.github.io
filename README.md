# Data portfolio

# Top YouTubers for Marketing teams to partner with in 2024 


# Table of contents
- [Objective](#objective)
  -   [Problems](#problems)
  -   [Target](#target)
- [Data Source](#data-source)
- [Stages](#stages)
  -   [Dashboard](#dashboard)
  -   [Tools](#tools)
- [Development](#development)
  -   [Pseudocode](#pseudocode)
  -   [Data Exploration](#data-exploration)
  -   [Data Cleaning](#data-cleaning)
- [Data Processing](#data-processing)
  -   [Data Processing](#data-processing)
  -   [Create SQL View](#create-sql-view)
- [Testing](#testing)
  -   [Data Quality Tests](#data-quality-tests)
- [Visualization](#visualization)
  -   [Results](#results)
  -   [DAX Measures](#dax-measures)
- [Analysis](#analysis)
  -   [Findings](#findings)
  -   [Validation](#validation)
  -   [Discovery](#discovery)
- [Recommendations](#recommendations)
  -   [Potential ROI](#potential-roi)
  -   [Potential Courses of Action](#potential-courses-of-action)
- [Conclusion](#conclusion)


# Objective
To discover the top 100 Youtubers in the world to help the marketing team run successful campaigns

## Problems
- The marketing team has struggled to find the top YouTube channels via a simple search
- There are conflicting data reports and it’s complicated to stay up to date
- Third-party providers are too expensive
- The company’s own BI team doesn’t have the resources to do this request

## Target
- Primary: Head of Marketing
- Secondary: Marketing Team


# Data Source
Data needed to process to YouTubers in 2024, including:

- channel names
- total subscribers
- total views
- total videos uploaded

The data is sourced from Kaggle (an Excel extract) here: https://www.kaggle.com/datasets/taimoor888/top-100-youtube-channels-in-2024

# Stages
- Design
- Development
- Testing
- Analysis


## Dashboard 
What should the dashboard contain based on the requirements provided?
To understand what it should contain, we need to figure out what questions we need the dashboard to answer:

Who are the top 10 YouTubers with the most subscribers?
Which 3 channels have uploaded the most videos?
Which 3 channels have the most views?
Which 3 channels have the highest average views per video?
Which 3 channels have the highest views per subscriber ratio?
Which 3 channels have the highest subscriber engagement rate per video uploaded?
For now, these are some of the questions we need to answer, this may change as we progress down our analysis.

## Tools
| Tool | Purpose |
| ------ | --------- |
| Google Sheeets | Exploring the data |
| SQL Server | Cleaning, testing, and analyzing the data | 
| Power BI | Visualizing the data via interactive dashboards |
| GitHub	| Hosting the project documentation and version control |

# Development
## Pseudocode
1. Get the data
2. Explore the data in Excel
3. Load the data into SQL Server
4. Clean the data with SQL
5. Test the data with SQL
6. Visualize the data in Power BI
7. Generate the findings based on the insights
8. Write the documentation + commentary
9. Publish the data to GitHub Pages

# Data Exploration
1. There are 4 columns that contain the necessary data for this analysis. There is no need to contact the client for additional data.
2. The first column contains the channel name.
3. We have more data than we need, so some of these columns would need to be removed

# Data Cleaning

The aim is to refine our dataset to ensure it is structured and ready for analysis.

The cleaned data should meet the following criteria and constraints:

- Only relevant columns should be retained.
- All data types should be appropriate for the contents of each column.
- No column should contain null values, indicating complete data for all records.

| Property | Description |
| ------ | --------- |
| Number of rows | 100 |
| Number of columns | 4 | 

Below is the table of the expected schema for the clean data:

| Column Name	 | Data Type | Nullable |
| ------ | --------- | ------------- |
| Username | text | No |
| Subscribers | int | No |
| Uploads | int | No |
| Views | bigint | No |


Steps needed to clean and shape data:
- Remove unnecessary columns by only selecting the ones you need
- Convert text data into numeric where necessary

# Data Processing


```sql

CREATE DATABASE youtube_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE youtube_db;


-- Check data
SELECT * FROM youtube_top100;

/*
Data cleaning steps
 1. Remove unnecessary columns
 2. Extract the username from the name column
 3. Rename the column names
*/

SELECT
	Username,
    Subscribers,
    Uploads,
    Views
FROM
	youtube_top100;	
    
    
-- subscriber count needs to be updated to numeric values
UPDATE youtube_top100
SET Subscribers = CASE
    WHEN Subscribers LIKE '%m' THEN CAST(SUBSTRING(Subscribers, 1, LENGTH(Subscribers) - 1) AS DECIMAL) * 1000000
    ELSE CAST(Subscribers AS DECIMAL)  -- If no 'm', keep the value as is
END;

-- test data
SELECT * FROM youtube_top100;

-- need to fix uploads and views to be able to change them to int and bigint for views
UPDATE youtube_top100
SET 
    Uploads = CAST(REPLACE(REPLACE(Uploads, ',', ''), ' ', '') AS UNSIGNED),
    Views = CAST(REPLACE(REPLACE(Views, ',', ''), ' ', '') AS UNSIGNED);

UPDATE youtube_top100
SET Uploads = TRIM(Uploads), Views = TRIM(Views);

 -- test data
SELECT
	Username,
    Subscribers,
    Uploads,
    Views
FROM 
	youtube_top100;
```

# Create SQL view

```sql
-- create view to make it easy to access without filtering data
CREATE VIEW view_youtube_top100 AS
SELECT
	Username,
    Subscribers,
    Uploads,
    Views
FROM 
	youtube_top100;

```


# Testing
## Data quality tests

```sql
/*
Data quality test
1. Check if there are 100 records (row count) --- passed
2. Check if there are 4 columns (column count) --- passed
3. Username must be string, other columns must be numeric (data type check) --- passed
4. Each record must be unique (duplicate count check) --- passed

Expectations
Row count = 100
Column count =. 4

Data types
Username = VARCHAR
Subscribers = INT
Uploads = INT
Views = BIGINT

Duplicates = 0 
*/

-- 1. Row count check
SELECT 
	COUNT(*) AS num_of_rows
FROM 
	view_youtube_top100;

-- 2. Column count check
SELECT 
	COUNT(*) AS column_count
FROM 
	INFORMATION_SCHEMA.COLUMNS
WHERE 
	TABLE_NAME = 'view_youtube_top100';


-- 3. Data type check
SELECT 
	COLUMN_NAME,
    DATA_TYPE
FROM 
	INFORMATION_SCHEMA.COLUMNS
WHERE 
	TABLE_NAME = 'view_youtube_top100';


-- 4. Duplicate check
SELECT
	Username,
    COUNT(*) AS duplicate_count
FROM 
	view_youtube_top100
GROUP BY 
	Username
HAVING
	COUNT(*) > 1;



-- check data
SELECT *
FROM view_youtube_top100
ORDER BY Subscribers DESC;
```


# Visualization
## Results
![Results](assets/images/PowerBIDashb.png)

# DAX Measures
## 1. Total Subscribers
```dax
Total Subscribers (M) = 
VAR million = 1000000
VAR sumOfSubscribers = SUM(Project1_Top_100_Youtubers[Subscribers])
VAR totalSubscribers = DIVIDE(sumOfSubscribers, million)

RETURN totalSubscribers
```

## 2. Total Views (B)
```dax
Total Views (B) = 
VAR billion = 1000000000
VAR sumOfTotalViews = SUM(Project1_Top_100_Youtubers[Views])
VAR totalViews = DIVIDE(sumOfTotalViews, billion)

Return totalViews
```

## 3. Total Videos
```dax
Total Videos = 
VAR totalVideos = SUM(Project1_Top_100_Youtubers[Uploads])

RETURN totalVideos
```

## 4. Average Views Per Video (M)
```dax
Avg Views per Video (M) = 
VAR sumOfTotalViews = SUM(Project1_Top_100_Youtubers[Views])
VAR sumOfTotalVideos = SUM(Project1_Top_100_Youtubers[Uploads])
VAR avgViewsPerVideo = DIVIDE(sumOfTotalViews, sumOfTotalVideos, BLANK())
VAR finalAvgViewsPerVideo = DIVIDE(avgViewsPerVideo, 1000000, BLANK())

RETURN finalAvgViewsPerVideo
```

## 5. Subscriber Engagement Rate
```dax
Subscriber Engagement Rate = 
VAR sumOfTotalSubscribers = SUM(Project1_Top_100_Youtubers[Subscribers])
VAR sumOfTotalVideos = SUM(Project1_Top_100_Youtubers[Uploads])
VAR subscriberEngagementRate = DIVIDE(sumOfTotalSubscribers, sumOfTotalVideos, BLANK())

RETURN subscriberEngagementRate 
```

## 6. Views per subscriber
```dax
Views per Subscriber = 
VAR sumOfTotalViews = SUM(Project1_Top_100_Youtubers[Views])
VAR sumOfTotalSubscribers = SUM(Project1_Top_100_Youtubers[Subscribers])
VAR viewsPerSubscriber = DIVIDE(sumOfTotalViews, sumOfTotalSubscribers, BLANK())

RETURN viewsPerSubscriber
```














