-- Enero

CREATE TABLE january_jobs AS
    SELECT *
    FROM 
        job_postings_fact
    WHERE 
        EXTRACT(MONTH FROM job_posted_date) = 1
;
-- Febrero
CREATE TABLE february_jobs AS
    SELECT *
    FROM 
        job_postings_fact
    WHERE 
        EXTRACT(MONTH FROM job_posted_date) = 2
;

-- Marzo
CREATE TABLE march_jobs AS
    SELECT *
    FROM 
        job_postings_fact
    WHERE 
        EXTRACT(MONTH FROM job_posted_date) = 3
;