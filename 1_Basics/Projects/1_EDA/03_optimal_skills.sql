/*
Question: What are the most optimal skills to learn for data engineers (high demand and high salary)?
- Identify skills that are both in high demand and associated with high average salaries for Data Engineer roles
- Focus on remote positions with specified salaries
- Why? Helps identify the most valuable skills to learn by finding the intersection of high demand (job security) 
    and high compensation (financial benefits), providing strategic guidance for data engineering career development
*/

SELECT 
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Engineer'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True 
GROUP BY
    skills_dim.skills
ORDER BY
    demand_count DESC,
    avg_salary DESC
LIMIT 25;

/*
Here's a breakdown of the most optimal skills for Data Engineers:

High-Demand Programming Languages:
- Python and SQL are the most in-demand skills with over 1100 postings each and strong salaries ($140K and $130K respectively)
- Java and Scala also command high salaries ($140K-145K) but with lower demand (200-300 postings)

Cloud & Big Data Technologies:
- AWS leads cloud platforms with 783 postings and $140K average salary
- Azure follows with 475 postings and $131K average salary
- Spark shows strong demand (503 postings) with high compensation ($143K)
- Snowflake has significant demand (438 postings) with excellent pay ($145K)

Data Pipeline & DevOps Tools:
- Airflow shows strong demand (386 postings) with top-tier salary ($152K)
- Terraform has fewer postings (193) but highest average salary ($171K)
- Kubernetes and Docker both offer strong compensation ($156K and $141K)
- Git shows solid demand (208 postings) with high salary ($151K)

Streaming & Databases:
- Kafka offers excellent compensation ($149K) with good demand (292 postings)
- NoSQL and SQL Server maintain steady demand with salaries $117K-133K
- PostgreSQL and MongoDB round out database needs with competitive pay

┌────────────┬──────────────┬────────────┐
│   skills   │ demand_count │ avg_salary │
│  varchar   │    int64     │   double   │
├────────────┼──────────────┼────────────┤
│ python     │         1133 │   140000.0 │
│ sql        │         1128 │   130471.0 │
│ aws        │          783 │   139788.0 │
│ spark      │          503 │   143240.0 │
│ azure      │          475 │   131009.0 │
│ snowflake  │          438 │   145010.0 │
│ airflow    │          386 │   151935.0 │
│ java       │          303 │   139949.0 │
│ kafka      │          292 │   148732.0 │
│ redshift   │          274 │   129816.0 │
│ databricks │          266 │   135346.0 │
│ scala      │          247 │   145019.0 │
│ git        │          208 │   150883.0 │
│ hadoop     │          198 │   136442.0 │
│ gcp        │          196 │   141034.0 │
│ terraform  │          193 │   171288.0 │
│ nosql      │          193 │   133433.0 │
│ tableau    │          164 │   119735.0 │
│ pyspark    │          152 │   139483.0 │
│ kubernetes │          147 │   156024.0 │
│ docker     │          144 │   141412.0 │
│ sql server │          139 │   117630.0 │
│ mongodb    │          136 │   131132.0 │
│ r          │          133 │   127627.0 │
│ postgresql │          129 │   122197.0 │
├────────────┴──────────────┴────────────┤
│ 25 rows                      3 columns │
└────────────────────────────────────────┘
*/