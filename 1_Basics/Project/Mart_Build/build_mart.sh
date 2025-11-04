#!/bin/bash
# build_mart.sh - Production-ready mart build script

set -e  # Exit on any error

# Default database file name
DB_FILE="${1:-data_mart.duckdb}"

echo "Starting mart build process..."
echo "Database file: $DB_FILE"

# Function to run SQL script with error handling
run_sql_script() {
    local script=$1
    echo "Running $script..."
    
    if duckdb "$DB_FILE" -c ".read $script"; then
        echo "✅ $script completed successfully"
    else
        echo "❌ $script failed"
        exit 1
    fi
}

# Run all steps
run_sql_script "01_create_tables.sql"
run_sql_script "02_load_star_schema.sql"
run_sql_script "03_create_marts.sql"

echo "🎉 Mart build completed successfully!"
echo "Database saved to: $DB_FILE"
