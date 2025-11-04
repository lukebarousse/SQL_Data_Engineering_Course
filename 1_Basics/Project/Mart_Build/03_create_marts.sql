-- Step 3: Create marts based on EDA queries
-- Run this after Step 2

-- Drop existing marts if they exist (for idempotency)
DROP TABLE IF EXISTS mart_top_demanded_skills;
DROP TABLE IF EXISTS mart_top_paying_skills;
DROP TABLE IF EXISTS mart_optimal_skills;

-- Mart 1: Top Demanded Skills for Data Engineers
-- Based on EDA query: 1_top_demanded_skills.sql
CREATE TABLE mart_top_demanded_skills AS
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Engineer' 
    AND job_work_from_home = True 
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 10;

-- Mart 2: Top Paying Skills for Data Engineers
-- Based on EDA query: 2_top_paying_skills.sql
CREATE TABLE mart_top_paying_skills AS
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

-- Mart 3: Optimal Skills for Data Engineers (High Demand + High Salary)
-- Based on EDA query: 3_optimal_skills.sql
CREATE TABLE mart_optimal_skills AS
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

-- Verify marts were created
SELECT 'Top Demanded Skills' AS mart_name, COUNT(*) as record_count FROM mart_top_demanded_skills
UNION ALL
SELECT 'Top Paying Skills', COUNT(*) FROM mart_top_paying_skills
UNION ALL
SELECT 'Optimal Skills', COUNT(*) FROM mart_optimal_skills;

-- Show sample data from each mart
SELECT '=== Top Demanded Skills ===' AS info;
SELECT * FROM mart_top_demanded_skills;

SELECT '=== Top Paying Skills (Top 10) ===' AS info;
SELECT * FROM mart_top_paying_skills LIMIT 10;

SELECT '=== Optimal Skills (Top 10) ===' AS info;
SELECT * FROM mart_optimal_skills LIMIT 10;

