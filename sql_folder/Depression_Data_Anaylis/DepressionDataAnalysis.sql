/*
CREATED BY: Brandy Nolan
CREATED ON: August 3, 2024
DESCRIPTION: A Comprehensive Kaggle dataset for Analyzing Health, Lifestyle, and Socio-Economic Fact of individuals with depression.
*/

-- EDA: Socioeconomic Status
-- Average age in the depression_data 
SELECT 
	ROUND(AVG(`Age`),0) avg_age
FROM 
	`depression`.`depression_data`;

-- Percentage distribution of different `Education Level` in the depression_data 
SELECT 
	`Education Level`,
    COUNT(*) total,
    CONCAT(ROUND(COUNT(`Education Level`) * 100.0 / SUM(COUNT(`Education Level`)) OVER (), 2),"%") education_level_percentage
FROM 
	`depression`.`depression_data`
GROUP BY
	`Education Level`
ORDER BY 2 DESC;

-- View of the marital status distribution in the dataset. 
SELECT
	`Marital Status`,
    ROUND(AVG(`Number of Children`),2) avg_num_of_child,
    COUNT(*) marital_status_count,
    CONCAT(ROUND(COUNT(`Marital Status`) * 100.0 / SUM(COUNT(`Marital Status`)) OVER (), 2),"%") martital_status_percentage
FROM 
	`depression`.`depression_data`
GROUP BY
	`Marital Status`
ORDER BY 3 DESC;

-- Average income associated with different employment statuses in the dataset.
SELECT 
	`Employment Status`,
    CONCAT("$ ", ROUND(AVG(`Income`),0)) avg_income
FROM 
	`depression`.`depression_data`
GROUP BY
	`Employment Status`;
    
-- An insignificant negative  relationship between Income and Age in the dataset
SELECT 
    (SUM((Income - avg_income) * (Age - avg_age)) / COUNT(*)) / 
    (STDDEV(Income) * STDDEV(Age)) AS corr_income_age
FROM (
    SELECT 
        Income, 
        Age, 
        AVG(Income) OVER () AS avg_income,
        AVG(Age) OVER () AS avg_age
    FROM 
        `depression`.`depression_data`
) AS subquery;

-- EDA: Risk factors and analysis
-- Percentage of each alchol consumption category within each age group
WITH age_grp AS (SELECT
	*,
    CASE
    WHEN `Age` BETWEEN 80 AND 89 THEN "80-89"
    WHEN `Age` BETWEEN 70 AND 79 THEN "70-79"
    WHEN `Age` BETWEEN 60 AND 69 THEN "60-69"
    WHEN `Age` BETWEEN 50 AND 59 THEN "50-59"
    WHEN `Age` BETWEEN 40 AND 49 THEN "40-49"
    WHEN `Age` BETWEEN 30 AND 39 THEN "30-39"
    WHEN `Age` BETWEEN 20 AND 29 THEN "20-29"
	ELSE "< 20"
    END AS age_groups
FROM 
	`depression`.`depression_data`
)
SELECT
	age_groups,
    `Alcohol Consumption`,
	COUNT(*) total,
	CONCAT(ROUND(COUNT(`Alcohol Consumption`) * 100.0 / SUM(COUNT(`Alcohol Consumption`)) OVER (PARTITION BY age_groups), 2),"%") activity_agegrp_percentage
FROM 
	age_grp
GROUP BY 
	age_groups,
    `Alcohol Consumption`
ORDER BY 1,2 ;

-- Percentage of each physical activity level within each age group
WITH age_grp AS (SELECT
	*,
    CASE
    WHEN `Age` BETWEEN 80 AND 89 THEN "80-89"
    WHEN `Age` BETWEEN 70 AND 79 THEN "70-79"
    WHEN `Age` BETWEEN 60 AND 69 THEN "60-69"
    WHEN `Age` BETWEEN 50 AND 59 THEN "50-59"
    WHEN `Age` BETWEEN 40 AND 49 THEN "40-49"
    WHEN `Age` BETWEEN 30 AND 39 THEN "30-39"
    WHEN `Age` BETWEEN 20 AND 29 THEN "20-29"
	ELSE "< 20"
    END AS age_groups
FROM 
	`depression`.`depression_data`
)
SELECT
	age_groups,
    `Physical Activity Level`,
	CONCAT(ROUND(COUNT(`Physical Activity Level`) * 100.0 / SUM(COUNT(`Physical Activity Level`)) OVER (PARTITION BY age_groups), 2),"%") alcohol_agegrp_percentage
FROM 
	age_grp
GROUP BY 
	age_groups,
    `Physical Activity Level`
ORDER BY 1,2 ;

--  Distribution of sleep patterns across different alcohol consumption categories
SELECT
    `Alcohol Consumption`,
    `Sleep Patterns`,
    COUNT(*) AS total,
    CONCAT(ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2), "%") AS overall_percentage,
    CONCAT(ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY `Alcohol Consumption`), 2), "%") AS within_group_percentage
FROM 
    `depression`.`depression_data`
GROUP BY 
    `Alcohol Consumption`, `Sleep Patterns`
ORDER BY 
    `Alcohol Consumption`, `Sleep Patterns`;



