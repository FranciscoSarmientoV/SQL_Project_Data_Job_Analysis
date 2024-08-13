# Introduction
In this project the focus was to dive into the data job market,to be more specific, data analyst and data scientist roles. This project explores top paying jobs, in demand skills and where high demand meets high salary in this two positions. 

SQL queries? Check them out here: [project_sql folder](/project_sql/)
# Background
To get more understanding of the tool of SQL and navigate more about the data job market. This project has the objective to pinpoint top-paid and in-demand skills taking into account others work to find optimal jobs. Also with the idea of using and learning SQL. 

This project was based on the project maid by Luke Barousse in his free [SQL course](https://lukebarousse.com/sql).

### The questions I wanted to answer through my SQL queries were:

1. What are the top paying data scientist and Data analyst jobs?
2. What are the skills required for this top paying jobs?
3. What skills are more in demand for both jobs?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I used
To make this project possible I maid use of different key tools:

- **SQL:** The principal tool in the analysis, allowing to querie the database and find the insights of the data job market.
- **PostgreSQL:** The chosen database management system, ideal for handling the job postings data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries. 
- **Git & Github:** Essential for version control and sharing my SQL scripts and analysis. 

# The Analysis
Each of the queries made aimed at investigating specific aspects of the data analyst and scientist job market. Here is how I approached each question:

### 1. Top Paying Data Analyst and Data scientist Jobs

In this case I filtered all the data analyst and data scientist positions by average yearly salary and the location, the main idea was remote jobs or positions in the city I life which is Bogotá Colombia. The query shows the high paying options in the two fields. 

```sql
SELECT 
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company
FROM
    job_postings_fact
LEFT JOIN company_dim 
    ON job_postings_fact.company_id = company_dim.company_id
WHERE
    (job_location = 'Anywhere' OR job_location = 'Bogotá, Bogota, Colombia') AND
    (job_title_short = 'Data Analyst' OR job_title_short = 'Data Scientist') AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 
    10
;
```
Here's the breakdown 

- **Difference between the two roles:** In the top 10 paying jobs between this two the highest paying job is a data analyst with a salary of 650.000 per year in average, but the data scientists have more job opportunities in the top 10. 
- **Wide salary range:** Taking a look at the data analyst jobs, the range between the top salary and the next one, in the same role, is much higher than the difference in the Data scientist jobs. 
- **Job Location:** In the Top 10 paying data analyst and data scientist roles the location that is the most predominant are the remote jobs, all the 10 are remote.

### 2. Skills required for the top 10 jobs

For the skills required for the top 10 jobs, I join the job postings and the skills tables to get to see which skills are needed in each role. 

```sql
WITH top_10_jobs AS(
    SELECT 
        job_id,
        job_title,
        salary_year_avg,
        name AS company
    FROM
        job_postings_fact
    LEFT JOIN company_dim 
        ON job_postings_fact.company_id = company_dim.company_id
    WHERE
      (job_location = 'Anywhere' OR job_location = 'Bogotá, Bogota, Colombia') AND
      (job_title_short = 'Data Analyst' OR job_title_short = 'Data Scientist') AND
      salary_year_avg IS NOT NULL AND
      salary_year_avg >= 280000
    ORDER BY
        salary_year_avg DESC
    LIMIT 
        100
)
SELECT 
    top_10_jobs.*,
    skills_dim.skills
FROM 
    top_10_jobs
INNER JOIN skills_job_dim
    ON top_10_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC
;
```
In the skills we can see that:

**Python** and **SQL** are the most demanded skills in the top 10 jobs, being followed by **Java**, **aws** and **Spark**. Is important to say that most of this skills are needed for Data scientist jobs and no for data analyst that is why we can't see other tools listed like **Excel**,**Tableau** or **PowerBi**. 

### 3. Top demanded skills 

In the top demanded skills I count every skill that was listed in every job posting and saw which ones were the most required.

```sql
SELECT 
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_skills
FROM
    job_postings_fact
INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    (job_location = 'Anywhere' OR job_location = 'Bogotá, Bogota, Colombia') AND
    (job_title_short = 'Data Analyst' OR job_title_short = 'Data Scientist') 
GROUP BY
    skills
ORDER BY
    demand_skills DESC
LIMIT 5
;
```
The breakdown for the top demanded skills for data analyst and data scientist:

| Skills  | Demanded_skills |
|---------|-----------------|
| SQL     | 15423           |
| Python  | 15240           |
| R       | 7147            |
| Tableau | 6503            |
| Excel   | 6350            |

As we can see as before **SQL** and **Python** are the most demanded, but in this case **SQL** comes first. 

### 4. Top paying skills

The query describes what are the skills that give the most money. For every skill we took the average salary that this skill will give a person that is a data analyst or a data scientist.

```sql
SELECT 
    skills_dim.skills,
    ROUND(AVG(job_postings_fact.salary_year_avg),0) AS salary_skill -- ROUND sirve para quitar decimales
FROM
    job_postings_fact
INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    (job_location = 'Anywhere' OR job_location = 'Bogotá, Bogota, Colombia') AND
    (job_title_short = 'Data Analyst' OR job_title_short = 'Data Scientist') AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    salary_skill DESC
LIMIT 25
;
```
Here's a breakdown of the top paying skills:

- **High Demand for Big Data & ML Skills:** Top salaries are commanded by analysts skilled in big data technologies (PySpark,Couchbase), machine learning tools (DataRobot, Jupyter), and Python libraries (Pandas, NumPy), reflecting the industry's high valuation Of data processing and predictive modeling capabilities.
- **Software Development & Deployment Proficiency:** Knowledge in development and deployment tools (GitLab, Kubernetes, Airflow) indicates a lucrative crossover between data analysis and engineering, with a premium on skills that facilitate automation and efficient data pipeline management.
- **Cloud Computing Expertise:** Familiarity with cloud and data engineering tools (Elasticsearch, Databricks, GCP) underscores the growing importance of>loud-based analytics environments, suggesting that cloud proficiency significantly boosts earning potential in data analytics.

| skills        | salary_skill |
|---------------|--------------|
| gdpr          | 217738       |
| bitbucket     | 189155       |
| golang        | 187500       |
| selenium      | 180000       |
| opencv        | 172500       |
| neo4j         | 171655       |
| dynamodb      | 169670       |
| tidyverse     | 165513       |
| solidity      | 165000       |
| datarobot     | 162998       |
| redis         | 162500       |
| watson        | 161471       |
| elixir        | 161250       |
| cassandra     | 160850       |
| atlassian     | 160431       |
| microstrategy | 158765       |
| slack         | 158333       |
| hugging face  | 156520       |
| vue           | 156107       |
| aurora        | 155000       |
| dplyr         | 155000       |
| c             | 154455       |
| gcp           | 154199       |
| scala         | 154095       |
| php           | 153500       |

**Here I took the analysis of Luke Barousse because I didn't have much undertanding of the skills that appear in the table.**

### 5. Optimal Skills

This query had the objective of combining the last in one. Finding which of the skills are the most demanded and also have a high average salary. 

```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg),0) AS avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    (job_location = 'Anywhere' OR job_location = 'Bogotá, Bogota, Colombia') AND
    (job_title_short = 'Data Analyst' OR job_title_short = 'Data Scientist') AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25
;
```
| skill_id | skills       | demand_count | avg_salary |
|----------|--------------|--------------|------------|
| 26       | c            | 57           | 154455     |
| 81       | gcp          | 62           | 154199     |
| 3        | scala        | 61           | 154095     |
| 101      | pytorch      | 115          | 152603     |
| 99       | tensorflow   | 126          | 151536     |
| 95       | pyspark      | 36           | 150913     |
| 96       | airflow      | 29           | 150679     |
| 8        | go           | 84           | 148822     |
| 106      | scikit-learn | 84           | 148514     |
| 94       | numpy        | 80           | 148452     |


The breakdown of the optimal skills is the following:

- **Top 5 skills in demand:** The skills that have more demand are the machine learning **TensorFlow**, **PyTorch**, **Scikit-learn** but also cloud computing and data analysis tools such as **NumPy** and **Go**.
- **Top 5 Highest Paying Skills:** At the same time the best paid skills are the machine learning and cloud computing being **PyTorch** the only one in both. Also the the programming lenguages such as **C** and big data tools are pretty demanded like **Scala**. 
- **Correlation:** They have a negative correlation. This means that if a skill is pretty demanded the salary is less, but if the skill is not that demanded the salary is higher. This could mean that the skills that are more specific are the ones that have most value in the market. 

# What I learned

What I learned doing this project:

1. How to use SQL in real situations, not just learn how to use the tool and that is it. I learned how to use every single thing that the course offered in a project and make the analysis of the data more easy.
2. The use of platformes for programming such as github and VScode. Which I found very fun to use and not that hard as I imagined before.
3. Make my understanding of analysis and the data job market much better finding very useful information for beginning in the job market. 

# Conclusions

### Insights

From this analysis, several general insights emerged:

1. **Top paying Data analyst and scientist jobs:** The salaries between Data Analyst in the top 10 are pretty distant from one another, but the Data scientist jobs have pretty similar salaries that don't change that widely.
2. **Skills for Top_paying Jobs:** In this case we see that the skills that are more required for this jobs are **Python** and **SQL**. Also we don't see skills needed for the data analyst jobs, maybe because that 2 offers that appear in that case didn't have skills listed.  
3. **Most In_Demand Skills** **SQL** in general, for both areas, is the most demanded skills, making it very essential when applying for a job.
4. **Skills with higher salaries:** Specific skills are related with more salarie, and also machine learning and cloud skills stand our as well. 
5. **Optimal Skills for Job Market Value:** **SQL** again is the the most demand skill for high average salaries, making it one the best skills to learn to land a job in the market. 

### Closing Thoughts

This project was a pretty good way to work with my SQL skills that I learn in the course. Also giving me a wide picture of the job market for Data Analyst and Data Scientist. Learning about what are the best skills to know and master, also seen what can the future bring if aspiring data analyst or scientist like me put in hard work and themselves exceed in all of this abilities and the work place. 