-- Master build script for data warehouse and mart pipeline
-- This file runs all steps in sequence to build the complete warehouse and marts
--
-- Usage (Local):
--   Run this script with: duckdb dw_marts.duckdb -c ".read build_dw_marts.sql"
--
-- Usage (MotherDuck):
--   Run this script with: duckdb "md:dw_marts" -c ".read build_dw_marts.sql"
--   Note: Ensure MOTHERDUCK_TOKEN is already exported in your environment
--   Uncomment the ATTACH statement below to connect to MotherDuck
--
-- Note: The database file "dw_marts.duckdb" will be created if it doesn't exist (local only)
--       To use a different database file, replace "dw_marts.duckdb" with your filename

-- Uncomment below to connect to MotherDuck after building locally:
-- ATTACH 'md:dw_marts';
-- Note: Ensure MOTHERDUCK_TOKEN is already exported in your environment

-- Step 1: DW - Create star schema tables
.read 01_create_tables_dw.sql

-- Step 2: DW - Load data from CSV files into star schema
.read 02_load_schema_dw.sql

-- Step 3: Mart - Create flat mart (denormalized table)
.read 03_create_flat_mart.sql

-- Step 4: Mart - Create skills demand mart
.read 04_create_skills_mart.sql

-- Step 5: Mart - Create company prospecting mart
.read 05_create_company_mart.sql

-- Final verification
SELECT '=== Pipeline Build Complete ===' AS status;
SELECT 'All warehouse tables and marts created successfully' AS message;
