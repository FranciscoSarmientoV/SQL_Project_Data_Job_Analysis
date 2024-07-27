-- Ejercicios Subqueries and  CTEs --

-- Ejercicio #1 --

SELECT 
    number_of_skills.skill_id,
    skills_dim.skills,
    number_of_skills.total_skills
FROM 
    (SELECT 
        skill_id,
        COUNT(*) AS total_skills
    FROM 
        skills_job_dim
    GROUP BY
        skill_id
    ) AS number_of_skills
RIGHT JOIN
    skills_dim ON number_of_skills.skill_id = skills_dim.skill_id
ORDER BY
    total_skills DESC
LIMIT 5
;

-- Ejercicio #2 --
SELECT 
    company_id,
    total_jobs,
    CASE 
        WHEN total_jobs < 10 THEN 'Small'
        WHEN total_jobs BETWEEN 10 AND 50 THEN 'Medium'
        WHEN total_jobs > 50 THEN 'Large'
    END AS size_category
FROM(
    SELECT 
        company_id,
        COUNT(job_id) AS total_jobs
    FROM 
        job_postings_fact
    GROUP BY
        company_id
    ORDER BY
        company_id
    ) AS job_per_company
;