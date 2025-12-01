-- Step 2: DW - Load data from CSV files into star schema tables (Data Warehouse)
-- Run this after Step 1
-- Note: Update the GCS bucket path with your actual bucket name

-- Install and load httpfs extension to read from HTTP/HTTPS URLs (Google Cloud Storage)
INSTALL httpfs;
LOAD httpfs;

-- Load dimension tables first (no FK dependencies)
INSERT INTO company_dim (company_id, name)
SELECT company_id, name
FROM read_csv('https://storage.googleapis.com/sql_de/company_dim.csv', 
    AUTO_DETECT=true,
    HEADER=true);

INSERT INTO skills_dim (skill_id, skill, type)
SELECT skill_id, skills AS skill, type
FROM read_csv('https://storage.googleapis.com/sql_de/skills_dim.csv', 
    AUTO_DETECT=true,
    HEADER=true)
WHERE skills IS NOT NULL;

-- Load fact table second (FK references company_dim - must load after dimensions)
INSERT INTO job_postings_fact (
    job_id, company_id, job_title_short, job_title, job_location, 
    job_via, job_schedule_type, job_work_from_home, search_location,
    job_posted_date, job_no_degree_mention, job_health_insurance, 
    job_country, salary_rate, salary_year_avg, salary_hour_avg
)
SELECT 
    job_id, company_id, job_title_short, job_title, job_location, 
    job_via, job_schedule_type, job_work_from_home, search_location,
    job_posted_date, job_no_degree_mention, job_health_insurance, 
    job_country, salary_rate, salary_year_avg, salary_hour_avg
FROM read_csv('https://storage.googleapis.com/sql_de/job_postings_fact.csv', 
    AUTO_DETECT=true,
    HEADER=true);

-- Load bridge table last (FKs reference skills_dim and job_postings_fact)
INSERT INTO skills_job_dim (skill_id, job_id)
SELECT skill_id, job_id
FROM read_csv('https://storage.googleapis.com/sql_de/skills_job_dim.csv', 
    AUTO_DETECT=true,
    HEADER=true);

-- Verify data was loaded correctly
SELECT 'Company Dimension' AS table_name, COUNT(*) as record_count FROM company_dim
UNION ALL
SELECT 'Skills Dimension', COUNT(*) FROM skills_dim
UNION ALL
SELECT 'Job Postings Fact', COUNT(*) FROM job_postings_fact
UNION ALL
SELECT 'Skills Job Bridge', COUNT(*) FROM skills_job_dim;

-- Verify referential integrity (should return 0 for all queries)
SELECT '=== Referential Integrity Check ===' AS info;
SELECT 
    'Orphaned company_ids in job_postings_fact' AS check_type,
    COUNT(*) AS orphaned_count
FROM job_postings_fact 
WHERE company_id NOT IN (SELECT company_id FROM company_dim);

SELECT 
    'Orphaned skill_ids in skills_job_dim' AS check_type,
    COUNT(*) AS orphaned_count
FROM skills_job_dim 
WHERE skill_id NOT IN (SELECT skill_id FROM skills_dim);

SELECT 
    'Orphaned job_ids in skills_job_dim' AS check_type,
    COUNT(*) AS orphaned_count
FROM skills_job_dim 
WHERE job_id NOT IN (SELECT job_id FROM job_postings_fact);

-- Show sample data
SELECT '=== Company Dimension Sample ===' AS info;
SELECT * FROM company_dim LIMIT 5;

SELECT '=== Skills Dimension Sample ===' AS info;
SELECT * FROM skills_dim LIMIT 5;

SELECT '=== Job Postings Fact Sample ===' AS info;
SELECT * FROM job_postings_fact LIMIT 5;

SELECT '=== Skills Job Bridge Sample ===' AS info;
SELECT * FROM skills_job_dim LIMIT 5;
