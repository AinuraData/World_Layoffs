# World Layoffs Analysis

## Table of Contents

- [Project Overview](#project-overview)
- [Data Sources](#data-sources)
- [Tools](#tools)
- [Data Cleaning/Preparation](#data-cleaningpreparation)
- [Exploratory Data Analysis](#exploratory-data-analysis)
- [Data Analysis](#data-analysis)
- [Results/Findings](#resultsfindings)

### Project Overview

This data analysis project aims to provide insights into the layoffs from around the world from 2020 to 2023. The cleaning data process allows us to perform exploratory data analysis to identify trends and patterns and gain a deeper understanding of the world layoff picture. 

### Data Sources

The primary dataset used for this analysis is "layoffs.csv" [download here](https://github.com/AinuraData/World_Layoffs/blob/main/layoffs.csv) file from Kaggle, containing information about world layoffs of world top companies

### Tools

- MySQL server - Data Cleaning

### Data Cleaning/Preparation

In the initial data preparation phase, the following tasks were performed:
1. Data loading and inspection

- Create a copy of the raw table
  - Using CREATE TABLE
- Inspection of the Duplicates
  
   - Using window function PARTITION BY
   - Using CTE 

  
3. Data cleaning and formatting

- Remove Duplicates
  - Using CREATE TABLE
  - Using DELETE

- Standardize the Data

   - Using STRING Functions such as TRIM
   - Using LIKE statement (e.g. "%", "_")
   - Using STR_TO_DATE() function to convert a string to a date format and ALTER TABLE statement
4. Hadling missing values

  - Define Null Values or Blank Values
    - Using WHERE clause and COMPARISON OPERATOR
  - Populate Columns
    - Using JOIN Clause
5. Remove unnecessary Columns

  - Delete columns
    - Using ALTER TABLE statement
  - Delete rows with blank data
    - Using DELETE 


### Exploratory Data Analysis

EDA involved exploring the data to answer key questions, such as:

- How many people did the company let off by the year?
- What are the top 5 companies per year with the highest percentage of layoffs?

### Data Analysis

```sql

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER () OVER (
PARTITION BY company, location, 
industry, total_laid_off, percentage_laid_off, `date`, stage,
 country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;
```

### Results/Findings

The analysis results are summarized as follows:
1. The maximum number of total layoffs reached in 2023
2. The top 5 companies in each year are the tech companies
3. The top country with the highest layoff is United States



   
