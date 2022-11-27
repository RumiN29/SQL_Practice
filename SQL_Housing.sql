-- Check what houseprices table has
SELECT * 
FROM houseprices
LIMIT 100;

-- Write a query that returns a list of distinct values in the yearbuilt field.
SELECT DISTINCT(yearbuilt)
FROM houseprices;

-- How many unique values are there for the mszoning field (alias this as count_mszoning), 
-- and mssubclass field (alias this as count_mssubclass)?
SELECT COUNT(DISTINCT mszoning) AS count_mszoning, 
	COUNT(DISTINCT mssubclass) AS count_mssubclass
FROM houseprices;

-- Write a query that returns a list of all the unique combinations for street and lotshape, 
-- sorted alphabetically by street.
SELECT DISTINCT street, lotshape
FROM houseprices
ORDER BY street;

-- Create a report that shows the number of records for each neighborhood and lotconfig pair. 
-- Alias the count of records to count_lotconfig. 
-- Order the results by neighborhood (A-Z), count_lotconfig (smallest-largest), and lotconfig (A-Z).
SELECT neighborhood, lotconfig, COUNT(lotconfig) AS count_lotconfig
FROM houseprices
GROUP BY neighborhood, lotconfig
ORDER BY neighborhood, count_lotconfig, lotconfig;

-- Write a query that returns the average saleprice of houses per yearbuilt—call this field avg_saleprice
-- rounded to the nearest whole number and sorted from newest to oldest.
SELECT yearbuilt, ROUND(AVG(saleprice),0)::integer AS avg_saleprice
FROM houseprices
GROUP BY yearbuilt
ORDER BY yearbuilt DESC;

-- Write a query that shows the average number of cars for the column garagecars (using alias avg_garage) per yearbuilt.
-- Only include houses that have 1 or more garagecars in this average. Round your answer to the nearest whole number.
SELECT yearbuilt, ROUND(AVG(garagecars),0)::integer AS avg_garage
FROM houseprices
WHERE garagecars >= 1
GROUP BY yearbuilt;

-- Write a query that shows for each yearbuilt,
-- how many houses had zero garages and the largest lotarea amount for that year.
SELECT yearbuilt, COUNT(garagecars), MAX(lotarea)
FROM houseprices
WHERE garagecars = 0
GROUP BY yearbuilt;

-- For each yearbuilt, find the average lotarea—call it avg_lot_per_year—and 
-- return only those results for which the average is smaller than 10,000, sorted high to low.
SELECT yearbuilt, AVG(lotarea)::float AS avg_lot_per_year
FROM houseprices
GROUP BY yearbuilt
HAVING AVG(lotarea) < 10000
ORDER BY avg_lot_per_year DESC;

-- Write a query that shows, for each yearbuilt, how many houses had a lotarea between 10,000 and 15,000, inclusive. 
-- Finally, order it by yearbuilt from oldest to newest.
SELECT yearbuilt, COUNT(*)
FROM houseprices
WHERE lotarea BETWEEN 10000 AND 15000
GROUP BY yearbuilt
ORDER BY yearbuilt;

-- Write a query that shows the average overall quality overallqual (rounded to 0 decimals and renamed as avg_quality) 
-- and the number of unique garage types (garagetype) renamed as garage_count for each neighborhood, 
-- sorted by neighborhood.
SELECT neighborhood, 
	ROUND(AVG(overallqual),0)::integer AS avg_quality, 
	COUNT(DISTINCT garagetype) AS garage_count
FROM houseprices
GROUP BY neighborhood
ORDER BY neighborhood;

-- Write a query that selects the average lotarea (rounded to 2 decimals) per yearbuilt 
-- where the street is not gravel (Grvl) and lotconfig is a corner (Corner). 
-- Select only the average lotarea records greater than 1,000, and sort your results by yearbuilt from oldest to newest.
SELECT yearbuilt, ROUND(AVG(lotarea), 2)::float
FROM houseprices
WHERE street != 'Grvl'
	AND lotconfig = 'Corner'
GROUP BY yearbuilt
HAVING ROUND(AVG(lotarea), 2)::float > 1000
ORDER BY yearbuilt;
