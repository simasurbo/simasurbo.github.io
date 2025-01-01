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


----------------------------------------


```sql

SELECT

```


