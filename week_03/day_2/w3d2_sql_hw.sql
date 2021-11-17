-- SQL Day 2 Lab and Homework

--MVP
--Q1A

SELECT
	e.first_name,
	e.last_name,
	t.id
FROM employees AS e INNER JOIN teams AS t
ON e.team_id  = t.id

--Q1B

SELECT
	e.first_name,
	e.last_name,
	t.id
FROM employees AS e INNER JOIN teams AS t
ON e.team_id  = t.id
WHERE e.pension_enrol = TRUE

--Q1C

SELECT
	e.first_name,
	e.last_name,
	t.id
FROM employees AS e INNER JOIN teams AS t
ON e.team_id = t.id
WHERE CAST (t.charge_cost AS INTEGER)> 80;

--Q2A

SELECT
	e.*,
	p.local_account_no,
	p.local_sort_code
FROM employees AS e LEFT JOIN pay_details AS p
ON e.pay_detail_id = p.id;

--Q2B

SELECT
	e.*,
	p.local_account_no,
	p.local_sort_code,
	t.name AS team_name
FROM ( employees AS e LEFT JOIN teams AS t
	ON e.team_id = t.id)
	LEFT JOIN pay_details AS p
ON e.pay_detail_id = p.id;


SELECT 
	e.*,
	p.local_account_no,
	p.local_sort_code,
	t.name AS team_name
FROM 
	(employees AS e LEFT JOIN teams AS t
	ON e.team_id = t.id)
LEFT JOIN pay_details AS p
ON e.pay_detail_id = p.id;

--Q3A

SELECT
	e.id,
	t.name AS team_name
FROM employees AS e LEFT JOIN teams AS t
ON e.team_id = t.id;

--Q3B

SELECT
	COUNT (e.id) AS number_employees,
	t.name AS team_name
FROM employees AS e LEFT JOIN teams AS t
ON e.team_id = t.id
GROUP BY t.name;

--Q3C

SELECT
	COUNT (e.id) AS number_employees,
	t.name AS team_name
FROM employees AS e LEFT JOIN teams AS t
ON e.team_id = t.id
GROUP BY t.name
ORDER BY  number_employees ASC

--Q4A

SELECT
	t.id,
	t.name,
	COUNT (t.id) AS number_employees
FROM employees AS e LEFT JOIN teams AS t
ON e.team_id = t.id
GROUP BY t.id

--Q4B
SELECT 
	COUNT(t.id) AS employee_sum,
	t.name AS team_id,
	CAST ( t.charge_cost AS int4 ) * COUNT(t.id) AS total_day_charge,
	t.charge_cost
FROM employees AS e LEFT JOIN teams AS t
ON e.team_id = t.id
--WHERE CAST ( t.charge_cost AS int4 ) 
GROUP BY t.id;

--Q4C

SELECT *
FROM (SELECT 
	COUNT(t.id) AS employee_sum,
	t.name AS team_id,
	CAST ( t.charge_cost AS int4 ) * COUNT(t.id) AS total_day_charge,
	t.charge_cost
FROM employees AS e LEFT JOIN teams AS t
ON e.team_id = t.id
GROUP BY t.id) AS b
WHERE b.total_day_charge > 5000;
