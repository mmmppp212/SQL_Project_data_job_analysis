SELECT 
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs

UNION ALL

SELECT 
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs

UNION ALL

SELECT 
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs;


WITH q1_jobs AS (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
)

SELECT q1.job_title_short, s.skills, s.type
FROM q1_jobs AS q1
LEFT JOIN skills_job_dim AS sj ON q1.job_id = sj.job_id
LEFT JOIN skills_dim AS s ON sj.skill_id = s.skill_id
WHERE q1.salary_year_avg > 70000
ORDER BY q1.salary_year_avg DESC;