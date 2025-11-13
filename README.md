# Music Store Analysis Using SQL (PostgreSQL)

A complete end-to-end SQL case study project with schema design, 50+ fake data records, analytical queries, stored procedures, functions, and reporting.

## Project Overview

This project is a full SQL data analysis case study built on a relational Music Store database (similar to the popular Chinook DB but redesigned with modern PostgreSQL conventions).

### It includes:

- A complete database schema
- 50+ rows of realistic sample data
- 20+ analytical SQL queries
- Stored procedure-style PostgreSQL functions
- Utility functions (UDFs) for calculations
- A fully documented questions.md & answers.sql
- Step-by-step instructions to replicate this project in any PostgreSQL environment

This project demonstrates strong SQL skills including joins, window functions, aggregation, subqueries, PL/pgSQL logic, modular functions, and database documentation.

## Folder Structure
```
Music-Store-Analysis/
│
├── database/
│   ├── sample_dataset.sql
│   ├── schema.md
├── sql_queries/
│   ├── functions.sql
│   ├── stored_procedure.sql
├── analysis_questions.md   
├── analysis_answers.sql  ← all SQL answers in ONE file
├── README.md  ← (this file)
```
 
## Tech Stack

- PostgreSQL 14+
- SQL (DDL, DML, Subqueries, CTEs, Window Functions)
- PL/pgSQL (functions & stored procedure-style logic)
- VS Code / PgAdmin / DBeaver

## Database Schema (High-Level)

The database contains 11 main tables:

Table	Description
Artist	List of artists
Album	Albums created by artists
Genre	Music genres
MediaType	Audio file types
Track	Individual songs
Customer	Customers who purchase music
Employee	Sales/support employees
Invoice	Purchase orders
InvoiceLine	Line items inside invoices
Playlist	User playlists
PlaylistTrack	Mapping of tracks to playlists

For full details, see: `database/schema.md`

### 1. How to Create the Database

`psql -d your_database_name -f database/schema.sql`

Or copy–paste the schema manually from `schema.md`.

### 2. Load 50+ Rows of Sample Data

`psql -d your_database_name -f database/sample_data_inserts.sql`

Validate:
```
SELECT COUNT(*) FROM customer;
SELECT COUNT(*) FROM track;
SELECT COUNT(*) FROM invoice;
```

### 3. Load Stored Procedures (PostgreSQL Functions)

`psql -d your_database_name -f database/stored_procedures_postgres.sql`

### Example usage:

```
SELECT * FROM sp_gettopcustomersbycountry('India', 5);
SELECT * FROM sp_getinvoicesummary('2025-03-01', '2025-03-31');
```

### 4. Load Utility Functions (UDFs)

`psql -d your_database_name -f database/functions_postgres.sql`

### Examples:
```
SELECT fn_totalspentbycustomer(1);

SELECT Name,
       Milliseconds,
       fn_millisecondstominutes(Milliseconds) AS minutes
FROM Track
LIMIT 5;
```

### 5. Run All Query Answers

All answers to all questions from questions.md are in one file: `sql_queries/analysis_answers.sql`

### Execute it:

`psql -d your_database_name -f sql_queries/analysisanswers.sql`

Or run individual queries manually in pgAdmin.

### 6. Analytical Questions Included

The following analytical topics are covered:

- Best customer identification
- Top revenue-generating countries/cities
- Most popular genres per country
- Artist ranking by genre
- Tracks longer than average
- Customer spending analysis
- Multi-table joins
- Window function ranking
- Stored-procedure-based queries
- Function-based logic

All questions are documented in: `analysis_questions.md`

- Key Features Demonstrated
- Complete relational schema
- 50+ realistic dataset rows
- Fully normalized design
- Joins, windows, aggregates
- CTEs for clean logic
- PL/pgSQL functions
- Modular & reusable database logic
- End-to-end documentation

## How Recruiters Should View This Project

This project highlights:

- Strong SQL query writing
- Experience with database schema design
- Comfort with PostgreSQL functions and PL/pgSQL
- Ability to structure a real data project professionally
- Clear documentation and reproducibility