-- Step 3: Mart - Create flat mart table (denormalized data warehouse)
-- Run this after Step 2

-- Drop existing flat mart schema if it exists (for idempotency)
DROP SCHEMA IF EXISTS flat_mart CASCADE;

-- Create the flat mart schema
CREATE SCHEMA flat_mart;

-- Create flat mart table
-- This flattens the star schema into a single denormalized table
-- Each row represents one job posting with all dimensions included
CREATE TABLE flat_mart.job_postings AS
SELECT
    -- Fact table fields
    jpf.job_id,
    jpf.job_title_short,
    jpf.job_title,
    jpf.job_location,
    jpf.job_via,
    jpf.job_schedule_type,
    jpf.job_work_from_home,
    jpf.search_location,
    jpf.job_posted_date,
    jpf.job_no_degree_mention,
    jpf.job_health_insurance,
    jpf.job_country,
    jpf.salary_rate,
    jpf.salary_year_avg,
    jpf.salary_hour_avg,
    
    -- Company dimension fields
    cd.company_id,
    cd.name AS company_name,
    
    -- Aggregate skills into a comma-separated list
    STRING_AGG(sd.skill, ', ') AS skills_list
    
FROM
    job_postings_fact jpf
    LEFT JOIN company_dim cd ON jpf.company_id = cd.company_id
    LEFT JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
    LEFT JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
GROUP BY ALL;

-- Verify flat mart was created
SELECT 'Flat Mart Job Postings' AS table_name, COUNT(*) as record_count FROM flat_mart.job_postings;

-- Show sample data
SELECT '=== Flat Mart Sample ===' AS info;
SELECT 
    job_id,
    company_name,
    job_title_short,
    job_location,
    job_country,
    salary_year_avg,
    job_work_from_home,
    skills_list
FROM flat_mart.job_postings 
LIMIT 10;
