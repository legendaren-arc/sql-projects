/*
==========================================
Baby Names Analysis
- Identify most popular names
- Rank top 10 names by gender
- Analyze gender-neutral names
- Compare popularity changes over time
==========================================
*/

SELECT *
FROM baby_names;

-- ==========================================
-- a. Most popular baby name for each gender overall
-- ==========================================

WITH totals AS (
	SELECT sex, first_name, SUM(num) AS total_babies
    FROM baby_names
    GROUP BY sex, first_name
),
max_total AS (
	SELECT sex, MAX(total_babies) AS max_num
    FROM totals
    GROUP BY sex
) 
SELECT 
	t.sex,
    t.first_name,
    t.total_babies
FROM totals AS t
JOIN max_total AS m
ON t.sex = m.sex AND t.total_babies = m.max_num
ORDER BY t.sex;


-- =============================================
-- b. Top 10 most popular female baby names
-- =============================================

SELECT
  RANK() OVER (ORDER BY total_names DESC) AS name_rank,
  first_name,
  total_names
FROM (
  SELECT
    first_name,
    SUM(num) AS total_names
  FROM
   baby_names
  WHERE sex = 'F'
  GROUP BY
    first_name
) AS ranked_names
ORDER BY
  name_rank
LIMIT 10;

-- =============================================
-- c. Top 10 most popular male baby names
-- =============================================
SELECT 
	RANK() OVER(ORDER BY total_names DESC) AS name_rank,
    first_name,
    total_names
FROM (
	SELECT 
    first_name, 
    SUM(num) total_names
    FROM baby_names
    WHERE sex = 'M'
	GROUP BY first_name 
    ) AS ranked_names
ORDER BY 
	name_rank
LIMIT 10;

-- =============================================
-- d. Female names that appeared in both 1920 and 2020
-- =============================================

WITH names_1920 AS (
    SELECT first_name, num
    FROM baby_names
    WHERE year = 1920 AND sex = 'F'
),
names_2020 AS (
    SELECT first_name, num
    FROM baby_names
    WHERE year = 2020 AND sex = 'F'
)
SELECT 
    a.first_name,
    (a.num + b.num) AS total_occurrences
FROM names_1920 a
JOIN names_2020 b
    ON a.first_name = b.first_name;

-- =============================================
-- f. First five names alphabetically and classify as "Classic" or "Trendy"	
-- =============================================
SELECT 
	first_name,
	SUM(num) AS total_babies,
	CASE WHEN COUNT(first_name) > 10 THEN 'Trendy'
	ELSE 'Classic' END AS popularity_type
FROM baby_names
GROUP BY first_name
ORDER BY first_name ASC
LIMIT 5;

-- =============================================
-- g. Common female and male names each year
-- =============================================
WITH female_names AS (
	SELECT year, 
		first_name,
        SUM(num) AS total_babies,
        RANK() OVER(PARTITION BY year ORDER BY SUM(num) DESC) AS rnk
        FROM baby_names
        WHERE sex = 'F'
        GROUP BY year, first_name
),
male_names AS (
	SELECT year,
    first_name, 
    SUM(num) AS total_babies,
    RANK() OVER(PARTITION BY year ORDER BY SUM(num) DESC) AS rnk
    FROM baby_names
    WHERE sex = 'M'
    GROUP BY year, first_name
)
SELECT 
	f.year,
    f.first_name AS common_female_names,
    m.first_name AS common_male_names
FROM female_names AS f
JOIN male_names AS m
ON f.year = m.year
WHERE f.rnk = 1 AND m.rnk = 1
ORDER BY f.year ASC; 

-- =============================================
-- h. Gender-neutral baby names
-- =============================================

SELECT 
	a.first_name AS gender_neutral_names, 
    SUM(a.num + b.num) AS total_babies
FROM baby_names a 
JOIN baby_names b 
ON a.first_name = b.first_name
	AND a.sex <> b.sex
GROUP BY gender_neutral_names
ORDER BY total_babies DESC;

-- =============================================
-- i. Name popularity from first to last appearance	
-- =============================================
WITH first_appearance AS (
    SELECT
        first_name,
        MIN(year) AS start_year
    FROM baby_names
    GROUP BY first_name
),
total_in_start_year AS (
    SELECT
        b.first_name,
        SUM(b.num) AS total_count_start
    FROM baby_names b
    JOIN first_appearance f
      ON b.first_name = f.first_name AND b.year = f.start_year
    GROUP BY b.first_name
),
last_appearance AS (
    SELECT
        first_name,
        MAX(year) AS end_year
    FROM baby_names
    GROUP BY first_name
),
total_in_end_year AS (
    SELECT
        b.first_name,
        SUM(b.num) AS total_count_end
    FROM baby_names b
    JOIN last_appearance l
      ON b.first_name = l.first_name AND b.year = l.end_year
    GROUP BY b.first_name
)
SELECT
    start.first_name,
    start.total_count_start,
    finish.total_count_end,
    CASE 
		WHEN start.total_count_start < finish.total_count_end THEN 'Increased Popularity'
		WHEN start.total_count_start > finish.total_count_end THEN 'Decreased Popularity'
		WHEN start.total_count_start = finish.total_count_end THEN 'No Change'
    ELSE 'New Names' END AS popularity
FROM total_in_start_year start
JOIN total_in_end_year finish
  ON start.first_name = finish.first_name
ORDER BY start.total_count_start DESC;



