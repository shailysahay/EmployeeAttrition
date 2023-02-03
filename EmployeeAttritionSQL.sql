/*

SQL Queries used for Tableau

*/



-- 1)
-- ########### Employee Attrition Percentage ############

SELECT 
    COUNT(*) AS Total_Employees, 
        MAX((SELECT COUNT(*) FROM EmployeeAttrition e1
        WHERE turnover = 1)) as Turnover_Employees,
        ROUND((MAX((SELECT COUNT(*)
        FROM EmployeeAttrition e1
        WHERE turnover = 1))/ COUNT(*)) * 100,2) AS Attrition_Percentage
FROM EmployeeAttrition e2
/



-- 2)
-- ########### Attrition Rate of employees based on Salary range and turnover ###########


-- Using JOIN and Subquery --

    SELECT TotalEmp.SALARY_RANGE,  ROUND((TurnoverEmpCount/TotalEmpCount)* 100,2) AS Attrition_Rate
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

-- Using Partition By --

SELECT  DISTINCT SALARY_RANGE, turnover, Attrition_Rate
FROM
    (SELECT SALARY_RANGE, turnover,
        ROUND((Count(*) OVER (PARTITION BY SALARY_RANGE, turnover)/ 
        (Count(*) OVER (PARTITION BY SALARY_RANGE)))* 100,2) 
        as Attrition_Rate
    FROM EmployeeAttrition)
WHERE turnover = 1

/


-- Using CTE and Partition By --

WITH t1 AS 
 (SELECT turnover, SALARY_RANGE, Count(*) AS Turnover_Count 
  FROM EmployeeAttrition
  GROUP BY SALARY_RANGE, turnover)
SELECT turnover,SALARY_RANGE, Turnover_Count, 
       ROUND(((Turnover_Count)/(SUM(Turnover_Count) OVER (PARTITION BY SALARY_RANGE)))* 100,2) as PercentEmployees -- no integer divide!
FROM t1
ORDER BY turnover, SALARY_RANGE;
/


-- 3)
-- ########### Attrition rate of employees based on Satisfaction range and turnover ###########


-- Creating 'Satisfaction Range' groups - 'high', 'medium', 'low'

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


-- Calculating attrition rate for each group

SELECT DISTINCT turnover, SatisfactionRange, 
    ROUND((Count(*) OVER (PARTITION BY SatisfactionRange, turnover)/ 
    (Count(*) OVER (PARTITION BY SatisfactionRange)))* 100,2) 
    AS PercentEmployees
FROM SatisfactionRangeTable
ORDER BY turnover, SatisfactionRange

/




-- 4)      
-- ########### Attrition Rate of employees based on Time spent in company and turnover ###########

SELECT TotalEmp.TIME_SPEND_COMPANY,  ROUND((TurnoverEmpCount/TotalEmpCount)* 100,2) AS Attrition_Rate
FROM
    (SELECT TIME_SPEND_COMPANY, count(turnover) as TotalEmpCount
    FROM EmployeeAttrition
    GROUP BY TIME_SPEND_COMPANY) TotalEmp
JOIN
    (SELECT TIME_SPEND_COMPANY, count(turnover) as TurnoverEmpCount
    FROM EmployeeAttrition
    WHERE Turnover = 1
    GROUP BY TIME_SPEND_COMPANY) TurnoverEmp
ON  TotalEmp.TIME_SPEND_COMPANY = TurnoverEmp.TIME_SPEND_COMPANY
/    




-- 5)
-- ########### Add 'Satisfaction range' column to the original table ###########

WITH SatisfactionRangeTable as
(   
    SELECT EMPLOYEEID, LAST_EVALUATION, NUMBER_OF_PROJECTS, AVG_MONTHLY_HOURS, 
    TIME_SPEND_COMPANY, WORK_ACCIDENT, TURNOVER, PROMOTION_5YEARS, DEPARTMENT, SALARY_RANGE,
        CASE 
            WHEN SATISFACTION_LEVEL >= 0.0 AND SATISFACTION_LEVEL <= 0.3 THEN 'low'
            WHEN SATISFACTION_LEVEL > 0.3 AND SATISFACTION_LEVEL <= 0.6 THEN 'medium'
            WHEN SATISFACTION_LEVEL > 0.6 AND SATISFACTION_LEVEL <= 1.0 THEN 'high'
            ELSE 'NA'
        END AS SatisfactionRange
    FROM EmployeeAttrition
)

SELECT * FROM SatisfactionRangeTable
/

