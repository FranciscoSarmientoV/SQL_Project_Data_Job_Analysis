-- Ejercicio #1 --

SELECT 
    COUNT(job_id),
    CASE
        WHEN salary_year_avg >= 80000 THEN 'HIGH'
        WHEN salary_year_avg BETWEEN 60000 AND 79999 THEN 'STANDARD'
        WHEN salary_year_avg <= 60000 THEN 'LOW'
    END AS salary_category
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    salary_category
ORDER BY
    salary_category DESC
;