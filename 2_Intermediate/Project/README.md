# Data Warehouse Star Schema Project

A comprehensive SQL data engineering project that transforms flat job posting data into a normalized star schema using DuckDB.

## Overview

This project demonstrates advanced SQL skills including:
- **DML/DDL Operations**: Table creation, data manipulation, and schema design
- **Data Transformation**: Converting Python list strings to normalized relational data
- **Star Schema Design**: Implementing fact and dimension tables with proper relationships
- **ETL Pipeline**: Automated data loading from Google Cloud Storage
- **Bridge Tables**: Many-to-many relationship handling for skills-to-jobs mapping

## Schema Design

### Fact Table
- `job_postings_fact`: Central fact table with job metrics and foreign keys

### Dimension Tables
- `company_dim`: Company lookup table with unique company IDs
- `skills_dim`: Skills catalog with standardized skill names

### Bridge Table
- `skills_job_dim`: Many-to-many relationship between jobs and skills

## Data Source
- **Source**: Google Cloud Storage CSV file
- **URL**: `https://storage.googleapis.com/sql_de/job_postings_flat.csv`
- **Records**: Job postings with salary, location, skills, and company data

## Key SQL Techniques Demonstrated

- **Complex String Parsing**: Converting Python list format `['skill1', 'skill2']` to normalized rows
- **Window Functions**: `ROW_NUMBER()` for generating surrogate keys
- **CTEs**: Common Table Expressions for complex data transformations
- **Foreign Key Constraints**: Maintaining referential integrity
- **UNNEST Operations**: Flattening array-like data structures
- **Data Type Casting**: Handling DuckDB-specific data types

## Quick Start

### Option 1: Master Script (Recommended)
```bash
duckdb -c ".read build_warehouse.sql"
```

### Option 2: Shell Script with Error Handling
```bash
chmod +x build_warehouse.sh
./build_warehouse.sh
```

## File Structure
```
├── 00_load_data.sql          # Data import from Google Cloud
├── 01_create_tables.sql      # Star schema table creation
├── 02_populate_company_dim.sql # Company dimension population
├── 03_populate_skills_dim.sql  # Skills dimension population
├── 04_populate_fact_table.sql # Fact table population
├── 05_populate_bridge_table.sql # Bridge table population
├── 06_verify_schema.sql       # Schema verification queries
├── build_warehouse.sql          # Production build script
└── build_warehouse.sh        # Production shell script
```

## Verification

After execution, verify the star schema with:
```sql
-- Check record counts across all tables
SELECT 'job_postings_fact' as table_name, COUNT(*) as records FROM job_postings_fact
UNION ALL
SELECT 'company_dim', COUNT(*) FROM company_dim
UNION ALL  
SELECT 'skills_dim', COUNT(*) FROM skills_dim
UNION ALL
SELECT 'skills_job_dim', COUNT(*) FROM skills_job_dim;
```

## Skills Showcased

- **Data Modeling**: Star schema design principles
- **SQL Optimization**: Efficient queries and indexing strategies  
- **ETL Development**: Extract, Transform, Load pipeline creation
- **Data Quality**: Referential integrity and data validation
- **Production Practices**: Error handling and automation
