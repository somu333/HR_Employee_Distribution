--                   DATA CLEANING 

SELECT * FROM hr;

-- Changing column name 
ALTER TABLE hr
Change column ï»¿id emp_id varchar(20) NULL;
describe hr;
SELECT hire_date FROM hr;

-- Removing the safe mode to nodify the table
SET sql_safe_updates = 0;

-- Changing the date data type
UPDATE hr
SET birthdate = CASE 
WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
ELSE null
END;

-- Setting the datatype 
ALTER TABLE hr
modify column birthdate date;

UPDATE hr
SET hire_date = CASE 
WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
ELSE null
END;
SELECT hire_date FROM hr;

ALTER TABLE hr
modify column hire_date date;

SELECT termdate FROM hr ;

UPDATE hr
SET termdate = IF(termdate is not null AND termdate !='',date(str_to_date(termdate,'%Y-%m-%d %H:%i:%s UTC')),
'0000-00-00')
WHERE true;


SET sql_mode = 'ALLOW_INVALID_DATES';

ALTER TABLE hr
modify column termdate DATE;

UPDATE hr
SET termdate = IF(termdate IS NOT NULL AND termdate != '', date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')), '0000-00-00')
WHERE true;

DESC HR ; 

-- Adding an Age column

ALTER TABLE hr
ADD COLUMN Age INT;

-- Calculating the age from their DOB
UPDATE HR
SET Age = timestampdiff(YEAR,birthdate,CURDATE());

SELECT birthdate, age FROM HR ;
SELECT MIN(AGE) youngest,
MAX(AGE) oldest 
FROM hr;

SELECT * FROM HR
WHERE AGE < 18 ;

ALTER TABLE HR
ADD COLUMN In_company varchar(10);

UPDATE HR
SET In_company = IF(termdate like '0%', 'No','Yes') ;

SELECT in_company, count(in_company) FROM hr
GROUP by 1
having count(in_company)>1