-- Practice Problems Date functions --

-- Ejercicio #1 --

SELECT 
    job_schedule_type,
    AVG(salary_year_avg) AS year_salary,
    AVG(salary_hour_avg) AS hour_salary
FROM
    job_postings_fact
WHERE
    job_posted_date > '2023-06-1'
GROUP BY
    job_schedule_type
; 

SELECT *
FROM
    job_postings_fact
LIMIT 
    100
;


/*
1. group by for job_schedule_type.
2. filter after june 1,2023.
3. average yearly and hourly salary. 
*/

-- Ejercicio #2 --

SELECT 
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS month,
    COUNT(job_id) AS job_count
FROM
    job_postings_fact
WHERE
    EXTRACT(YEAR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') = 2023
GROUP BY
    month
ORDER BY
    month
;



/*
1. Adjust time zone to america
2. Extract the month 
3. count de job_id
4. group by month
5. order by month
*/

-- Ejercicio #3 --

SELECT *
FROM 
    job_postings_fact
LIMIT 100
;