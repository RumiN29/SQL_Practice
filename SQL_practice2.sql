-- Query that returns the owner_id of the owners table and the transaction_id and service of the transactions table.
-- Ensure that all records from the transactions table are returned, 
-- and sort the results in ascending order according to owner_id.
SELECT o.owner_id, t.transaction_id, t.service
FROM transactions AS t
LEFT OUTER JOIN owners AS o
ON t.pet_id = o.pet_id
ORDER BY owner_id;

-- Query that returns the owner_id, pet_id, transaction_id, and visits_count fields from their respective tables. 
-- Sort in order of transaction_id.(Do not include records where transaction_id is NULL.)
SELECT o.owner_id, t.pet_id, t.transaction_id, v.visits_count
FROM transactions AS t
LEFT OUTER JOIN owners AS o
ON t.pet_id = o.pet_id
LEFT OUTER JOIN visits AS v
ON t.pet_id = v.pet_id
WHERE transaction_id IS NOT NULL
ORDER BY transaction_id;

-- Query that returns pet_id and size from the owners table,and the visits_count (alias num_visits)from the visits table. 
-- Keep only the records where dogs had 10 or more visits, and sort by the number of visits in descending order.
SELECT o.pet_id, o.size, v.visits_count AS num_visits
FROM owners AS o
INNER JOIN visits AS v
ON o.pet_id = v.pet_id
WHERE visits_count >= 10
ORDER BY num_visits DESC;

-- List of all unique dog owners from both owners and owners_2 tables.
-- Return a single field that shows a list of owner_id records from both input tables, and order by owner_id. 
-- Keep only unique records.
SELECT owner_id
FROM owners
UNION
SELECT owner_id
FROM owners_2
ORDER BY owner_id;

-- We're having a customer rewards promotion, and we want to identify our top three customers (owner_id) 
-- based upon how many visits they've had.
-- Some owners have more than one pet, so add up all of their visits across all pets. 
-- List them in descending order according to number of visits (using the alias num_visits)
SELECT owner_id, SUM(visits_count) AS num_visits
FROM owners AS o
LEFT OUTER JOIN visits AS v
ON o.pet_id = v.pet_id
WHERE visits_count IS NOT NULL
GROUP BY owner_id
UNION
SELECT owner_id, SUM(visits_count) AS num_visits
FROM owners_2 AS o2
LEFT OUTER JOIN visits AS v
ON o2.pet_id = v.pet_id
WHERE visits_count IS NOT NULL
GROUP BY owner_id
ORDER BY num_visits DESC
LIMIT 3;

-- Query that returns owner_id from owners and owners_2 tables and include the transaction_id, date, and service fields from the transactions table. 
-- Sort your results first by date, then by transaction_id, and finally by owner_id in descending order. 
-- All rows from owners and owners_2 tables should be returned.(Do not include records where transaction_id is NULL)
SELECT o.owner_id, transaction_id, date, service
FROM owners AS o
LEFT OUTER JOIN transactions AS t
on o.pet_id = t.pet_id
WHERE transaction_id IS NOT NULL 
UNION ALL
SELECT o2.owner_id, transaction_id, date, service
FROM owners_2 AS o2
LEFT OUTER JOIN transactions AS t
on o2.pet_id = t.pet_id
WHERE transaction_id IS NOT NULL 
ORDER BY date, transaction_id, owner_id DESC;

-- Return a table that includes all records from owners and owners_2 tables, 
-- and include a new field, owner_pet which is formatted as owner_id, pet_id 
-- (in other words, the owner ID followed by a comma, then a space, then the pet ID).
-- Return only the rows where the number of visits is greater than or equal to 3. 
-- Sort the results by number of visits (largest to smallest)
-- If there's a tie in this number, sort by your newly created owner_petfield.
SELECT CONCAT(o.owner_id, ', ', o.pet_id) AS owner_pet, visits_count
FROM owners AS o
LEFT OUTER JOIN visits AS v
on o.pet_id = v.pet_id
WHERE visits_count >= 3 
UNION ALL
SELECT CONCAT(o2.owner_id, ', ', o2.pet_id) AS owner_pet, visits_count
FROM owners_2 AS o2
LEFT OUTER JOIN visits AS v
on o2.pet_id = v.pet_id
WHERE visits_count >= 3 
ORDER BY visits_count DESC, owner_pet;

-- Show the visit counts for each pet, and order the output from most to least visits. 
-- Include the owner_id, pet_id, and visits_count columns in your output
SELECT o.owner_id, o.pet_id, visits_count
FROM owners AS o
LEFT OUTER JOIN visits AS v
ON o.pet_id = v.pet_id
ORDER BY visits_count DESC;

-- Query that returns the owner_id, pet_id, date, and service for transactions that happened on June 17th, 2019, or 
-- for transactions where the service provided was a haircut. Order your results by date.
SELECT o.owner_id, o.pet_id, date, service
FROM owners AS o
LEFT OUTER JOIN transactions AS t
ON o.pet_id = t.pet_id
WHERE service = 'haircut'
	OR date = '2019-06-17'
ORDER BY date;

-- You have a promotion where you'd like to give a gift to those pets who have had their nails done at the salon.
-- Query that shows the pet_id and service for those pets that used the nails service from transactions. 
-- Then sort by those pets first who are receiving a gift.
SELECT pet_id, service,
CASE 
	WHEN service = 'nails' THEN 'gift'
	ELSE 'no gift' 
END AS get_gift
FROM transactions
ORDER BY get_gift;

-- The town where the dog salon is located had a street fair on June 17 and 18. 
-- The business owner wants to know how many transactions took place on those days
SELECT date, COUNT(*)
FROM transactions
WHERE date IN ('2019-06-17', '2019-06-18')
GROUP BY date;

-- Combine the owners and owners_2 tables first and then get a count for each of the three sizes of dogs, small, medium, and large. 
-- Then sort the list from smallest to largest. Your final output should show the size and count.
WITH all_owners AS(
	SELECT *
	FROM owners AS o
	UNION
	SELECT *
	FROM owners_2 AS o2
) 
SELECT a.size, COUNT(*) AS size_count
FROM all_owners AS a
GROUP BY size
ORDER BY size DESC;











