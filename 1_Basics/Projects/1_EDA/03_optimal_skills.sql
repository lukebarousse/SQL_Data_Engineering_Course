/*
Question: What are the most optimal skills to learn for data engineers (high demand and high salary)?
- Identify skills that are both in high demand and associated with high median salaries for Data Engineer roles
- Focus on remote positions with specified salaries
- Why? Helps identify the most valuable skills to learn by finding the intersection of high demand (job security) 
    and high compensation (financial benefits), providing strategic guidance for data engineering career development
*/

SELECT 
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(MEDIAN(job_postings_fact.salary_year_avg), 0) AS median_salary
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
    median_salary DESC
LIMIT 25;

/*
Here's a breakdown of the most optimal skills for Data Engineers:

High-Demand Programming Languages:
- Python and SQL remain the most in-demand skills, each with over 1100 postings and strong median salaries ($135K and $130K, respectively).
- Java maintains high demand (303 postings) with a $135K median salary.
- Scala offers a solid median salary ($137K) with 247 postings.

Cloud & Big Data Technologies:
- AWS continues as the leading cloud platform (783 postings, $137K median salary).
- Azure has 475 postings and a $128K median salary.
- Spark is highly sought after (503 postings, $140K median salary).
- Snowflake has 438 postings and a $135K median salary.

Data Pipeline & DevOps Tools:
- Airflow shows robust demand (386 postings) and a top-tier $150K median salary.
- Terraform, with 193 postings, delivers the highest median salary in the top 25 ($184K).
- Kubernetes and Docker appear with 147 and 144 postings, with median salaries of $150K and $135K, respectively.
- Git appears in 208 postings, offering a $140K median salary.

Streaming & Databases:
- Kafka delivers high compensation ($145K) and solid demand (292 postings).
- NoSQL, SQL Server, and PostgreSQL are all present, with median salaries ranging from $122K to $134K.
- MongoDB and Redshift demonstrate niche demand (136 and 274 postings) with competitive compensation ($135K and $130K, respectively).

┌────────────┬──────────────┬───────────────┐
│   skills   │ demand_count │ median_salary │
│  varchar   │    int64     │    double     │
├────────────┼──────────────┼───────────────┤
│ python     │         1133 │      135000.0 │
│ sql        │         1128 │      130000.0 │
│ aws        │          783 │      137320.0 │
│ spark      │          503 │      140000.0 │
│ azure      │          475 │      128000.0 │
│ snowflake  │          438 │      135500.0 │
│ airflow    │          386 │      150000.0 │
│ java       │          303 │      135000.0 │
│ kafka      │          292 │      145000.0 │
│ redshift   │          274 │      130000.0 │
│ databricks │          266 │      132750.0 │
│ scala      │          247 │      137290.0 │
│ git        │          208 │      140000.0 │
│ hadoop     │          198 │      135000.0 │
│ gcp        │          196 │      136000.0 │
│ terraform  │          193 │      184000.0 │
│ nosql      │          193 │      134415.0 │
│ tableau    │          164 │      115000.0 │
│ pyspark    │          152 │      140000.0 │
│ kubernetes │          147 │      150500.0 │
│ docker     │          144 │      135000.0 │
│ sql server │          139 │      120000.0 │
│ mongodb    │          136 │      135750.0 │
│ r          │          133 │      134775.0 │
│ postgresql │          129 │      122500.0 │
├────────────┴──────────────┴───────────────┤
│ 25 rows                         3 columns │
└───────────────────────────────────────────┘
*/