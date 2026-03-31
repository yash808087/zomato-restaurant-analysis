CREATE DATABASE zomato_db;
USE zomato_db;

select * from zomato limit 5;

-- How many restaurants in each area?
SELECT
location,
COUNT(*) AS restaurant_count
FROM zomato
GROUP BY location
ORDER BY restaurant_count DESC
LIMIT 15;

--  Does online ordering affect votes/popularity?
SELECT
online_order,
COUNT(*) AS total_restaurants,ROUND(AVG(votes), 0) AS avg_votes
FROM zomato
GROUP BY online_order;

-- Which restaurant type is most common?
SELECT
    rest_type,
    COUNT(*) AS count,
    ROUND(AVG(votes), 0) AS avg_votes
FROM zomato
GROUP BY rest_type
ORDER BY avg_votes DESC
LIMIT 10;

-- Which cuisine is most popular?
SELECT
cuisines,
COUNT(*) AS restaurant_count,
ROUND(AVG(votes), 0) AS avg_votes
FROM zomato
GROUP BY cuisines
ORDER BY restaurant_count DESC
LIMIT 10;

-- Cost breakdown by category
SELECT
CASE
WHEN `approx_cost(for two people)` <= 200 THEN 'Budget (under 200)'
WHEN `approx_cost(for two people)` <= 500 THEN 'Mid Range (200-500)'
WHEN `approx_cost(for two people)` <= 1000 THEN 'Premium (500-1000)'
ELSE 'Luxury (1000+)'
END AS price_category,
COUNT(*) AS restaurant_count,
ROUND(AVG(votes), 0) AS avg_votes
FROM zomato
WHERE `approx_cost(for two people)` IS NOT NULL
GROUP BY price_category
ORDER BY restaurant_count DESC;

-- Table booking restaurants vs normal
SELECT
book_table,
COUNT(*) AS count,
ROUND(AVG(`approx_cost(for two people)`), 0) AS avg_cost,
ROUND(AVG(votes), 0) AS avg_votes
FROM zomato
GROUP BY book_table;

-- Online order + book table combo analysis
SELECT
online_order,
book_table,
COUNT(*) AS count,
ROUND(AVG(votes), 0) AS avg_votes
FROM zomato
GROUP BY online_order, book_table
ORDER BY avg_votes DESC;
