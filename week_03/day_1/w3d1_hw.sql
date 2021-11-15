/* MVP */
/* Q1 */

SELECT *
FROM employees
WHERE department = 'Human Resources'

/* MVP */
/* Q2 */

SELECT
	first_name,
	last_name,
	country,
	department
FROM employees
WHERE department = 'Legal';


/* MVP */
/* Q3 */

SELECT 
	COUNT(*) AS employees_in_portugal
FROM employees
WHERE country = 'Portugal';

/* MVP */
/* Q4 */

SELECT 
	COUNT(employees) AS portugal_and_spain_employees
FROM employees
WHERE country = 'Portugal' OR country = 'Spain';

/* MVP */
/* Q5 */

SELECT
	COUNT(id) AS missing_account_no
FROM pay_details
WHERE local_account_no IS NULL;

/* MVP */
/* Q6 */

SELECT*
FROM pay_details
WHERE local_account_no IS NULL AND iban IS NULL;

/* MVP */
/* Q7 */

SELECT
	first_name,
	last_name
FROM employees
ORDER BY last_name ASC NULLS LAST;

/* MVP */
/* Q8 */

SELECT 
	first_name,
	last_name,
	country
FROM employees
ORDER BY 
	country ASC NULLS LAST,
	last_name ASC NULLS LAST;

/* MVP */
/* Q9 */

SELECT *
FROM employees
ORDER BY salary DESC NULLS LAST
LIMIT 10;

/* MVP */
/* Q10 */

SELECT
	first_name,
	last_name,
	salary
FROM employees
WHERE country = 'Hungary'
ORDER BY salary ASC NULLS LAST
LIMIT 1;

/* MVP */
/* Q11 */

SELECT 
	COUNT(*)
FROM employees
WHERE first_name LIKE '^F%';
	
/* MVP */
/* Q12 */

SELECT*
FROM employees
WHERE email LIKE '%yahoo%';

/* MVP */
/* Q13 */

SELECT
	COUNT(*)
FROM employees
WHERE country NOT IN ('France', 'Germany') AND
		pension_enrol = TRUE
		
/* MVP */
/* Q14 */
		
SELECT salary
FROM employees
WHERE department = 'Engineering' AND
	fte_hours = '1'
ORDER BY salary DESC NULLS LAST
LIMIT 1;

/* MVP */
/* Q15 */

SELECT 
  first_name,  
  last_name,
  fte_hours,
  salary,
  fte_hours * salary AS effective_yearly_salary
FROM employees;

/* Extension */
/* Q16 */

SELECT 
	first_name || ' ' || last_name || ' - ' || department AS badge_label
FROM employees
WHERE
	first_name IS NOT NULL AND
	last_name IS NOT NULL AND
	department IS NOT NULL

