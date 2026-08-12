-- OPERATIONS & WORKFORCE SQL ANALYSIS
-- Database: PostgreSQL
-- Table: operations_data


-- =====================================================
-- 1. WORKFORCE OVERVIEW
-- =====================================================

-- Q1. Total Workforce Size
-- What is the total number of employees in the workforce?
SELECT COUNT(*) AS total_employees
FROM operations_data;


-- Q2. Workforce Distribution
-- How is the workforce distributed across different departments?
SELECT department,COUNT(*) AS employee_count
FROM operations_data
GROUP BY department
ORDER BY employee_count DESC;


-- Q3. Overall Productivity
-- What is the overall average productivity of the workforce?
SELECT AVG(productivity_pct) AS avg_productivity
FROM operations_data;


-- Q4. Workforce KPI Overview
-- What are the key workforce KPIs, including average productivity, training & overtime hours, and absenteeism?
SELECT AVG(productivity_pct) AS avg_productivity,
AVG(training_hours) AS avg_training_hours,
AVG(overtime_hours) AS avg_overtime_hours,
AVG(leaves) AS avg_leaves
FROM operations_data;


-- =====================================================
-- 2. DEPARTMENT PERFORMANCE
-- =====================================================

-- Q5. Department vs. Overall Performance
-- How does each department's average productivity compare with the overall workforce average?
SELECT department,
AVG(productivity_pct) AS avg_dept_productivity,
(SELECT AVG(productivity_pct) FROM operations_data) AS avg_overall_productivity
FROM operations_data
GROUP BY department;


-- Q6. Department Performance Ranking
-- Which departments are the highest and lowest performers based on average productivity?
SELECT department,AVG(productivity_pct) AS avg_productivity
FROM operations_data
GROUP BY department
ORDER BY avg_productivity DESC;


-- Q7. Department Absenteeism
-- Which departments have above-average absenteeism?
SELECT department,AVG(leaves) AS avg_leaves
FROM operations_data
GROUP BY department
HAVING AVG(leaves)>(SELECT AVG(leaves) FROM operations_data);


-- Q8. Working Hours by Department
-- How do average training and overtime hours differ across departments?
SELECT department,
AVG(training_hours) AS avg_training_hours,
AVG(overtime_hours) AS avg_overtime_hours
FROM operations_data
GROUP BY department;


-- Q9. Department Performance Gap
-- What is the productivity gap between the highest- and lowest-performing departments?
SELECT MAX(avg_productivity)-MIN(avg_productivity) AS productivity_gap
FROM (
SELECT department,AVG(productivity_pct) AS avg_productivity
FROM operations_data
GROUP BY department
) AS department_performance;


-- Q10. Department Workforce Risk
-- Which departments show a combination of below-average productivity and above-average absenteeism?
SELECT department,
AVG(leaves) AS avg_leaves,
AVG(productivity_pct) AS avg_productivity
FROM operations_data
GROUP BY department
HAVING AVG(productivity_pct)<(SELECT AVG(productivity_pct) FROM operations_data)
AND AVG(leaves)>(SELECT AVG(leaves) FROM operations_data);


-- =====================================================
-- 3. EMPLOYEE PERFORMANCE
-- =====================================================

-- Q11. Top Performers
-- Who are the top 10 employees based on productivity?
SELECT employee_name,productivity_pct
FROM operations_data
ORDER BY productivity_pct DESC
LIMIT 10;


-- Q12. Lowest Performers
-- Who are the bottom 10 employees based on productivity?
SELECT employee_name,productivity_pct
FROM operations_data
ORDER BY productivity_pct ASC
LIMIT 10;


-- Q13. Performance Distribution
-- Excellent: >=90%
-- Good: 75%-89.99%
-- Needs Improvement: <75%
SELECT CASE
WHEN productivity_pct>=90 THEN 'Excellent'
WHEN productivity_pct>=75 THEN 'Good'
ELSE 'Needs Improvement'
END AS performance_category,
COUNT(*) AS employee_count
FROM operations_data
GROUP BY performance_category;


-- Q14. Top Performers Within Departments
-- Who are the top 3 employees within each department based on productivity?
SELECT department,employee_name,productivity_pct
FROM (
SELECT department,employee_name,productivity_pct,
ROW_NUMBER() OVER(
PARTITION BY department
ORDER BY productivity_pct DESC
) AS rank
FROM operations_data
) AS ranked_employees
WHERE rank<=3;


-- Q15. Underperforming Employees
-- Which employees have productivity significantly below their department's average?
SELECT department,employee_name,productivity_pct
FROM (
SELECT department,employee_name,productivity_pct,
AVG(productivity_pct) OVER(PARTITION BY department) AS dept_avg
FROM operations_data
) AS employee_data
WHERE productivity_pct<dept_avg;


-- =====================================================
-- 4. WORKFORCE EFFICIENCY & RISK
-- =====================================================

-- Q16. Productivity vs. Working Hours
-- Which employees have below-average productivity despite working above-average overtime hours?
SELECT employee_name,productivity_pct,overtime_hours
FROM operations_data
WHERE productivity_pct<(SELECT AVG(productivity_pct) FROM operations_data)
AND overtime_hours>(SELECT AVG(overtime_hours) FROM operations_data);


-- Q17. Absenteeism & Productivity Risk
-- Which employees have both high absenteeism and low productivity?
SELECT employee_name,leaves,productivity_pct
FROM operations_data
WHERE leaves>(SELECT AVG(leaves) FROM operations_data)
AND productivity_pct<(SELECT AVG(productivity_pct) FROM operations_data);


-- Q18. High-Workload Risk
-- Which employees work significantly above the average overtime hours but do not demonstrate above-average productivity?
SELECT employee_name,productivity_pct,overtime_hours
FROM operations_data
WHERE overtime_hours>(SELECT AVG(overtime_hours) FROM operations_data)
AND productivity_pct<=(SELECT AVG(productivity_pct) FROM operations_data);


-- Q19. High Productivity & Low Absenteeism
-- Which employees demonstrate both high productivity and low absenteeism?
SELECT employee_name,productivity_pct,leaves
FROM operations_data
WHERE productivity_pct>(SELECT AVG(productivity_pct) FROM operations_data)
AND leaves<(SELECT AVG(leaves) FROM operations_data);


-- Q20. Workforce Risk Concentration
-- Which departments contain the highest proportion of employees requiring performance improvement?
SELECT department,
COUNT(*) FILTER(WHERE productivity_pct<75)*100.0/COUNT(*) AS risk_percentage
FROM operations_data
GROUP BY department
ORDER BY risk_percentage DESC;
