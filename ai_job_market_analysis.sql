-- Q.1: How many AI job postings were published each month?
SELECT 
  DATE_FORMAT(posting_date, '%Y-%m') AS month,
  COUNT(*) AS job_postings
FROM ai_job_dataset
GROUP BY month
ORDER BY month
;

-- Q.2: Which countries are hiring the most for AI roles?
SELECT company_location, COUNT(company_location) AS job_postings
FROM ai_job_dataset
GROUP BY company_location
ORDER BY job_postings DESC
;

-- Q.3: Which companies are posting the highest number of AI jobs?
SELECT company_name, COUNT(*) AS job_postings
FROM ai_job_dataset
GROUP BY company_name
ORDER BY job_postings DESC
;

-- Q.4: How has the demand for AI jobs changed from 2024 to 2025?
SELECT YEAR(posting_date) as year, COUNT(*) AS job_postings
FROM ai_job_dataset
GROUP BY year
ORDER BY year
;

-- Q.5: Which experience levels are most in demand?
SELECT experience_level, COUNT(experience_level) AS job_postings
FROM ai_job_dataset
GROUP BY experience_level
ORDER BY job_postings DESC
;

-- Q.6: What are the most common AI job titles?
SELECT job_title, COUNT(job_title) AS job_postings
FROM ai_job_dataset
GROUP BY job_title
ORDER BY job_postings DESC
;
  
-- Q.7: Which job titles are growing the fastest over time?
SELECT 
  j25.job_title,
  j24.jobs_2024,
  j25.jobs_2025,
  (j25.jobs_2025 - j24.jobs_2024) AS growth
FROM
  (SELECT job_title, COUNT(*) AS jobs_2025
   FROM ai_job_dataset
   WHERE YEAR(posting_date) = 2025
   GROUP BY job_title) AS j25
JOIN
  (SELECT job_title, COUNT(*) AS jobs_2024
   FROM ai_job_dataset
   WHERE YEAR(posting_date) = 2024
   GROUP BY job_title) AS j24
ON j25.job_title = j24.job_title
ORDER BY growth DESC;

-- Q.8: Which countries are offering the most remote AI jobs?
SELECT 
  company_location,
  SUM(remote_ratio = 100) AS remote_jobs,
  ROUND(SUM(remote_ratio = 100) * 100 / COUNT(*), 2) AS remote_percentage
FROM ai_job_dataset
GROUP BY company_location
ORDER BY remote_percentage DESC
;

-- Q.9: Which country offers the highest average salary?
SELECT 
  company_location, 
  ROUND(AVG(salary_usd), 2) AS avg_salary
FROM ai_job_dataset
GROUP BY company_location
ORDER BY avg_salary DESC
;

-- Q.10: Is there a relationship between remote work and salary?
SELECT 
  remote_ratio,
  ROUND(AVG(salary_usd), 2) AS avg_salary
FROM ai_job_dataset
GROUP BY remote_ratio
ORDER BY avg_salary DESC
;