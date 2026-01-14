-- Step 5: Mart - Create priority roles mart (snapshot mart)
-- Run this after Step 4
-- This mart focuses on priority roles and job snapshots for targeted analysis

-- Drop existing mart schema if it exists (for idempotency)
DROP SCHEMA IF EXISTS priority_mart CASCADE;

-- Step 1: Create the mart schema
CREATE SCHEMA priority_mart;

-- Step 2: Create priority roles dimension table
-- This table defines priority levels for different job roles
CREATE TABLE priority_mart.priority_roles (                          -- updated to use priority_mart schema & remove 'OR REPLACE'
  role_id      INTEGER PRIMARY KEY,
  role_name    VARCHAR,
  priority_lvl INTEGER
);

INSERT INTO priority_mart.priority_roles (role_id, role_name, priority_lvl)        -- updated to use priority_mart schema
VALUES
  (1, 'Data Engineer',       2),
  (2, 'Senior Data Engineer', 1),
  (3, 'Software Engineer',   3);

-- Step 3: Create priority jobs snapshot table
-- This table contains a snapshot of jobs with their priority levels
CREATE TABLE priority_mart.priority_jobs_snapshot (                      -- updated to use priority_mart schema
  job_id              INTEGER PRIMARY KEY,
  job_title_short     VARCHAR,
  company_name        VARCHAR,
  job_posted_date     TIMESTAMP,
  salary_year_avg     DOUBLE,
  priority_lvl        INTEGER,
  updated_at          TIMESTAMP
);

INSERT INTO priority_mart.priority_jobs_snapshot (                                   -- updated to use priority_mart schema
  job_id,
  job_title_short,
  company_name,
  job_posted_date,
  salary_year_avg,
  priority_lvl,
  updated_at
)
SELECT 
  jpf.job_id,
  jpf.job_title_short,
  cd.name AS company_name,
  jpf.job_posted_date,
  jpf.salary_year_avg,
  r.priority_lvl,
  CURRENT_TIMESTAMP
FROM
    job_postings_fact AS jpf                  -- updated to use main schema
LEFT JOIN company_dim AS cd                   -- updated to use main schema
    ON jpf.company_id = cd.company_id
INNER JOIN priority_mart.priority_roles AS r       -- updated to use priority_mart schema
    ON jpf.job_title_short = r.role_name;

-- Verify mart was created
SELECT 'Priority Roles Dimension' AS table_name, COUNT(*) as record_count FROM priority_mart.priority_roles
UNION ALL
SELECT 'Priority Jobs Snapshot', COUNT(*) FROM priority_mart.priority_jobs_snapshot;

-- Show sample data from each table
SELECT '=== Priority Roles Dimension Sample ===' AS info;
SELECT * FROM priority_mart.priority_roles;

SELECT '=== Priority Jobs Snapshot Sample ===' AS info;
SELECT 
    job_title_short,
    COUNT(*) AS job_count,
    MIN(priority_lvl) AS priority_lvl,
    MIN(updated_at) AS updated_at
FROM priority_mart.priority_jobs_snapshot          -- updated to use priority_mart schema
GROUP BY job_title_short
ORDER BY job_count DESC;