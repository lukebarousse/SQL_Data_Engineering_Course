-- Step 4: Populate job_postings_fact table
-- Run this after Step 3

-- Populate job_postings_fact table
INSERT INTO job_postings_fact (
    job_id, company_id, job_title_short, job_title, job_location, 
    job_via, job_schedule_type, job_work_from_home, search_location,
    job_posted_date, job_no_degree_mention, job_health_insurance, 
    job_country, salary_rate, salary_year_avg, salary_hour_avg
)
SELECT 
    ROW_NUMBER() OVER (ORDER BY job_posted_date) as job_id,
    cd.company_id,
    jp.job_title_short,
    jp.job_title,
    jp.job_location,
    jp.job_via,
    jp.job_schedule_type,
    jp.job_work_from_home,
    jp.search_location,
    jp.job_posted_date,
    jp.job_no_degree_mention,
    jp.job_health_insurance,
    jp.job_country,
    jp.salary_rate,
    jp.salary_year_avg,
    jp.salary_hour_avg
FROM job_postings jp
LEFT JOIN company_dim cd ON jp.company_name = cd.company_name;

-- Check job_postings_fact population
SELECT COUNT(*) as job_count FROM job_postings_fact;
SELECT * FROM job_postings_fact LIMIT 5;



