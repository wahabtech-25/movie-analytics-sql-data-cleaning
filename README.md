# Movie Analytics — SQL Data Cleaning

## Project Overview

This project focuses on cleaning, validating, and transforming a raw
movie dataset using Microsoft SQL Server.

The objective was to identify data quality issues, validate the
underlying data, apply appropriate transformations, and create a
structured dataset ready for further analysis.

## Tools

- Microsoft SQL Server
- SQL Server Management Studio (SSMS)

## Dataset

- Total Records: 916
- Source Table: `raw_movies`
- Clean Table: `clean_movies`

## Data Cleaning Workflow

The dataset was processed through the following stages:

1. Data Profiling
2. NULL Value Investigation
3. Duplicate Investigation
4. Data Type Validation
5. Range Validation
6. Text Formatting and Standardization
7. Logical and Date Validation
8. Data Transformation
9. Clean Table Creation
10. Final Data Quality Validation

## Data Quality Checks

### Missing Values

Missing values were investigated across the dataset. NULL values were
preserved where the underlying information was genuinely unavailable.

### Duplicate Investigation

Potential duplicate values were identified using grouping and
occurrence counts. Records were investigated before determining
whether they represented actual duplicates.

### Data Type Validation

Raw string-based numeric fields were validated and converted into
appropriate numeric data types using `TRY_CAST`.

Examples include:

- Release year → `INT`
- Release day → `INT`
- Rating → `DECIMAL`
- Vote count → `BIGINT`
- Runtime → `INT`
- Box office → `BIGINT`
- Budget → `BIGINT`

### Range Validation

Logical ranges were validated for numeric fields, including:

- Release day: 1–31
- Rating: 0–10
- Vote count: non-negative
- Runtime: non-negative
- Box office: non-negative
- Budget: non-negative

### Text Formatting

Text fields were checked for leading and trailing whitespace.

An additional formatting issue was identified in the `director`
column where 14 records contained inconsistent comma spacing.
These values were standardized during the transformation process.

### Logical and Date Validation

Release year, month, and day values were checked for logical
consistency, including month-specific day limits.

## Transformation

After completing the investigation and validation process, the
cleaned data was transformed from the raw table into the
`clean_movies` table.

The clean table contains appropriate data types and standardized
values while preserving valid NULL values.

## Final Validation

The cleaned table was validated after transformation to ensure:

- Row count was preserved
- Expected NULL values were retained
- Numeric ranges were valid
- Director formatting was standardized
- Duplicate conditions were rechecked
- Date logic was validated
- Data types were verified

## SQL Concepts Used

- SELECT
- WHERE
- GROUP BY
- HAVING
- ORDER BY
- CASE
- COUNT
- SUM
- AVG
- Subqueries
- TRY_CAST
- TRIM
- REPLACE
- INSERT INTO ... SELECT

## Project Structure

```text
movie-analytics-sql-data-cleaning/
│
├── README.md
├── movie_data_cleaning.sql
└── screenshots/

