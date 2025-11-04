-- Step 1: Create star schema tables
-- Run this first

-- Set up initial configurations
PRAGMA enable_progress_bar;
PRAGMA enable_checkpoint_on_shutdown;

-- Drop existing tables if they exist (for idempotency)
DROP TABLE IF EXISTS skills_job_dim;
DROP TABLE IF EXISTS job_postings_fact;
DROP TABLE IF EXISTS skills_dim;
DROP TABLE IF EXISTS company_dim;

-- Create company_dim table
CREATE TABLE company_dim (
    company_id INTEGER PRIMARY KEY,
    company_name VARCHAR UNIQUE NOT NULL
);

-- Create skills_dim table
CREATE TABLE skills_dim (
    skill_id INTEGER PRIMARY KEY,
    skill VARCHAR UNIQUE NOT NULL
);

-- Create job_postings_fact table (must be created before skills_job_dim)
CREATE TABLE job_postings_fact (
    job_id INTEGER PRIMARY KEY,
    company_id INTEGER,
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
    FOREIGN KEY (company_id) REFERENCES company_dim(company_id)
);

-- Create skills_job_dim bridge table (after job_postings_fact exists)
CREATE TABLE skills_job_dim (
    skill_id INTEGER,
    job_id INTEGER,
    PRIMARY KEY (skill_id, job_id),
    FOREIGN KEY (skill_id) REFERENCES skills_dim(skill_id),
    FOREIGN KEY (job_id) REFERENCES job_postings_fact(job_id)
);

-- Verify tables were created
SHOW TABLES;

