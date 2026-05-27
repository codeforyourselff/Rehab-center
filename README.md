# Rehab Center Oracle Database Project

This repository contains an Oracle SQL / PL/SQL project for a rehabilitation center database. It includes schema definition scripts, sample package logic, reporting queries, and a simple schema-based deployment structure for GitHub-friendly organization.

## Project Overview

The project is organized to support:
- database object creation and deployment
- schema-based folder structure for Oracle scripts
- reusable reporting and analysis queries
- easy GitHub review and maintenance

## Repository Structure

- `package_practice.sql` - sample Oracle package and package body example
- `rehab_center.sql` - main Oracle PL/SQL script and menu-based logic
- `rehab_center_tables.sql` - table definitions, constraints, triggers, and seed data
- `summary_report.sql` - reporting and analysis queries
- `users_information.sql` - user creation and privilege setup
- `schema/` - deployment-ready folder layout
  - `schema/001_users/01_create_users.sql`
  - `schema/002_tables/02_create_tables.sql`
  - `schema/003_packages/03_package_practice.sql`
  - `schema/004_reports/04_reporting_queries.sql`
  - `schema/deploy_all.sql`
- `ER-Diagram/` - database ER diagram asset
- `Report/` - report outputs and documentation

## Deployment Order

Use the scripts in this order for a clean Oracle deployment:

1. `schema/001_users/01_create_users.sql`
2. `schema/002_tables/02_create_tables.sql`
3. `schema/003_packages/03_package_practice.sql`
4. `schema/004_reports/04_reporting_queries.sql`

You can also run the top-level deployment entry point:

- `schema/deploy_all.sql`

## How to Use

1. Open Oracle SQL*Plus or SQL Developer.
2. Run the user and schema setup scripts first.
3. Run the table and object creation scripts.
4. Execute package and reporting scripts as needed.

## Notes

- The root SQL files remain available for manual execution and reference.
- The `schema/` folder provides a structured deployment layout for GitHub-based reviews.
- This project is intended for Oracle database development and deployment practice.

## Suggested Next Steps

- Add database versioning and migration history.
- Add rollback scripts for safer deployments.
- Add automated validation checks for production readiness.
