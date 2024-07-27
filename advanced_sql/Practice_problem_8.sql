/*
Find job postings from the first quarter that have a salary greater than $70K
Combine job posting tables from the first quarter of 2023 (Jan-Mar)
Gets job postings with an average yearly salary > $70,000
*/

SELECT 
    job_title_short,
    salary_year_avg,
    job_via,
    job_posted_date::DATE
FROM (
    SELECT *
    FROM
        january_jobs
    UNION ALL
    SELECT *
    FROM
        february_jobs
    UNION ALL
    SELECT *
    FROM
        march_jobs
) AS quarter_1
WHERE 
    salary_year_avg > 70000 AND
    job_title_short = 'Data Analyst'
ORDER BY
    salary_year_avg DESC
;


