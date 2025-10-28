/*
Question: What are the top-paying data engineer jobs?
- Identify the top 10 highest-paying Data Engineer roles that are available remotely
- Focuses on job postings with specified salaries (remove nulls)
- BONUS: Include company names of top 10 roles
- Why? Highlight the top-paying opportunities for Data Engineers, offering insights into employment options and location flexibility.
*/

SELECT	
	job_id,
	job_title,
    name AS company_name,
    job_posted_date,
	job_location,
	job_schedule_type,
	salary_year_avg
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Engineer' AND 
    job_work_from_home = True AND 
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;

/*
Here's the breakdown of the top data engineer jobs:
Salary Range: Top 10 paying data engineer roles range from $325,000 to $445,000, showing strong compensation in the field.
Key Employers: Netflix dominates the top positions with multiple openings, followed by companies like Dow Jones, Selby Jennings, and Engtal.
Job Focus: Most roles are specialized data engineering positions, with Netflix positions highlighting specific domains like Commerce, Growth Insights, and Content Production.

┌─────────┬──────────────────────────────────────────────┬────────────────┬─────────────────────┬──────────────┬───────────────────┬─────────────────┐
│ job_id  │                  job_title                   │  company_name  │   job_posted_date   │ job_location │ job_schedule_type │ salary_year_avg │
│  int64  │                   varchar                    │    varchar     │      timestamp      │   varchar    │      varchar      │     double      │
├─────────┼──────────────────────────────────────────────┼────────────────┼─────────────────────┼──────────────┼───────────────────┼─────────────────┤
│ 1231335 │ Data Engineer (L5) - Content Production & …  │ Netflix        │ 2024-11-07 09:13:03 │ Anywhere     │ Full-time         │        445000.0 │
│ 1578513 │ Data Engineer - Commerce Product Data Engi…  │ Netflix        │ 2025-05-26 06:04:25 │ Anywhere     │ Full-time         │        445000.0 │
│ 1610938 │ Data Engineer - Content Production & Promo…  │ Netflix        │ 2025-06-21 06:05:38 │ Anywhere     │ Full-time         │        445000.0 │
│ 1241978 │ Data Engineer (L5) - Growth Insights and F…  │ Netflix        │ 2024-12-01 09:00:54 │ Anywhere     │ Full-time         │        445000.0 │
│ 1515084 │ VP, Engineering, Data & AI                   │ Dow Jones      │ 2025-04-06 06:19:21 │ Anywhere     │ Full-time         │        377500.0 │
│ 1270530 │ Trading Data Engineer                        │ Selby Jennings │ 2024-12-30 06:01:05 │ Anywhere     │ Full-time         │        375000.0 │
│ 1270532 │ Trading Data Engineer                        │ Selby Jennings │ 2024-12-30 06:01:05 │ Anywhere     │ Full-time         │        375000.0 │
│ 1273376 │ Trading Data Engineer                        │ Selby Jennings │ 2024-12-31 06:01:07 │ Anywhere     │ Full-time         │        375000.0 │
│   85490 │ Data Engineer                                │ Engtal         │ 2023-01-27 18:31:06 │ Anywhere     │ Full-time         │        325000.0 │
│  137801 │ Data Engineer                                │ Engtal         │ 2023-02-17 18:11:52 │ Anywhere     │ Full-time         │        325000.0 │
├─────────┴──────────────────────────────────────────────┴────────────────┴─────────────────────┴──────────────┴───────────────────┴─────────────────┤
│ 10 rows                                                                                                                                  7 columns │
└────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
 */