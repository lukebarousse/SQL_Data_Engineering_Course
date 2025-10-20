/*
Question: What skills are required for the top-paying data engineer jobs?
- Use the top 10 highest-paying Data Engineer jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills,
    helping job seekers understand which skills to develop that align with top salaries
*/

.maxrows 100;  -- need to set this to 100 rows to see all the results

WITH top_paying_jobs AS (
    SELECT	
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Engineer' AND 
        job_location = 'Anywhere' AND 
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;

/*
Here's the breakdown of skills required for top-paying data engineer roles:
Netflix ($445K): Focuses heavily on Java, Python, Spark, Scala and SQL for their data engineering positions
Selby Jennings ($375K): Emphasizes cloud/DevOps skills like AWS, Kubernetes, Docker, Terraform along with Python and Rust
Engtal ($325K): Requires big data technologies like Kafka, Hadoop, Spark and Python libraries (NumPy, Pandas)

┌─────────┬────────────────────────────────────────────────────────────┬─────────────────┬────────────────┬────────────┐
│ job_id  │                         job_title                          │ salary_year_avg │  company_name  │   skills   │
│  int64  │                          varchar                           │     double      │    varchar     │  varchar   │
├─────────┼────────────────────────────────────────────────────────────┼─────────────────┼────────────────┼────────────┤
│ 1578513 │ Data Engineer - Commerce Product Data Engineering [Remote] │        445000.0 │ Netflix        │ spark      │
│ 1610938 │ Data Engineer - Content Production & Promotion [Remote]    │        445000.0 │ Netflix        │ python     │
│ 1241978 │ Data Engineer (L5) - Growth Insights and Foundations       │        445000.0 │ Netflix        │ scala      │
│ 1610938 │ Data Engineer - Content Production & Promotion [Remote]    │        445000.0 │ Netflix        │ java       │
│ 1578513 │ Data Engineer - Commerce Product Data Engineering [Remote] │        445000.0 │ Netflix        │ java       │
│ 1241978 │ Data Engineer (L5) - Growth Insights and Foundations       │        445000.0 │ Netflix        │ sql        │
│ 1241978 │ Data Engineer (L5) - Growth Insights and Foundations       │        445000.0 │ Netflix        │ spark      │
│ 1578513 │ Data Engineer - Commerce Product Data Engineering [Remote] │        445000.0 │ Netflix        │ python     │
│ 1610938 │ Data Engineer - Content Production & Promotion [Remote]    │        445000.0 │ Netflix        │ spark      │
│ 1241978 │ Data Engineer (L5) - Growth Insights and Foundations       │        445000.0 │ Netflix        │ java       │
│ 1241978 │ Data Engineer (L5) - Growth Insights and Foundations       │        445000.0 │ Netflix        │ spring     │
│ 1578513 │ Data Engineer - Commerce Product Data Engineering [Remote] │        445000.0 │ Netflix        │ scala      │
│ 1578513 │ Data Engineer - Commerce Product Data Engineering [Remote] │        445000.0 │ Netflix        │ sql        │
│ 1578513 │ Data Engineer - Commerce Product Data Engineering [Remote] │        445000.0 │ Netflix        │ gdpr       │
│ 1273376 │ Trading Data Engineer                                      │        375000.0 │ Selby Jennings │ terraform  │
│ 1273376 │ Trading Data Engineer                                      │        375000.0 │ Selby Jennings │ kubernetes │
│ 1273376 │ Trading Data Engineer                                      │        375000.0 │ Selby Jennings │ docker     │
│ 1273376 │ Trading Data Engineer                                      │        375000.0 │ Selby Jennings │ git        │
│ 1273376 │ Trading Data Engineer                                      │        375000.0 │ Selby Jennings │ aws        │
│ 1273376 │ Trading Data Engineer                                      │        375000.0 │ Selby Jennings │ python     │
│ 1270530 │ Trading Data Engineer                                      │        375000.0 │ Selby Jennings │ docker     │
│ 1270530 │ Trading Data Engineer                                      │        375000.0 │ Selby Jennings │ git        │
│ 1270532 │ Trading Data Engineer                                      │        375000.0 │ Selby Jennings │ rust       │
│ 1270532 │ Trading Data Engineer                                      │        375000.0 │ Selby Jennings │ aws        │
│ 1270530 │ Trading Data Engineer                                      │        375000.0 │ Selby Jennings │ terraform  │
│ 1270530 │ Trading Data Engineer                                      │        375000.0 │ Selby Jennings │ python     │
│ 1270530 │ Trading Data Engineer                                      │        375000.0 │ Selby Jennings │ kubernetes │
│ 1270532 │ Trading Data Engineer                                      │        375000.0 │ Selby Jennings │ kubernetes │
│ 1270532 │ Trading Data Engineer                                      │        375000.0 │ Selby Jennings │ docker     │
│ 1270532 │ Trading Data Engineer                                      │        375000.0 │ Selby Jennings │ git        │
│ 1270532 │ Trading Data Engineer                                      │        375000.0 │ Selby Jennings │ terraform  │
│ 1270532 │ Trading Data Engineer                                      │        375000.0 │ Selby Jennings │ python     │
│ 1273376 │ Trading Data Engineer                                      │        375000.0 │ Selby Jennings │ rust       │
│ 1270530 │ Trading Data Engineer                                      │        375000.0 │ Selby Jennings │ rust       │
│ 1270530 │ Trading Data Engineer                                      │        375000.0 │ Selby Jennings │ aws        │
│  137801 │ Data Engineer                                              │        325000.0 │ Engtal         │ kafka      │
│  137801 │ Data Engineer                                              │        325000.0 │ Engtal         │ numpy      │
│  137801 │ Data Engineer                                              │        325000.0 │ Engtal         │ hadoop     │
│  137801 │ Data Engineer                                              │        325000.0 │ Engtal         │ pandas     │
│   85490 │ Data Engineer                                              │        325000.0 │ Engtal         │ kafka      │
│  137801 │ Data Engineer                                              │        325000.0 │ Engtal         │ pyspark    │
│   85490 │ Data Engineer                                              │        325000.0 │ Engtal         │ pandas     │
│   85490 │ Data Engineer                                              │        325000.0 │ Engtal         │ hadoop     │
│   85490 │ Data Engineer                                              │        325000.0 │ Engtal         │ numpy      │
│  137801 │ Data Engineer                                              │        325000.0 │ Engtal         │ spark      │
│  137801 │ Data Engineer                                              │        325000.0 │ Engtal         │ kubernetes │
│   85490 │ Data Engineer                                              │        325000.0 │ Engtal         │ pyspark    │
│   85490 │ Data Engineer                                              │        325000.0 │ Engtal         │ spark      │
│   85490 │ Data Engineer                                              │        325000.0 │ Engtal         │ kubernetes │
│   85490 │ Data Engineer                                              │        325000.0 │ Engtal         │ python     │
│  137801 │ Data Engineer                                              │        325000.0 │ Engtal         │ python     │
├─────────┴────────────────────────────────────────────────────────────┴─────────────────┴────────────────┴────────────┤
│ 51 rows                                                                                                    5 columns │
└──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
*/

