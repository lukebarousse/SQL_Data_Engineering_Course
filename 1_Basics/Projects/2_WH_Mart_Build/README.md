# 🏗️ Data Warehouse & Mart Build: Production ETL Pipeline

An end-to-end data engineering pipeline that transforms raw CSV files from Google Cloud Storage into a normalized star schema data warehouse, then builds analytical data marts. This demonstrates my ability to **design dimensional models, build production-ready ETL pipelines, and create analytics-ready data structures**.

![Data Pipeline Architecture](../../../Resources/images/1_2_Project2_Data_Pipeline.png)

---

## 🧾 Executive Summary (For Hiring Managers)

- ✅ **Pipeline scope:** Built a complete **ETL pipeline** from raw CSVs to star schema warehouse to analytical marts  
- ✅ **Data modeling:** Designed a **star schema** with fact tables, dimensions, and bridge tables for many-to-many relationships  
- ✅ **ETL development:** Implemented **extract, transform, load** processes with idempotent operations and data quality checks  
- ✅ **Mart architecture:** Created **3 specialized data marts** (flat, skills, company) with additive measures for safe re-aggregation

If you only have a minute, review these:

1. [`01_create_tables_dw.sql`](./01_create_tables_dw.sql) – star schema DDL with dimensional modeling  
2. [`02_load_schema_dw.sql`](./02_load_schema_dw.sql) – GCS data extraction and loading  
3. [`04_create_skills_mart.sql`](./04_create_skills_mart.sql) – skills demand mart with additive measures  

---

## 🧩 Problem & Context

Data teams need to transform raw data into analytics-ready structures:

- 🎯 **Data integration:** *How do we load data from cloud storage into a queryable warehouse?*  
- 💰 **Dimensional modeling:** *What's the best schema design for analytical queries?*  
- ⚖️ **Performance optimization:** *How do we pre-aggregate data for fast BI tool consumption?*  

This project shows how I:

- **Design schemas:** Model data using star schema principles with proper grain and additive measures  
- **Build pipelines:** Create idempotent ETL processes that can be safely rerun  
- **Optimize for analytics:** Structure data marts for specific business questions with pre-aggregated metrics  
- **Ensure quality:** Implement validation checks and proper data typing throughout the pipeline  

---

## 🧰 Tech Stack

- 🐤 **Database:** DuckDB (file-based OLAP database with GCS integration via `httpfs`)  
- 🧮 **Language:** SQL (DDL for schema design, DML for data loading and transformation)  
- 📊 **Data Model:** Star schema (fact + dimension + bridge tables)  
- 🛠️ **Development:** VS Code for SQL editing + Terminal for DuckDB CLI execution  
- 🔧 **Automation:** Master SQL script for pipeline orchestration  
- 📦 **Version Control:** Git/GitHub for versioned pipeline scripts  
- ☁️ **Storage:** Google Cloud Storage for source CSV files  

---

## 📂 Repository Structure

```text
2_WH_Mart_Build/
├── 01_create_tables_dw.sql      # Star schema DDL
├── 02_load_schema_dw.sql       # GCS data extraction & loading
├── 03_create_flat_mart.sql     # Denormalized flat mart
├── 04_create_skills_mart.sql   # Skills demand mart
├── 05_create_company_mart.sql  # Company hiring mart
├── build_dw_marts.sql          # Master SQL build script
└── README.md                    # You are here
```

---

## 🏗️ Pipeline Architecture

### High-Level Flow

1. **Data Storage** – Job posting CSVs stored in Google Cloud Storage
2. **Data Warehouse** – Star schema with `company_dim`, `skills_dim`, `job_postings_fact`, `skills_job_dim`
3. **Data Marts** – Three specialized marts: `flat_mart`, `skills_mart`, `company_mart`
4. **Data Serving** – BI tools (Excel, Power BI, Tableau, Python) consume from marts and warehouse

### Pipeline Components

1. **[Data Warehouse Creation](./01_create_tables_dw.sql)** – Defines star schema with 4 core tables
2. **[Data Loading](./02_load_schema_dw.sql)** – Extracts CSVs from GCS and loads into warehouse tables
3. **[Flat Mart](./03_create_flat_mart.sql)** – Denormalized table with all dimensions for ad-hoc queries
4. **[Skills Mart](./04_create_skills_mart.sql)** – Time-series skill demand analysis with additive measures
5. **[Company Mart](./05_create_company_mart.sql)** – Company hiring trends by role, location, and month

---

## 💻 Data Engineering Skills Demonstrated

### Dimensional Modeling

- **Star Schema Design:** Fact table (`job_postings_fact`) with dimension tables (`company_dim`, `skills_dim`)  
- **Bridge Tables:** Many-to-many relationship handling (`skills_job_dim`, `bridge_company_location`, `bridge_job_title`)  
- **Grain Definition:** Proper fact table granularity (skill+month, company+title+location+month)  
- **Additive Measures:** Counts and sums that can be safely re-aggregated at any level  
- **Surrogate Keys:** Sequential ID generation using CTEs with self-joins (company_mart build only)  

### ETL Pipeline Development

- **Extract:** Direct CSV loading from Google Cloud Storage using DuckDB's `httpfs` extension  
- **Transform:** Data normalization, type conversion (`CAST`, `DATE_TRUNC`), and quality filtering  
- **Load:** Idempotent table creation with `DROP TABLE IF EXISTS` patterns  
- **Orchestration:** Master SQL script (`build_dw_marts.sql`) for automated pipeline execution  

### SQL Advanced Techniques

- **DDL Operations:** `CREATE TABLE`, `DROP TABLE`, `CREATE SCHEMA` for schema management  
- **DML Operations:** `INSERT INTO ... SELECT` with explicit column mapping from CSV sources  
- **CTEs:** Common Table Expressions for complex transformations and boolean flag conversions  
- **Date Functions:** `DATE_TRUNC('month')`, `EXTRACT(quarter)` for temporal dimension creation  
- **String Functions:** `STRING_AGG` for concatenation, `REPLACE` for data cleaning  
- **Boolean Logic:** `CASE WHEN` conversions for aggregating flags (remote, health insurance, no degree)  

### Data Quality & Production Practices

- **Idempotency:** All scripts safely rerunnable without side effects  
- **Data Validation:** Verification queries at each pipeline step to ensure data integrity  
- **Type Safety:** Proper data type definitions (`VARCHAR`, `INTEGER`, `DOUBLE`, `BOOLEAN`, `TIMESTAMP`)  
- **Schema Organization:** Separate schemas (`flat_mart`, `skills_mart`, `company_mart`) for logical separation  
- **Error Handling:** Structured script execution with clear error messages and progress reporting  

---

## 📊 Data Mart Details

### Flat Mart (`flat_mart.job_postings`)
- **Purpose:** Denormalized table for quick ad-hoc queries
- **Grain:** One row per job posting with all dimensions joined

### Skills Mart (`skills_mart`)
- **Purpose:** Time-series analysis of skill demand over time with additive measures
- **Grain:** `skill_id + month_start_date + job_title_short`
- **Key Features:** All measures are additive (counts/sums) for safe re-aggregation

### Company Mart (`company_mart`)
- **Purpose:** Company hiring trends analysis by role, location, and month
- **Grain:** `company_id + job_title_short_id + location_id + month_start_date`
- **Key Features:** Bridge tables for many-to-many relationships (company-location, job title hierarchies)