-- Step 2: Load data from CSV files into star schema tables
-- Run this after Step 1
-- Note: Update the GCS bucket path with your actual bucket name

-- Load company_dim table
COPY company_dim 
FROM 'https://storage.googleapis.com/sql_de/company_dim.csv'
WITH (
    FORMAT CSV,
    HEADER true,
    DELIMITER ','
);

-- Load skills_dim table
COPY skills_dim 
FROM 'https://storage.googleapis.com/sql_de/skills_dim.csv'
WITH (
    FORMAT CSV,
    HEADER true,
    DELIMITER ','
);

-- Load job_postings_fact table
COPY job_postings_fact 
FROM 'https://storage.googleapis.com/sql_de/job_postings_fact.csv'
WITH (
    FORMAT CSV,
    HEADER true,
    DELIMITER ','
);

-- Load skills_job_dim bridge table
COPY skills_job_dim 
FROM 'https://storage.googleapis.com/sql_de/skills_job_dim.csv'
WITH (
    FORMAT CSV,
    HEADER true,
    DELIMITER ','
);

-- Verify star schema data was loaded correctly
SELECT 'Company Dimension' AS table_name, COUNT(*) as record_count FROM company_dim
UNION ALL
SELECT 'Skills Dimension', COUNT(*) FROM skills_dim
UNION ALL
SELECT 'Job Postings Fact', COUNT(*) FROM job_postings_fact
UNION ALL
SELECT 'Skills Job Bridge', COUNT(*) FROM skills_job_dim;

-- Show sample data
SELECT '=== Company Dimension Sample ===' AS info;
SELECT * FROM company_dim LIMIT 5;

SELECT '=== Skills Dimension Sample ===' AS info;
SELECT * FROM skills_dim LIMIT 10;

SELECT '=== Job Postings Fact Sample ===' AS info;
SELECT * FROM job_postings_fact LIMIT 5;

SELECT '=== Skills Job Bridge Sample ===' AS info;
SELECT * FROM skills_job_dim LIMIT 10;

