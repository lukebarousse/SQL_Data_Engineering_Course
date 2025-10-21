#!/bin/bash
# build_warehouse.sh - Production-ready warehouse build script

set -e  # Exit on any error

echo "Starting warehouse build process..."

# Function to run SQL script with error handling
run_sql_script() {
    local script=$1
    echo "Running $script..."
    
    if duckdb -c ".read $script"; then
        echo "✅ $script completed successfully"
    else
        echo "❌ $script failed"
        exit 1
    fi
}

# Run all steps
run_sql_script "00_load_data.sql"
run_sql_script "01_create_tables.sql"
run_sql_script "02_populate_company_dim.sql"
run_sql_script "03_populate_skills_dim.sql"
run_sql_script "04_populate_fact_table.sql"
run_sql_script "05_populate_bridge_table.sql"
run_sql_script "06_verify_schema.sql"

echo "🎉 Warehouse build completed successfully!"

