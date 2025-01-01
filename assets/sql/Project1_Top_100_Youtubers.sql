CREATE DATABASE youtube_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE youtube_db;

-- Check data
SELECT * FROM youtube_top100;

/*
Data cleaning steps
 1. Remove unnecessary columns
 2. Extract username from the name column
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

-- create view to make it easy to access without filtering data
CREATE VIEW view_youtube_top100 AS
SELECT
	Username,
    Subscribers,
    Uploads,
    Views
FROM 
	youtube_top100;

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




