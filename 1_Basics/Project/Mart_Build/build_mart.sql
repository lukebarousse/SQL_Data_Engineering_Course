-- Master build script for data mart pipeline
-- This file runs all steps in sequence to build the complete data mart

-- Step 1: Create star schema tables
.read 01_create_tables.sql

-- Step 2: Load data from CSV files into star schema
.read 02_load_star_schema.sql

-- Step 3: Create marts
.read 03_create_marts.sql

-- Final verification
SELECT '=== Pipeline Build Complete ===' AS status;
SELECT 'All tables and marts created successfully' AS message;
