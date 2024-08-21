-- Data Cleaning


SELECT *
FROM layoffs;

-- 1. Remove Duplicates
-- 2. Stanadardize the Data
-- 3. Null Values or Blank values
-- 4. Remove Any Columns



CREATE TABLE layoffs_staging
LIKE layoffs;


SELECT *
FROM layoffs_staging;

INSERT layoffs_staging
SELECT *
FROM layoffs;


SELECT *,
ROW_NUMBER () OVER (
PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`) AS row_num
FROM layoffs_staging;

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


SELECT *
FROM layoffs_staging
WHERE company = 'Casper' ;


WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER () OVER (
PARTITION BY company, location, 
industry, total_laid_off, percentage_laid_off, `date`, stage,
 country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
DELETE 
FROM duplicate_cte
WHERE row_num > 1;



CREATE TABLE `layoffs_staging3` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` text,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` text,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging3
WHERE row_num > 1;

INSERT INTO layoffs_staging3
SELECT *,
ROW_NUMBER () OVER (
PARTITION BY company, location, 
industry, total_laid_off, percentage_laid_off, `date`, stage
, country, funds_raised_millions) AS row_num
FROM layoffs_staging;



DELETE
FROM layoffs_staging3
WHERE row_num > 1;

SELECT *
FROM layoffs_staging3;


-- Standartizing data

SELECT company, TRIM(company)
FROM layoffs_staging3;

UPDATE layoffs_staging3
SET company = TRIM(company);


SELECT DISTINCT industry
FROM layoffs_staging3
;

UPDATE layoffs_staging3
SET industry = 'Crypto'
WHERE industry like 'Crypto%';


SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_staging3
ORDER BY 1;

UPDATE layoffs_staging3
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging3;

UPDATE layoffs_staging3
SET `date` = 01/01/2023
WHERE `date` = 'Null';

UPDATE layoffs_staging3
SET `date` = '1/1/2023'
WHERE `date` = '0.000494315373208106';

UPDATE layoffs_staging3
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

SELECT `date`
FROM layoffs_staging3;

UPDATE layoffs_staging3
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging3
MODIFY COLUMN `date` DATE;

SELECT *
FROM layoffs_staging3
WHERE total_laid_off = 'NULL'
AND percentage_laid_off = 'NULL';

SELECT *
FROM layoffs_staging3
WHERE industry = 'NULL'
OR industry = ' ';

SELECT *
FROM layoffs_staging3
WHERE company = 'Bally''s Interactive';


SELECT *
FROM layoffs_staging3
WHERE total_laid_off = 'Null'
AND percentage_laid_off = 'Null';

DELETE 
FROM layoffs_staging3
WHERE total_laid_off = 'Null'
AND percentage_laid_off = 'Null';

SELECT *
FROM layoffs_staging3;

ALTER TABLE layoffs_staging3
DROP COLUMN row_num;
