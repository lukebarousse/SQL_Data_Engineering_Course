/*
Question: What are the highest-paying skills for data engineers?
- Calculate the average salary for each skill required in data engineer positions
- Focus on remote positions with specified salaries
- Include skill frequency to identify both salary and demand
- Why? Helps identify which skills command the highest compensation while also showing 
    how common those skills are, providing a more complete picture for skill development priorities
*/

SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary,
    COUNT(skills) AS skill_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Engineer'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True 
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;

/*
Here's a breakdown of the highest paying skills for Data Engineers:

Key Insights:
- Rust tops the list at $220.5K avg salary, but only 23 job postings (compared to ~30K for SQL/Python)
- Many top paying skills have extremely low demand (1-3 postings):
  - Haskell, OCaml, Erlang ($172.5K, 1 posting each)
  - Next.js, GGplot2 (~$180K, 2 postings each)
  - Solidity ($182.5K, 3 postings)
- More established skills with decent demand:
  - Terraform: $171.3K avg salary (193 postings)
  - Kubernetes: $156K avg salary (147 postings)
  - Golang: $159.3K avg salary (39 postings)

Takeaway: While some niche skills command high salaries, the extremely low posting counts suggest these may be outliers rather than reliable salary indicators. Focus remains better placed on core skills (SQL, Python, AWS) that have both good salaries and high demand.

┌────────────┬────────────┬─────────────┐
│   skills   │ avg_salary │ skill_count │
│  varchar   │   double   │    int64    │
├────────────┼────────────┼─────────────┤
│ rust       │   220583.0 │          23 │
│ sheets     │   196698.0 │           2 │
│ gdpr       │   183948.0 │          22 │
│ graphql    │   182924.0 │          28 │
│ solidity   │   182500.0 │           3 │
│ next.js    │   180000.0 │           2 │
│ ggplot2    │   176250.0 │           2 │
│ haskell    │   172500.0 │           1 │
│ ocaml      │   172500.0 │           1 │
│ erlang     │   172500.0 │           1 │
│ fastapi    │   172500.0 │           3 │
│ node       │   171405.0 │          22 │
│ terraform  │   171288.0 │         193 │
│ mongo      │   168300.0 │          14 │
│ bitbucket  │   159769.0 │           9 │
│ zoom       │   159510.0 │          12 │
│ centos     │   159350.0 │           2 │
│ golang     │   159346.0 │          39 │
│ django     │   158000.0 │           5 │
│ spring     │   157697.0 │          33 │
│ mxnet      │   157500.0 │           1 │
│ julia      │   157000.0 │           3 │
│ kubernetes │   156024.0 │         147 │
│ drupal     │   156000.0 │           1 │
│ vue        │   156000.0 │           1 │
├────────────┴────────────┴─────────────┤
│ 25 rows                     3 columns │
└───────────────────────────────────────┘
*/