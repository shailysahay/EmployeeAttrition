/*
EMPLOYEEID, SATISFACTION_LEVEL, LAST_EVALUATION, NUMBER_OF_PROJECTS
AVG_MONTHLY_HOURS
TIME_SPEND_COMPANY
WORK_ACCIDENT
TURNOVER
PROMOTION_5YEARS
DEPARTMENT
SALARY_RANGE
*/

SELECT * FROM EmployeeAttrition
/

SELECT salary_range,turnover, count(*) 
FROM EmployeeAttrition
GROUP BY salary_range, turnover
ORDER BY turnover, salary_range
/


-- Employee Attrition Percentage

SELECT 
    ROUND((MAX((SELECT COUNT(*)
    FROM EmployeeAttrition e1
    WHERE turnover = 1))/ COUNT(*)) * 100,2) AS AttritionPercentage
FROM EmployeeAttrition e2
--GROUP BY 1

-- NOTE: Why we added Group By 2
-- Because subqueries are not treated as "constant"s by the compiler when it looks at aggregation queries (COUNT). 
-- So, it's like an expression which is not in the group by clause. SO it throws error
-- 2 ways to resolve:
--  1. Add GROUP BY the subquery column 'GROUP BY 1'
--  2. Add MAX on the subquery column
/


-- Breakdown of 'employee turnover count' by Salary Range

-- Using JOIN and Subquery

    SELECT TotalEmp.SALARY_RANGE,  ROUND((TurnoverEmpCount/TotalEmpCount)* 100,2) AS TurnoverPercentage
    FROM
        (SELECT SALARY_RANGE, count(turnover) as TotalEmpCount
        FROM EmployeeAttrition
        GROUP BY SALARY_RANGE) TotalEmp
    JOIN
        (SELECT SALARY_RANGE, count(turnover) as TurnoverEmpCount
        FROM EmployeeAttrition
        WHERE Turnover = 1
        GROUP BY SALARY_RANGE) TurnoverEmp
    ON  TotalEmp.SALARY_RANGE = TurnoverEmp.SALARY_RANGE
    
/

-- Using Partition By
SELECT  DISTINCT SALARY_RANGE, turnover, AttritionPercentage
FROM
    (SELECT SALARY_RANGE, turnover,
        ROUND((Count(*) OVER (PARTITION BY SALARY_RANGE, turnover)/ 
        (Count(*) OVER (PARTITION BY SALARY_RANGE)))* 100,2) 
        as AttritionPercentage
    FROM EmployeeAttrition)
WHERE turnover = 1

/



-- Using CTE and Partition By

WITH t1 AS 
 (SELECT SALARY_RANGE, turnover, Count(*) AS TurnoverEmpCount 
  FROM EmployeeAttrition
  GROUP BY SALARY_RANGE, turnover)
SELECT SALARY_RANGE, turnover, TurnoverEmpCount, 
       ROUND(((TurnoverEmpCount)/(SUM(TurnoverEmpCount) OVER (PARTITION BY SALARY_RANGE)))* 100,2) as AttritionPercentage -- no integer divide!
FROM t1;

/


SELECT SALARY_RANGE, Count(*) OVER (SALARY_RANGE) AS n 
        --(0.0+Count(*) OVER w_user_rating)/(Count(*) OVER (PARTITION BY User)) AS pct
FROM EmployeeAttrition
/

-- Breakdown of 'employee turnover count' by Satisfaction Range

WITH SatisfactionRangeTable as
(   
    SELECT EmployeeID,turnover,
        CASE 
            WHEN SATISFACTION_LEVEL >= 0.0 AND SATISFACTION_LEVEL <= 0.3 THEN 'low'
            WHEN SATISFACTION_LEVEL > 0.3 AND SATISFACTION_LEVEL <= 0.6 THEN 'medium'
            WHEN SATISFACTION_LEVEL > 0.6 AND SATISFACTION_LEVEL <= 1.0 THEN 'high'
            ELSE 'NA'
        END AS SatisfactionRange
    FROM EmployeeAttrition
)

SELECT DISTINCT SatisfactionRange, turnover,
    ROUND((Count(*) OVER (PARTITION BY SatisfactionRange, turnover)/ 
    (Count(*) OVER (PARTITION BY SatisfactionRange)))* 100,2) 
    AS SatisfactionAttritionPct
FROM SatisfactionRangeTable
ORDER BY turnover, SatisfactionRange

/
        
-- Count of employees based on Satisfaction range and turnover
WITH SatisfactionRangeTable as
(   
    SELECT EmployeeID,turnover,
        CASE 
            WHEN SATISFACTION_LEVEL >= 0.0 AND SATISFACTION_LEVEL <= 0.3 THEN 'low'
            WHEN SATISFACTION_LEVEL > 0.3 AND SATISFACTION_LEVEL <= 0.6 THEN 'medium'
            WHEN SATISFACTION_LEVEL > 0.6 AND SATISFACTION_LEVEL <= 1.0 THEN 'high'
            ELSE 'NA'
        END AS SatisfactionRange
    FROM EmployeeAttrition
)

SELECT cOUNT(*), SatisfactionRange, turnover
FROM SatisfactionRangeTable
GROUP BY SatisfactionRange, turnover
ORDER BY SatisfactionRange, turnover
/