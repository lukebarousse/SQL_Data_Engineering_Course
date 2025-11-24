# Data Warehouse & Mart Build: Production ETL Pipeline

End-to-end data engineering pipeline that transforms raw CSV files from Google Cloud Storage into a normalized star schema data warehouse, then builds analytical data marts for business intelligence.

## What I Built

### Data Warehouse (Star Schema)
- **4 core tables**: `company_dim`, `skills_dim`, `job_postings_fact`, `skills_job_dim`
- **Normalized design**: Eliminated data redundancy through proper dimensional modeling
- **Bridge tables**: Handled many-to-many relationships between jobs and skills
- **Data loading**: Direct extraction from Google Cloud Storage into DuckDB

### Data Marts (3 Analytical Schemas)
- **Flat Mart**: Denormalized table with all dimensions for quick ad-hoc queries
- **Skills Mart**: Time-series analysis of skill demand with additive measures
- **Company Mart**: Company hiring trends by role, location, and month with bridge tables

## Data Engineering Skills Demonstrated

### ETL Pipeline Development
- **Extract**: Direct CSV loading from Google Cloud Storage using DuckDB's `httpfs` extension
- **Transform**: Data normalization, type conversion, and quality filtering
- **Load**: Idempotent table creation with `DROP TABLE IF EXISTS` patterns
- **Orchestration**: Bash scripting for automated pipeline execution

### Dimensional Modeling
- **Star Schema Design**: Fact and dimension table architecture
- **Surrogate Keys**: Sequential ID generation using CTEs and self-joins
- **Bridge Tables**: Many-to-many relationship handling (company-location, job title hierarchies)
- **Grain Definition**: Proper fact table granularity (skill+month, company+title+location+month)

### Data Mart Architecture
- **Additive Measures**: Counts and sums that can be safely re-aggregated
- **Pre-aggregation**: Materialized tables for query performance optimization
- **Schema Organization**: Separate schemas (`flat_mart`, `skills_mart`, `company_mart`) for logical separation
- **Date Dimensions**: Month-level date tables with quarter and year attributes

### SQL Advanced Techniques
- **DDL Operations**: `CREATE TABLE`, `DROP TABLE`, `CREATE SCHEMA`
- **DML Operations**: `INSERT INTO ... SELECT` with column mapping
- **CTEs**: Common Table Expressions for complex transformations
- **Date Functions**: `DATE_TRUNC`, `EXTRACT` for temporal analysis
- **String Functions**: `STRING_AGG` for concatenation, `REPLACE` for cleaning
- **Boolean Logic**: `CASE WHEN` conversions for flag aggregations

### Data Quality & Production Practices
- **Idempotency**: Scripts safely rerunnable without side effects
- **Data Validation**: Verification queries at each pipeline step
- **Error Handling**: Structured script execution with clear error messages
- **Type Safety**: Proper data type definitions (`VARCHAR`, `INTEGER`, `DOUBLE`, `BOOLEAN`, `TIMESTAMP`)

## Technical Stack

### Core Technologies
- **SQL**: DDL, DML, advanced querying, dimensional modeling
- **DuckDB**: File-based OLAP database with GCS integration
- **Bash**: Shell scripting for pipeline automation
- **Google Cloud Storage**: Cloud object storage for source data

### Development Tools
- **VS Code**: SQL development with formatting and extensions
- **Git/GitHub**: Version control and collaborative development

## Pipeline Architecture

```
CSV Files (GCS) 
  ↓
Star Schema (DuckDB)
  ├── company_dim
  ├── skills_dim  
  ├── job_postings_fact
  └── skills_job_dim
  ↓
Data Marts
  ├── flat_mart.job_postings
  ├── skills_mart.fact_skill_demand_monthly
  └── company_mart.fact_company_hiring_monthly
```

## Project Files

- `01_create_tables_dw.sql` - Star schema DDL
- `02_load_schema_dw.sql` - GCS data loading
- `03_create_flat_mart.sql` - Denormalized mart
- `04_create_skills_mart.sql` - Skills demand mart
- `05_create_company_mart.sql` - Company hiring mart
- `build_dw_marts.sh` - Automated pipeline script
- `build_dw_marts.sql` - Master SQL build script

