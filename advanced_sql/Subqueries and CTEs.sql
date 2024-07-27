-- CTEs y Subqueries se usan para simplificar queries que son un poco extensos, entonces los vuelve un
-- un poco mas manejable. 
-- CTEs son para queries mas dificiles y los subquiries son para algunos mas sencillos. 

-- Subqueries --

-- Un subquerie es un querie dentro de otro querie. 

SELECT *
FROM
    (-- Aca empieza el subquerie
    SELECT *
    FROM 
        job_postings_fact
    WHERE
        EXTRACT(MONTH FROM job_posted_date) = 1
    ) AS january_jobs;
-- Aca termina el subquerie. 
-- En este caso esta creando una tabla con solo enero, para poder modificarla, sin tener que crear una tabla
-- como tal.
-- Los subqueris sirven realizar acciones antes de que se realice la accion principal de outer querie.
-- Se pueden poner en SELECT, FROM, WHERE, HAVING. 

-- CTEs --

-- Los CTEs son temporary set of results, los cuales se pueden utilizar con SELECT, INSERT, UPDATE y DELETE.
-- Este set od results solo se tiene en cuenta la momento de realizar un querie. 

WITH january_jobs AS (-- La definicion del CTE empieza aca
    SELECT *
    FROM 
        job_postings_fact
    WHERE
        EXTRACT(MONTH FROM job_posted_date) = 1
) -- CTE termina aca 

SELECT *
FROM
    january_jobs
;

-- Ejemplos subqueries --

-- Aca esta hallando el nombre de las diferentes companias que no requieren un titulo para trabajar ahi. 

SELECT name AS company_name 
FROM company_dim
WHERE company_id IN ( -- Aca esta tomando el company_id del subquerie y los esta mostrando arriba. 
    SELECT 
        company_id
    FROM
        job_postings_fact
    WHERE  
        job_no_degree_mention = true
)
;

-- Ejemplos CTEs -- 

/*
Find the companies that have the most job openings.
— Get the total number of job postings per company id
— Return the total number of jobs with the company name
*/

WITH company_job_count AS (
    SELECT -- Este es el querie que vamos a estar usando para el grande, o nuestro CTE
        company_id,
        COUNT(*) AS total_jobs
    FROM
        job_postings_fact
    GROUP BY
        company_id
)
-- Aca ponemos el querie que queremos hacer con company_job_count
-- Se tienen que unir las tablas company_dim y job_postings_fact para generar el resultado.

SELECT 
    company_dim.name AS company_name,
    company_job_count.total_jobs
FROM
    company_dim
LEFT JOIN 
    company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY
    total_jobs DESC

