-- Step 3: Populate skills_dim table
-- Run this after Step 2

-- Populate skills_dim table
-- First, we need to parse the job_skills column which contains Python lists
-- We'll use DuckDB's string functions to extract individual skills
INSERT INTO skills_dim (skill_id, skill)
SELECT DISTINCT
    ROW_NUMBER() OVER (ORDER BY skill) as skill_id,
    skill
FROM (
    SELECT DISTINCT TRIM(skill) as skill
    FROM (
        SELECT UNNEST(STRING_SPLIT(REPLACE(REPLACE(REPLACE(job_skills, '[', ''), ']', ''), '''', ''), ',')) as skill
        FROM job_postings 
        WHERE job_skills IS NOT NULL 
        AND job_skills != '[]'
    )
    WHERE skill != '' AND skill IS NOT NULL
);

-- Check skills_dim population
SELECT COUNT(*) as skills_count FROM skills_dim;
SELECT * FROM skills_dim LIMIT 10;



