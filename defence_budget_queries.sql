
-- 1. View all data
SELECT * FROM cleaned_defence_data;

-- 2. View limited rows (top 5 rows)
SELECT * FROM cleaned_defence_data
LIMIT 5;

-- 3. View specific columns
SELECT 
    c3 AS Scheme,
    CAST(c6 AS REAL) AS Budget_2015_2016,
    CAST(c14 AS REAL) AS Budget_2016_2017
FROM cleaned_defence_data;

-- 4. List unique values (Distinct Descriptions)
SELECT DISTINCT c2 AS Unique_Descriptions
FROM cleaned_defence_data;

-- 5. Use WHERE to filter rows (where revised budget is greater than original)
SELECT 
    c3 AS Scheme,
    CAST(c6 AS REAL) AS Budget_2015_2016,
    CAST(c7 AS REAL) AS Revised_2015_2016
FROM cleaned_defence_data
WHERE CAST(c7 AS REAL) > CAST(c6 AS REAL);

-- 6. Combine conditions with AND/OR
SELECT 
    c3 AS Scheme,
    CAST(c6 AS REAL) AS Budget_2015_2016,
    CAST(c14 AS REAL) AS Budget_2016_2017
FROM cleaned_defence_data
WHERE CAST(c6 AS REAL) > 5000 AND CAST(c14 AS REAL) > 10000;

-- 7. Sort results in descending order (by budget increase)
SELECT 
    c3 AS Scheme,
    CAST(c6 AS REAL) AS Budget_2015_2016,
    CAST(c14 AS REAL) AS Budget_2016_2017,
    (CAST(c14 AS REAL) - CAST(c6 AS REAL)) AS Increase
FROM cleaned_defence_data
ORDER BY Increase DESC
LIMIT 5;

-- 8. Count total number of rows
SELECT COUNT(*) AS Total_Rows
FROM cleaned_defence_data;

-- 9. Aggregate: Sum, Avg, Max, Min of 2016 Budget
SELECT 
    SUM(CAST(c14 AS REAL)) AS Total_2016,
    AVG(CAST(c14 AS REAL)) AS Average_2016,
    MAX(CAST(c14 AS REAL)) AS Max_2016,
    MIN(CAST(c14 AS REAL)) AS Min_2016
FROM cleaned_defence_data;

-- 10. Group and aggregate by Description
SELECT 
    c2 AS Description,
    COUNT(*) AS Count_Entries,
    SUM(CAST(c14 AS REAL)) AS Total_2016_Budget
FROM cleaned_defence_data
GROUP BY c2
ORDER BY Total_2016_Budget DESC;

-- 11. Rename columns in result using AS
SELECT 
    c2 AS Description, 
    CAST(c14 AS REAL) AS Budget_2016_2017
FROM cleaned_defence_data
ORDER BY Budget_2016_2017 DESC
LIMIT 5;

-- 12. Conditional logic using CASE WHEN
SELECT 
    c3 AS Scheme,
    CAST(c6 AS REAL) AS Budget_2015_2016,
    CASE 
        WHEN CAST(c6 AS REAL) > 10000 THEN 'High Budget'
        WHEN CAST(c6 AS REAL) BETWEEN 5000 AND 10000 THEN 'Medium Budget'
        ELSE 'Low Budget'
    END AS Budget_Category
FROM cleaned_defence_data;

-- 13. Subquery to get schemes with highest 2016 budget compared to average
SELECT 
    c3 AS Scheme,
    CAST(c14 AS REAL) AS Budget_2016_2017
FROM cleaned_defence_data
WHERE CAST(c14 AS REAL) > (
    SELECT AVG(CAST(c14 AS REAL))
    FROM cleaned_defence_data
)
ORDER BY Budget_2016_2017 DESC;
