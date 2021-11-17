-- MVP
--Q1

SELECT
	COUNT(id)
FROM employees
WHERE grade IS NULL AND salary IS NULL;

--MVP
--Q2

SELECT
	department,
	CONCAT (first_name, ' ', last_name) AS full_name
FROM employees
ORDER BY department, last_name;

-- MVP
--Q3

SELECT *
FROM employees
WHERE last_name LIKE 'A%'
ORDER BY salary DESC NULLS LAST
LIMIT 10;

--MVP
--Q4

SELECT
	department,
	COUNT(id)
FROM employees
WHERE start_date BETWEEN '2003-01-01' AND '2003-12-31'
GROUP BY department;

--MVP
--Q5

SELECT
	department,
	fte_hours,
	COUNT(*) AS num_employees
FROM employees
GROUP BY department, fte_hours
ORDER BY fte_hours ASC;

--MVP
--Q6

SELECT
	pension_enrol,
	COUNT(*)
FROM employees
GROUP BY pension_enrol;

--MVP
--Q7

SELECT*
FROM employees
WHERE department = 'Accounting' AND pension_enrol IS FALSE
ORDER BY salary DESC NULLS LAST
LIMIT 1;

--MVP
--Q8

SELECT
	country,
	COUNT(id) AS num_employees,
	ROUND(AVG(salary)) AS avg_salary
FROM employees
GROUP BY country
HAVING COUNT(id) > 30
ORDER BY avg_salary DESC

--MVP
--Q9	

SELECT 
  first_name,
  last_name,
  fte_hours,
  salary,
  fte_hours * salary AS effective_yearly_salary
FROM employees 
WHERE fte_hours * salary > 30000

--MVP
--Q10

SELECT 
  e.*,
  t.name AS team_name
FROM employees AS e
INNER JOIN teams AS t
ON e.team_id = t.id
WHERE t.name IN ('Data Team 1', 'Data Team 2')

--MVP
--Q11

SELECT 
  e.first_name,
  e.last_name
FROM employees AS e LEFT JOIN pay_details AS pd
ON e.pay_detail_id = pd.id
WHERE pd.local_tax_code IS NULL;

--MVP
--Q12

SELECT 
  e.id,
  e.first_name, 
  e.last_name, 
  (48 * 35 * CAST(t.charge_cost AS INT) - e.salary)*e.fte_hours AS expected_profit
FROM employees AS e INNER JOIN teams AS t
ON e.team_id = t.id


--MVP
--Q13

WITH fte_count AS (
    SELECT
        fte_hours,
        COUNT(*) AS count
    FROM employees
    GROUP BY fte_hours
),
min_fte_count AS (
    SELECT 
        MIN(count) AS min_count
    FROM fte_count
),
most_common_fte AS (
    SELECT
        fte_hours
    FROM fte_count 
    WHERE count = (
        SELECT 
          min_count 
        FROM min_fte_count
    )
)
SELECT
	first_name,
	last_name,
	salary
FROM employees
WHERE country = 'Japan' AND fte_hours IN (
    SELECT
        fte_hours 
    FROM most_common_fte
)
ORDER BY salary
LIMIT 1

--MVP
--Q14

SELECT
	department,
	COUNT(id) AS employees_missing_first_name
FROM employees
WHERE first_name IS NULL
GROUP BY department
HAVING count(id) > 1
ORDER BY count(id) DESC, department

--MVP
--Q15

SELECT
	first_name,
	COUNT(id)
FROM employees
WHERE first_name IS NOT NULL
GROUP BY first_name 
HAVING COUNT(id) > 1
ORDER BY COUNT(id) DESC, first_name ASC

--MVP
--Q16

SELECT
	department,
	CAST(SUM(CAST(grade = 1 AS INT)) / CAST(COUNT(id) AS REAL) AS DECIMAL(5,4)) AS prop_grade_1
FROM employees
GROUP BY department

