# 🏭 Flat to Warehouse Build: Star Schema Transformation

An ETL pipeline that transforms flat job posting data (single CSV with embedded skill lists) into a normalized star schema using DuckDB—demonstrating **data transformation, dimensional modeling, and production-ready ETL practices**.

*Bonus project — not covered in the course video*

![Data Warehouse Schema](../../Resources/images/1_2_Data_Warehouse.png)

---

## 🧾 Executive Summary (For Hiring Managers)

- ✅ **Project scope:** Built an **ETL pipeline** that transforms a flat CSV into a star schema warehouse
- ✅ **Data modeling:** Designed **fact table, dimensions, and bridge table** to normalize many-to-many job–skill relationships
- ✅ **Data transformation:** Implemented **string parsing** to convert Python list format `['skill1', 'skill2']` into normalized relational rows
- ✅ **ETL development:** Automated **extract, transform, load** with idempotent scripts and verification queries

If you only have a minute, review these:

1. [`01_create_tables.sql`](./01_create_tables.sql) – Star schema DDL
2. [`02_populate_company_dim.sql`](./02_populate_company_dim.sql) – Company dimension with deduplication
3. [`03_populate_skills_dim.sql`](./03_populate_skills_dim.sql) – Skills dimension from parsed lists
4. [`04_populate_fact_table.sql`](./04_populate_fact_table.sql) – Fact table population
5. [`05_populate_bridge_table.sql`](./05_populate_bridge_table.sql) – Many-to-many job–skill bridge

---

## 🧩 Problem & Context

Job posting data often arrives as a **flat CSV** with skills stored as a Python-style list string (e.g., `['SQL', 'Python', 'AWS']`)—not suitable for analytical queries or dimensional modeling.

**Challenge:** Analysts need to join on skills, aggregate by skill demand, and analyze salary by skill. A flat table with embedded lists prevents efficient querying and violates normalization principles.

**Solution:** ETL pipeline that loads the flat CSV, parses skill lists into normalized rows, and builds a star schema with `job_postings_fact`, `company_dim`, `skills_dim`, and `skills_job_dim` (bridge table). The result mirrors the warehouse structure used in Projects 1 and 2.

---

## 🧰 Tech Stack

- 🐤 **Database:** DuckDB (file-based OLAP with GCS integration via `httpfs`)
- 🧮 **Language:** SQL (DDL for schema, DML for transformation and loading)
- 📊 **Data Model:** Star schema (fact + dimensions + bridge table)
- 🛠️ **Development:** VS Code for SQL editing + Terminal for DuckDB CLI
- 🔧 **Automation:** Master script `build_warehouse.sql` for full pipeline execution
- 📦 **Version Control:** Git/GitHub for versioned scripts
- ☁️ **Storage:** Google Cloud Storage (`job_postings_flat.csv`)

---

## 📂 Repository Structure

```text
3_Flat_to_WH_Build/
├── 00_load_data.sql            # Data import from Google Cloud
├── 01_create_tables.sql        # Star schema table creation
├── 02_populate_company_dim.sql # Company dimension population
├── 03_populate_skills_dim.sql  # Skills dimension (parsed from lists)
├── 04_populate_fact_table.sql  # Fact table population
├── 05_populate_bridge_table.sql# Bridge table (job–skill many-to-many)
├── 06_verify_schema.sql        # Schema verification queries
├── build_warehouse.sql         # Master build script
├── build_warehouse.sh          # Shell script with error handling
└── README.md                   # You are here
```

---

## 🏗️ Pipeline Overview

### Data Source

- **URL:** `https://storage.googleapis.com/sql_de/job_postings_flat.csv`
- **Format:** Flat CSV with job details, company info, and skills as Python list strings

### Star Schema Output

![Data Warehouse Schema](../../Resources/images/1_2_Data_Warehouse.png)

- **Fact Table:** `job_postings_fact` – Central table with job metrics and foreign keys
- **Dimension Tables:** `company_dim`, `skills_dim` – Lookup tables with surrogate keys
- **Bridge Table:** `skills_job_dim` – Many-to-many relationship between jobs and skills

### Quick Start

**Option 1: Master script**
```bash
duckdb -c ".read build_warehouse.sql"
```

**Option 2: Shell script**
```bash
chmod +x build_warehouse.sh
./build_warehouse.sh
```

---

## 💻 Data Engineering Skills Demonstrated

### Data Transformation

- **String Parsing:** Converting Python list format `['skill1', 'skill2']` to normalized rows via `UNNEST` and string functions
- **Type Casting:** DuckDB data types (`VARCHAR`, `INTEGER`, `DOUBLE`, etc.) for schema integrity
- **Deduplication:** Extracting unique companies and skills with proper surrogate key generation

### Dimensional Modeling

- **Star Schema Design:** Fact table with dimension and bridge tables
- **Surrogate Keys:** `ROW_NUMBER()` for generating sequential IDs
- **Bridge Table:** Many-to-many relationship handling for job–skill mappings
- **Referential Integrity:** Foreign key constraints between fact, dimensions, and bridge

### SQL Techniques

- **DDL:** `CREATE TABLE`, `DROP TABLE IF EXISTS` for idempotent schema creation
- **DML:** `INSERT INTO ... SELECT` with explicit column mapping
- **CTEs:** Common Table Expressions for complex transformations
- **Window Functions:** `ROW_NUMBER()` for surrogate key generation
- **UNNEST:** Flattening array-like skill data into relational rows

### Production Practices

- **Idempotency:** Scripts safely rerunnable without side effects
- **Verification:** `06_verify_schema.sql` for record count validation
- **Orchestration:** Master script for automated end-to-end execution
- **Error Handling:** Shell script with structured execution flow
