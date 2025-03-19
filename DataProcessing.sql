CREATE DATABASE CloudMigration;

USE CloudMigration;

-- Import the Content Catalog data 

-- Processing the imported data

-- Remove duplicates
WITH CTE AS (
    SELECT *, 
           ROW_NUMBER() OVER (PARTITION BY column1, column2, column3 ORDER BY date_column DESC) AS rn
    FROM CropMessages;
)
DELETE FROM CTE WHERE rn > 1;

-- Eliminate missing data
DELETE FROM content_catalog
	WHERE column1 IS NULL OR column2 IS NULL OR column3 = '';

-- Filter out records older than 7 years
DELETE FROM content_catalog
	WHERE date_column < DATEADD(YEAR, -7, GETDATE());

-- Execute the above 3 queries of all the tables





