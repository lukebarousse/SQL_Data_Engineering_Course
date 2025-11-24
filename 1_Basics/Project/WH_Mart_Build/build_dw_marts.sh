#!/bin/bash
# build_dw_marts.sh - Production-ready warehouse and mart build script

# Set database file name
DB_FILE="dw_marts.duckdb"

echo "Starting warehouse and mart build process..."
echo "Database file: $DB_FILE"
echo ""

# Step 1: DW - Create star schema tables
echo "Running 01_create_tables_dw.sql (Data Warehouse)..."
duckdb "$DB_FILE" -c ".read 01_create_tables_dw.sql"
echo "✅ 01_create_tables_dw.sql completed successfully"
echo ""

# Step 2: DW - Load data from CSV files
echo "Running 02_load_schema_dw.sql (Data Warehouse)..."
duckdb "$DB_FILE" -c ".read 02_load_schema_dw.sql"
echo "✅ 02_load_schema_dw.sql completed successfully"
echo ""

# Step 3: Mart - Create flat mart
echo "Running 03_create_flat_mart.sql (Flat Mart)..."
duckdb "$DB_FILE" -c ".read 03_create_flat_mart.sql"
echo "✅ 03_create_flat_mart.sql completed successfully"
echo ""

# Step 4: Mart - Create skills demand mart
echo "Running 04_create_skills_mart.sql (Skills Mart)..."
duckdb "$DB_FILE" -c ".read 04_create_skills_mart.sql"
echo "✅ 04_create_skills_mart.sql completed successfully"
echo ""

# Step 5: Mart - Create company prospecting mart
echo "Running 05_create_company_mart.sql (Company Mart)..."
duckdb "$DB_FILE" -c ".read 05_create_company_mart.sql"
echo "✅ 05_create_company_mart.sql completed successfully"
echo ""

echo "🎉 Warehouse and mart build completed successfully!"
echo "Database saved to: $DB_FILE"
