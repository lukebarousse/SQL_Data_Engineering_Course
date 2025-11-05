#!/bin/bash
# build_mart.sh - Production-ready mart build script

# Set database file name
DB_FILE="data_mart.duckdb"

echo "Starting mart build process..."
echo "Database file: $DB_FILE"
echo ""

# Step 1: Create tables
echo "Running 01_create_tables.sql..."
duckdb "$DB_FILE" -c ".read 01_create_tables.sql"
echo "✅ 01_create_tables.sql completed successfully"
echo ""

# Step 2: Load data from CSV files
echo "Running 02_load_star_schema.sql..."
duckdb "$DB_FILE" -c ".read 02_load_star_schema.sql"
echo "✅ 02_load_star_schema.sql completed successfully"
echo ""

# Step 3: Create marts
echo "Running 03_create_marts.sql..."
duckdb "$DB_FILE" -c ".read 03_create_marts.sql"
echo "✅ 03_create_marts.sql completed successfully"
echo ""

echo "🎉 Mart build completed successfully!"
echo "Database saved to: $DB_FILE"
