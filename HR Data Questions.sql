-- QUESTIONS

-- 1. What is the gender breakdown of employees in the company?
SELECT gender, COUNT(*) NO_of_Emp
FROM HR
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY 1;
SELECT gender, COUNT(*) NO_of_Emp
FROM HR
WHERE age >= 18 AND in_company = 'Yes'
GROUP BY 1;

-- 2. What is the race/ethnicity breakdown of employees in the company?
SELECT race, count(*) count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY  1
ORDER BY 2 DESC;
-- 3. What is the age distribution of employees in the company?
SELECT
	min(age) AS youngest,
    max(age) AS oldest
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00';

SELECT
	CASE
		WHEN age >=18 AND age <=24 THEN '18-24'
        WHEN age >=25 AND age <=34 THEN '25-34'
        WHEN age >=35 AND age <=44 THEN '35-44'
        WHEN age >=45 AND age <=54 THEN '45-54'
        WHEN age >=55 AND age <=64 THEN '55-64'
        ELSE '65+'
	END AS age_group,
    count(*) count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY 1 
ORDER BY 1;

SELECT
	CASE
		WHEN age >=18 AND age <=24 THEN '18-24'
        WHEN age >=25 AND age <=34 THEN '25-34'
        WHEN age >=35 AND age <=44 THEN '35-44'
        WHEN age >=45 AND age <=54 THEN '45-54'
        WHEN age >=55 AND age <=64 THEN '55-64'
        ELSE '65+'
	END AS age_group,
    gender,
    count(*) count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY 1,2 
ORDER BY 1,2;

-- 4. How many employees work at headquarters versus remote locations?
SELECT location, count(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY 1;

-- 5. What is the average length of employment for employees who have been terminated?
SELECT
	round(avg(datediff(termdate,hire_date))/365,2) AVG_legth_employment
FROM hr
WHERE termdate <= curdate() AND termdate <> '0000-00-00' AND age >= 18;


-- 6. How does the gender distribution vary across departments and job titles?

SELECT department, gender, COUNT(*) As count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY 1,2 
ORDER BY 1;

-- 7. What is the distribution of job titles across the company?
SELECT jobtitle,count(*) count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY 1
ORDER BY 1 DESC ;
-- 8. Which department has the highest turnover rate?
SELECT department,
		total_count,
        terminated_count,
        terminated_count/total_count AS terminated_rate
FROM (
SELECT department,
		count(*) total_count,
        SUM(CASE WHEN termdate <> '0000-00-00'AND termdate <= curdate() THEN 1 ELSE 0 END) terminated_count
FROM hr
WHERE age >=18
GROUP BY 1) AS subquary
ORDER BY 4 DESC;
        


-- 9. What is the distribution of employees across locations by city and state?
SELECT location_state,
        count(*) count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY 1
ORDER BY 2 DESC;


-- 10. How has the company's employee count changed over time based on hire and term dates?
SELECT year,
		hires,
        termination,
        hires - termination as net_change,
        round((hires - termination) / hires * 100,2) net_change_percent
FROM(
SELECT 
		year(hire_date) year,
        count(*) hires,
        SUM(CASE WHEN termdate <>'0000-00-00' AND termdate <= curdate() THEN 1 ELSE 0 END) termination
FROM hr
WHERE age >= 18
GROUP by 1
) temp
ORDER BY 1 ;

-- 11. What is the tenure distribution for each department?
SELECT department,
		round(avg(datediff(termdate,hire_date)/365),2) avg_tenure
FROM hr
WHERE termdate <= curdate() AND termdate <> '0000-00-00' AND age >= 18
GROUP BY 1