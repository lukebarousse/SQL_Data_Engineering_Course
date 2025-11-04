# Data Engineering Project: Job Market Analytics Pipeline

A comprehensive data engineering project that builds an end-to-end data pipeline from raw CSV files to production-ready data marts. This project demonstrates core data engineering principles including data pipeline development, star schema design, and data mart creation for analytics-ready insights.

## Overview

This project transforms job posting data from Google Cloud Storage into a normalized star schema data warehouse, then builds analytical data marts to answer key business questions about the data engineer job market. The solution includes both exploratory data analysis (EDA) queries and a production-ready ETL pipeline.

## Project Structure

```
Project/
├── EDA/                          # Exploratory Data Analysis queries
│   ├── 1_top_demanded_skills.sql
│   ├── 2_top_paying_skills.sql
│   └── 3_optimal_skills.sql
├── Mart_Build/                   # Production data pipeline
│   ├── 01_create_tables.sql      # Star schema table creation
│   ├── 02_load_star_schema.sql   # Data loading from GCS
│   ├── 03_create_marts.sql       # Data mart creation
│   ├── build_mart.sql            # Master SQL build script
│   └── build_mart.sh             # Production shell script
└── README.md
```

## What's Built

### 1. Exploratory Data Analysis (EDA)

Three analytical queries that answer critical questions about the data engineer job market:

- **Top Demanded Skills** (`1_top_demanded_skills.sql`): Identifies the 10 most in-demand skills for remote data engineer positions
- **Top Paying Skills** (`2_top_paying_skills.sql`): Analyzes the 25 highest-paying skills with salary and demand metrics
- **Optimal Skills** (`3_optimal_skills.sql`): Finds the intersection of high demand and high salary - the most valuable skills to learn

### 2. Data Pipeline (Mart_Build)

A production-ready ETL pipeline that:

1. **Creates Star Schema Tables**: Builds a normalized data warehouse structure with:
   - `company_dim`: Company dimension table
   - `skills_dim`: Skills dimension table
   - `job_postings_fact`: Central fact table with job metrics
   - `skills_job_dim`: Bridge table for many-to-many job-skill relationships

2. **Loads Data from Google Cloud Storage**: Extracts CSV files directly from GCS into the star schema tables

3. **Creates Data Marts**: Materializes analytical tables for fast query performance:
   - `mart_top_demanded_skills`: Pre-aggregated top demanded skills
   - `mart_top_paying_skills`: Pre-aggregated top paying skills
   - `mart_optimal_skills`: Pre-aggregated optimal skills analysis

## Data Engineering Skills Demonstrated

### Data Pipeline Development
- **ETL Pipeline Design**: Extract (from GCS), Transform (normalize to star schema), Load (into DuckDB)
- **Idempotent Operations**: Scripts can be safely rerun without side effects
- **Error Handling**: Bash script includes error checking and exit codes
- **Data Validation**: Verification queries ensure data quality at each step

### Data Warehouse Build
- **Star Schema Design**: Implemented proper dimensional modeling with fact and dimension tables
- **Referential Integrity**: Foreign key constraints maintain data relationships
- **Normalization**: Eliminated data redundancy through proper table design
- **Bridge Tables**: Handled many-to-many relationships between jobs and skills

### Data Mart Build
- **Materialized Views**: Created pre-aggregated tables for analytical queries
- **Query Optimization**: Pre-computed aggregations reduce query execution time
- **Analytics-Ready**: Marts are structured for immediate business intelligence consumption
- **Incremental Design**: Marts can be refreshed independently from source data

## Technical Skills Used

### SQL
- **DDL Operations**: `CREATE TABLE`, `DROP TABLE`, `ALTER TABLE`
- **DML Operations**: `INSERT`, `SELECT`, `COPY` for data loading
- **Advanced Joins**: `INNER JOIN` for complex multi-table relationships
- **Aggregations**: `COUNT()`, `AVG()`, `ROUND()` for analytical calculations
- **Window Functions**: `ROW_NUMBER()` for generating surrogate keys
- **CTEs**: Common Table Expressions for complex query logic
- **Data Type Handling**: Proper use of `VARCHAR`, `INTEGER`, `DOUBLE`, `BOOLEAN`, `TIMESTAMP`
- **Constraints**: Primary keys, foreign keys, unique constraints

### Bash
- **Shell Scripting**: Automated pipeline execution with `build_mart.sh`
- **Error Handling**: `set -e` for exit on error, conditional execution
- **Function Definitions**: Modular script organization
- **Parameter Handling**: Command-line arguments for database file naming
- **Progress Reporting**: User-friendly status messages

### DuckDB
- **Database Management**: File-based database creation and management
- **CSV Import**: Direct loading from Google Cloud Storage URLs
- **PRAGMA Settings**: Configuration for progress bars and checkpoints
- **SQL Compatibility**: ANSI SQL standard queries with DuckDB extensions

### VS Code
- **Code Editor**: Primary development environment
- **SQL Formatting**: Consistent code style and readability
- **File Management**: Organized project structure
- **Extension Support**: SQL language support and syntax highlighting

### Git
- **Version Control**: Track changes to SQL scripts and pipeline files
- **Commit History**: Maintain project evolution record
- **Branch Management**: Organize feature development

### GitHub
- **Repository Hosting**: Cloud-based code storage and collaboration
- **Documentation**: README and project documentation
- **Code Sharing**: Public or private repository for portfolio demonstration

## Quick Start

### Prerequisites
- DuckDB installed (`brew install duckdb` on macOS)
- Bash shell access
- CSV files uploaded to Google Cloud Storage

### Option 1: Shell Script (Recommended)
```bash
cd Mart_Build
chmod +x build_mart.sh
./build_mart.sh

# Or specify a custom database file
./build_mart.sh my_mart.duckdb
```

### Option 2: SQL Master Script
```bash
cd Mart_Build
duckdb data_mart.duckdb < build_mart.sql
```

### Option 3: Individual Steps
```bash
cd Mart_Build
duckdb data_mart.duckdb -c ".read 01_create_tables.sql"
duckdb data_mart.duckdb -c ".read 02_load_star_schema.sql"
duckdb data_mart.duckdb -c ".read 03_create_marts.sql"
```

## Data Source

- **Source**: Google Cloud Storage CSV files
- **Files**: 
  - `company_dim.csv`
  - `skills_dim.csv`
  - `job_postings_fact.csv`
  - `skills_job_dim.csv`
- **Location**: `https://storage.googleapis.com/sql_de/`
- **Content**: Job posting data for data engineering positions

## Schema Design

### Star Schema Structure

```
job_postings_fact (Fact Table)
├── job_id (PK)
├── company_id (FK → company_dim)
├── job_title_short
├── job_title
├── salary_year_avg
└── ... (other job attributes)

company_dim (Dimension)
├── company_id (PK)
└── company_name

skills_dim (Dimension)
├── skill_id (PK)
└── skill

skills_job_dim (Bridge Table)
├── skill_id (FK → skills_dim)
├── job_id (FK → job_postings_fact)
└── (skill_id, job_id) as composite PK
```

## Verification

After running the pipeline, verify the build with:

```sql
-- Check record counts
SELECT 'Company Dimension' AS table_name, COUNT(*) as records FROM company_dim
UNION ALL
SELECT 'Skills Dimension', COUNT(*) FROM skills_dim
UNION ALL
SELECT 'Job Postings Fact', COUNT(*) FROM job_postings_fact
UNION ALL
SELECT 'Skills Job Bridge', COUNT(*) FROM skills_job_dim;

-- Verify marts
SELECT * FROM mart_top_demanded_skills;
SELECT * FROM mart_top_paying_skills LIMIT 10;
SELECT * FROM mart_optimal_skills LIMIT 10;
```

## Key Insights from EDA

### Top Demanded Skills
- SQL and Python dominate with ~29,000 job postings each
- Cloud platforms (AWS, Azure) are critical
- Big data tools (Spark) show strong demand

### Top Paying Skills
- Rust commands highest average salary ($220K) but low demand
- Terraform offers excellent salary ($171K) with decent demand (193 postings)
- Infrastructure tools (Kubernetes, Docker) show strong compensation

### Optimal Skills
- Python and SQL lead with high demand and strong salaries
- AWS and Spark offer excellent demand-to-salary ratios
- Cloud and data pipeline tools (Airflow, Snowflake) are highly valuable

## Production Considerations

- **Idempotency**: All scripts can be safely rerun
- **Error Handling**: Scripts exit on failure with clear error messages
- **Data Quality**: Validation queries ensure data integrity
- **Performance**: Materialized marts enable fast analytical queries
- **Maintainability**: Modular design allows easy updates and modifications

## Next Steps

- Schedule automated pipeline runs with cron or workflow orchestrators
- Add data quality checks and validation rules
- Implement incremental loading for new data
- Add monitoring and alerting for pipeline failures
- Expand marts for additional analytical use cases

