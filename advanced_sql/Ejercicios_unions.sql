-- Ejercicios UNIONS --

/*
Get the corresponding skill and skill type for each job posting in q1
Includes those without any skills, too
Why? Look at the skills and the type for each job in the first quarter that has a salary >
$70000
*/

SELECT 
    quarter_1.job_id,
    skills_dim.skills,
    skills_dim.type,
    quarter_1.salary_year_avg,
    quarter_1.job_title_short
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
INNER JOIN skills_job_dim AS skills_job
    ON quarter_1.job_id = skills_job.job_id
INNER JOIN skills_dim 
    ON skills_job.skill_id = skills_dim.skill_id
WHERE
    salary_year_avg > 70000 AND
    job_title_short = 'Data Analyst'
ORDER BY
    salary_year_avg DESC


