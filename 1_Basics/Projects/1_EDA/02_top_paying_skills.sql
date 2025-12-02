/*
Question: What are the highest-paying skills for data engineers?
- Calculate the median salary for each skill required in data engineer positions
- Focus on remote positions with specified salaries
- Include skill frequency to identify both salary and demand
- Why? Helps identify which skills command the highest compensation while also showing 
    how common those skills are, providing a more complete picture for skill development priorities
*/

SELECT 
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    COUNT(sd.skills) AS skill_count
FROM job_postings_fact jpf
INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Engineer'
    AND jpf.salary_year_avg IS NOT NULL
    AND jpf.job_work_from_home = True 
GROUP BY
    sd.skills
ORDER BY
    median_salary DESC
LIMIT 25;

/*
Here's a breakdown of the highest paying skills for Data Engineers:

Key Insights:
- Rust remains the top-paying skill at $210K median salary, but demand is very low (23 postings).
- Many high median salary skills have extremely low demand (fewer than 5 postings):
  - Sheets ($196.7K, 2 postings), Solidity ($192.5K, 3 postings)
  - Next.js, GGplot2 (both ~$180K, 2 postings each)
  - Haskell, OCaml, Erlang ($172.5K, 1 posting each)
- Some known technologies with both strong compensation and higher demand:
  - Terraform: $184K median salary (193 postings)
  - Golang: $184K median salary (39 postings)
  - Spring: $175.5K median salary (33 postings)
  - Bitbucket: $155K median salary (9 postings)
- Most top-paying skills are niche, with low frequency in postings, so high salaries may reflect outlier roles rather than broad market value.

Takeaway: While some niche skills command high salaries, the extremely low posting counts suggest these may be outliers rather than reliable salary indicators. Focus remains better placed on core skills (SQL, Python, AWS) that have both good salaries and high demand.

┌───────────┬───────────────┬─────────────┐
│  skills   │ median_salary │ skill_count │
│  varchar  │    double     │    int64    │
├───────────┼───────────────┼─────────────┤
│ rust      │      210000.0 │          23 │
│ sheets    │      196698.0 │           2 │
│ solidity  │      192500.0 │           3 │
│ golang    │      184000.0 │          39 │
│ terraform │      184000.0 │         193 │
│ next.js   │      180000.0 │           2 │
│ ggplot2   │      176250.0 │           2 │
│ spring    │      175500.0 │          33 │
│ haskell   │      172500.0 │           1 │
│ erlang    │      172500.0 │           1 │
│ ocaml     │      172500.0 │           1 │
│ neo4j     │      170000.0 │          11 │
│ gdpr      │      169616.0 │          22 │
│ zoom      │      168438.0 │          12 │
│ graphql   │      167500.0 │          28 │
│ plotly    │      162500.0 │           3 │
│ mongo     │      162250.0 │          14 │
│ centos    │      159350.0 │           2 │
│ fastapi   │      157500.0 │           3 │
│ mxnet     │      157500.0 │           1 │
│ drupal    │      156000.0 │           1 │
│ vue       │      156000.0 │           1 │
│ elixir    │      155000.0 │           1 │
│ bitbucket │      155000.0 │           9 │
│ django    │      155000.0 │           5 │
├───────────┴───────────────┴─────────────┤
│ 25 rows                       3 columns │
└─────────────────────────────────────────┘
*/