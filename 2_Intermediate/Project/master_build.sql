-- Master script to run all steps in sequence
-- This is the data engineer's preferred approach

-- Step 0: Load data from Google Cloud Storage
.read 00_load_data.sql

-- Step 1: Create all tables
.read 01_create_tables.sql

-- Step 2: Populate company dimension
.read 02_populate_company_dim.sql

-- Step 3: Populate skills dimension
.read 03_populate_skills_dim.sql

-- Step 4: Populate fact table
.read 04_populate_fact_table.sql

-- Step 5: Populate bridge table
.read 05_populate_bridge_table.sql

-- Step 6: Verify star schema
.read 06_verify_schema.sql

-- Final summary
SELECT 'Star schema build completed successfully!' as status;
