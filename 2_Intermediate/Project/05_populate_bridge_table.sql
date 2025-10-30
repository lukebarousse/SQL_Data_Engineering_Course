-- Step 5: Populate skills_job_dim bridge table
-- Run this after Step 4

-- Populate skills_job_dim bridge table
-- Fix: Extract the actual skill value from the struct
WITH parsed_skills AS (
    SELECT DISTINCT 
        jpf.job_id,
        TRIM(skill.unnest::VARCHAR) as skill
    FROM job_postings_fact jpf
    JOIN job_postings jp ON jpf.job_title = jp.job_title 
        AND jpf.job_posted_date = jp.job_posted_date
    CROSS JOIN UNNEST(STRING_SPLIT(REPLACE(REPLACE(REPLACE(jp.job_skills, '[', ''), ']', ''), '''', ''), ',')) as skill
    WHERE jp.job_skills IS NOT NULL 
    AND jp.job_skills != '[]'
    AND skill IS NOT NULL
    AND LENGTH(TRIM(skill.unnest::VARCHAR)) > 0
)
INSERT INTO skills_job_dim (skill_id, job_id)
SELECT DISTINCT
    sd.skill_id,
    ps.job_id
FROM parsed_skills ps
JOIN skills_dim sd ON ps.skill = sd.skill;

-- Check skills_job_dim population
SELECT COUNT(*) as bridge_count FROM skills_job_dim;
SELECT * FROM skills_job_dim LIMIT 10;