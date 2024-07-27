-- Date Functions --

-- Casting --

-- Casting :: significa convertir un valor de un dato en otro tipos de valor, es decir cambiar de string a
-- integer. 

SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date :: DATE AS Date
FROM
    job_postings_fact
;

-- AT TIME ZONE --

-- Cambia timestamps entre diferentes zonas horarias, esto se puede usar ya sea con un timestamp normal 
-- o con una zona horaria especifica.
-- Dependiendo si el timestamp tiene time zone o no esto cambia la forma en la cual se cambia la zona horaria

SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS time_date
FROM
    job_postings_fact
LIMIT 5
;

-- La unica diferencia es que cuando no se tiene zona horaria ya, se tiene que poner 
-- la zona horaria y cambiarla. 


-- EXTRACT --

-- Extrae infomracion de la fecha que esta ahi es decir el ano, mes y dia. 

SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS time_date,
    EXTRACT(MONTH FROM job_posted_date) AS date_month, -- Se extrajo el mes de cada una de las fechas. 
    EXTRACT(YEAR FROM job_posted_date) AS date_year 
FROM
    job_postings_fact
LIMIT 5
;

SELECT
    COUNT(job_id) AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date) AS MONTH
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    month
ORDER BY
    job_posted_count DESC
;