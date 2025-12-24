SELECT
    job_title_short,
    job_location,
	job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time
FROM
    job_postings_fact;

SELECT
	job_title_short,
	job_location,
	EXTRACT(MONTH FROM job_posted_date) AS job_posted_month,
	EXTRACT(YEAR FROM job_posted_date) AS job_posted_year
FROM
	job_postings_fact;

SELECT
    COUNT(job_id) AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date) AS job_posted_month
FROM
	job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    job_posted_month
ORDER BY
    job_posted_count DESC;


--- Practice ---
--(1)
SELECT
job_schedule_type,
AVG(salary_year_avg) avg_year_salary,
AVG(salary_hour_avg) avg_hour_salary
FROM
job_postings_fact
WHERE
job_posted_date > '2023-06-01'
GROUP BY
job_schedule_type;

--(2)
SELECT
    EXTRACT (MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS month,
    COUNT(job_id) AS job_posted_count
FROM
    job_postings_fact
WHERE
    EXTRACT(YEAR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') = 2023
GROUP BY
    month
ORDER BY
    month;

--(3)
SELECT DISTINCT
c.name,
j.job_posted_date,
j.job_health_insurance
FROM
company_dim c
INNER JOIN job_postings_fact j
ON c.company_id = j.company_id
WHERE
j.job_health_insurance = True
AND (EXTRACT(YEAR FROM j.job_posted_date) = 2023 AND EXTRACT(QUARTER FROM j.job_posted_date) = 2);