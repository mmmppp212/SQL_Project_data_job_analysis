/* 
Label new column as follows based on job_location:
- 'Anywhere' jobs as 'Remote'
- 'New York, NY' jobs as  'Local'
- Otherwise 'Onsite'
*/

SELECT 
	COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM 
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    location_category
ORDER BY    
    number_of_jobs DESC;


--- Practice ---
SELECT
    job_id,
    job_location,
    salary_year_avg,
    CASE
        WHEN salary_year_avg > 150000 THEN 'high'
        WHEN salary_year_avg BETWEEN 100000 AND 150000 THEN 'standard'
        ELSE 'low'
    END AS salary_catagory
FROM job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC;