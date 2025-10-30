-- Step 0: Load data from Google Cloud Storage
-- Run this FIRST before any other steps

-- Create the initial job_postings table
CREATE TABLE job_postings (
    job_title_short VARCHAR,
    job_title VARCHAR,
    job_location VARCHAR,
    job_via VARCHAR,
    job_schedule_type VARCHAR,
    job_work_from_home BOOLEAN,
    search_location VARCHAR,
    job_posted_date TIMESTAMP,
    job_no_degree_mention BOOLEAN,
    job_health_insurance BOOLEAN,
    job_country VARCHAR,
    salary_rate VARCHAR,
    salary_year_avg DOUBLE,
    salary_hour_avg DOUBLE,
    company_name VARCHAR,
    job_skills VARCHAR,
    job_type_skills VARCHAR
);

-- Import data from Google Cloud Storage
COPY job_postings 
FROM 'https://storage.googleapis.com/sql_de/job_postings_flat.csv'
WITH (
    FORMAT CSV,
    HEADER true,
    DELIMITER ','
);

-- Verify the data was imported correctly
SELECT COUNT(*) as total_records FROM job_postings;
SELECT * FROM job_postings LIMIT 5;

-- Check the structure
DESCRIBE job_postings;
