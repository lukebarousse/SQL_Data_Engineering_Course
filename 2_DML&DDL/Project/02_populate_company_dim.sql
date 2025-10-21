-- Step 2: Populate dimension tables
-- Run this after Step 1

-- Populate company_dim table
INSERT INTO company_dim (company_id, company_name)
SELECT 
    ROW_NUMBER() OVER (ORDER BY company_name) as company_id,
    company_name
FROM (
    SELECT DISTINCT company_name 
    FROM job_postings 
    WHERE company_name IS NOT NULL
);

-- Check company_dim population
SELECT COUNT(*) as company_count FROM company_dim;
SELECT * FROM company_dim LIMIT 5;



