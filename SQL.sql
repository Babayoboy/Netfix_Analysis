SELECT * FROM movies;
SELECT * FROM genre;
-- Top 5 most popular Movies/TV Shows
SELECT title, popularity, vote_average, vote_count 
FROM movies 
ORDER BY popularity DESC 
LIMIT(5);

-- Newest 
SELECT title, release_date 
FROM movies 
ORDER BY release_date DESC;

-- AVG popularity, and rating
SELECT 
	ROUND(AVG(popularity)::numeric, 2) AS average_poularity, 
	ROUND(AVG(vote_average)::numeric, 2) AS average_rating 
FROM movies;

-- More liked moves movies (more popular than avg and have more rating than avg)
SELECT title, popularity, vote_average 
FROM movies ,
(SELECT 
	ROUND(AVG(popularity)::numeric, 2) AS average_poularity, 
	ROUND(AVG(vote_average)::numeric, 2) AS average_rating 
FROM movies)
WHERE average_poularity < popularity AND average_rating < vote_average;

-- How many movies where relesed each year
SELECT 
	EXTRACT(YEAR FROM release_date::DATE), 
	COUNT(title) AS movies_made
From movies 
GROUP BY EXTRACT(YEAR FROM release_date::DATE)
ORDER BY movies_made DESC; 

-- Find the total number of titles, the average Popularity, and the average Vote_Average for each Original_Language. 
-- Only include languages that have at least 10 titles in the dataset.
SELECT 
	COUNT(title) AS total_title,
	ROUND(AVG(popularity)::numeric, 2) AS average_poularity, 
	ROUND(AVG(vote_average)::numeric, 2) AS average_rating,
	original_language
FROM movies 
GROUP BY original_language
HAVING COUNT(title) >= 10
ORDER BY COUNT(title) DESC;

-- Write a query to find all titles that are explicitly classified as a "Comedy"

SELECT  title From movies 
WHERE comedy = 'Yes';

-- Or
SElECT title FROM genre WHERE genre LIKE '%Comedy%';

-- find the top 3 highest-rated titles (Vote_Average) for each Original_Language. 
-- Filter out languages that have fewer than 5 total titles to keep the results clean.
WITH ranks AS(
SELECT title,vote_average,original_language, ROW_NUMBER() OVER (PARTITION BY original_language ORDER BY vote_average) AS rank_no
FROM movies
)

SELECT title,vote_average,original_language from ranks WHERE rank_no <= 3;





