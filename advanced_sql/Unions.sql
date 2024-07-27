-- Unions --

-- Lo que hacen las unions es que combinan los resultados Select stataments en un solo resultado.

-- Cada uno de los Select statements deben tener la misma cantidad de columnas con datos similares. 

-- UNION --

-- En este podemos combinar tablas o columnas, pero tienen que tener la misma cantidad de columnas cada una.
-- Elimina todos los datos repetidos. Solo deja una. 

-- Aca estamos uniendo todas las columnas mencionadas en cada tabla en una. Sin que se repitan las columnas. 

SELECT 
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs

UNION 

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs

UNION

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs
;

-- UNION ALL --

-- La unica diferencia entre estos dos, es que Union All, repite los valores que se repiten.

SELECT 
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs
;

