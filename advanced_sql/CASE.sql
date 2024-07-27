-- CASE --

-- Case funciona como un if, es decir que si pasa algo el programa tiene que hacer una cosa
-- y si pasa otra cosa el programa hace otra cosa distinta. 

SELECT
    job_title_short,
    job_location,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote' -- Aca son todos los if
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite' -- Si ninguno de los ifs se cumple
    END AS location_categoty -- Es el numbre de la columna que se ejecuta aca. 
FROM 
    job_postings_fact
    
;

-- Step further --

-- Aca podemos ver cuantos de los trabajos que hay disponibles son en Remote, Local o Onsite. 

SELECT
    COUNT(job_id),
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote' -- Aca son todos los if
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite' -- Si ninguno de los ifs se cumple
    END AS location_category -- Es el numbre de la columna que se ejecuta aca. 
FROM 
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY
    location_category
;

/*
Label new column as follows:
' Anywhere 'jobs as 'Remote'
— 'New York,NY' jobs as 'Local'
— Otherwise 'Onsite'
*/