-- Practice problem #7 --
/*
Find the count of the number of remote job postings per skill
— Display the top 5 skills by their demand in remote jobs
— Include skill ID, name, and count of postings requiring the skill
*/

SELECT -- Aca con subquirie estamos solo poniendo los nombres de las diferentes skills
    remote_skills.skill_id,
    skills_dim.skills,
    remote_skills.number_of_skills
FROM (
    SELECT -- Estamos hallando la cantidad de trabajos remotos que hay por skill
        skill_id,
        COUNT(*) AS number_of_skills
    FROM
        job_postings_fact
    INNER JOIN skills_job_dim
        ON job_postings_fact.job_id = skills_job_dim.job_id
    WHERE
        job_postings_fact.job_work_from_home = TRUE AND
        job_postings_fact.job_title_short = 'Data Scientist'
    GROUP BY
        skill_id
    ) AS remote_skills
INNER JOIN skills_dim
    ON remote_skills.skill_id = skills_dim.skill_id
ORDER BY
    number_of_skills DESC
LIMIT 5
;



