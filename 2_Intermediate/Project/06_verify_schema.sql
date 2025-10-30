-- Step 6: Verify star schema
-- Run this after Step 5

-- Check record counts for all tables
SELECT 'job_postings_fact' as table_name, COUNT(*) as record_count FROM job_postings_fact
UNION ALL
SELECT 'company_dim', COUNT(*) FROM company_dim
UNION ALL
SELECT 'skills_dim', COUNT(*) FROM skills_dim
UNION ALL
SELECT 'skills_job_dim', COUNT(*) FROM skills_job_dim;

-- Sample data from each table
SELECT 'job_postings_fact sample:' as info;
SELECT * FROM job_postings_fact LIMIT 3;

SELECT 'company_dim sample:' as info;
SELECT * FROM company_dim LIMIT 3;

SELECT 'skills_dim sample:' as info;
SELECT * FROM skills_dim LIMIT 3;

SELECT 'skills_job_dim sample:' as info;
SELECT * FROM skills_job_dim LIMIT 3;

-- Test a join query to verify relationships work
SELECT 
    jpf.job_title,
    cd.company_name,
    sd.skill
FROM job_postings_fact jpf
JOIN company_dim cd ON jpf.company_id = cd.company_id
JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
LIMIT 5;



