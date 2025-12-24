/*
Look at companies that don’t require a degree 
- Degree requirements are in the job_posting_fact table
- Use subquery to filter this in the company_dim table for company_names
- Order by the company name alphabetically
*/
SELECT
    company_id,
    name AS company_name 
FROM 
    company_dim
WHERE company_id IN (
    SELECT 
            company_id
    FROM 
            job_postings_fact 
    WHERE 
            job_no_degree_mention = true
    ORDER BY
            company_id
)
ORDER BY
    name ASC

/*
Find the companies that have the most job openings. 
- Get the total number of job postings per company id (job_posting_fact)
- Return the total number of jobs with the company name (company_dim)
*/

WITH company_job_count AS (
    SELECT 
            company_id,
            COUNT(*) AS total_jobs
    FROM 
            job_postings_fact 
    GROUP BY
            company_id
)

SELECT 
    company_dim.name AS company_name,
    company_job_count.total_jobs
FROM 
    company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY
    total_jobs DESC


--- Practice ---
--(1)
SELECT
    skills_dim.skills AS skill_name,
    skill_stats.skill_occurence
FROM (
    SELECT
        skill_id,
        COUNT(job_id) AS skill_occurence
    FROM skills_job_dim
    GROUP BY skill_id
    ORDER BY skill_occurence DESC
    LIMIT 5
) AS skill_stats
INNER JOIN skills_dim ON skill_stats.skill_id = skills_dim.skill_id;

--(2)
WITH job_counts AS (
    SELECT company_id, COUNT(job_id) AS job_count
    FROM job_postings_fact
    GROUP BY company_id
    ORDER BY company_id
)
SELECT
    *,
    CASE
        WHEN job_count < 10 THEN 'Small'
        WHEN job_count BETWEEN 10 AND 50 THEN 'Medium'
        ELSE 'Large'
    END AS company_size
FROM job_counts;