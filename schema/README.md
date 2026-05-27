# Oracle Database project layout

This repository now follows an Oracle-style schema-based folder structure so database objects can be deployed in a predictable order.

## Deployment order
1. schema/001_users/01_create_users.sql
2. schema/002_tables/02_create_tables.sql
3. schema/003_packages/03_package_practice.sql
4. schema/004_reports/04_reporting_queries.sql

## Notes
- Use the scripts in this order for a clean Oracle deployment.
- The root SQL files remain available for reference and manual execution.
- The DDL and reporting scripts are separated by schema concern to make GitHub review easier.
