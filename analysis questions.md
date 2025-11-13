# SQL Project – Music Store Data Analysis

Comprehensive SQL practice questions for the Music Store (Chinook-style) database.

---

## Question Set 1 – Basic & Intermediate Queries

1. **Who is the senior-most employee based on job title?**  
   Return the employee with the highest seniority in the job hierarchy.

2. **Which countries have the most invoices?**  
   List countries ordered by the total number of invoices (highest first).

3. **What are the top 3 values of total invoice amount?**  
   Return the three highest invoice totals in the dataset.

4. **Which city has the best customers (highest revenue)?**  
   We want to host a promotional Music Festival in the city that generated the highest total revenue.  
   Write a query that returns:  
   - City name  
   - Sum of all invoice totals for that city  

5. **Who is the best customer?**  
   The customer who has spent the most money overall should be identified as the *best customer*.  
   Write a query that returns:  
   - Customer name  
   - Total amount spent  

---

## Question Set 2 – Joins, Filters & Sorting

1. **Return all Rock music listeners and their basic information.**  
   Write a query to return the **email, first name, last name, and genre** of all customers who listen to *Rock* music.  
   - Use the appropriate joins between `Customer`, `Invoice`, `InvoiceLine`, `Track`, and `Genre`.  
   - Return the list ordered alphabetically by **email**, starting with A.

2. **Artists who have written the most Rock music.**  
   We want to invite artists who have contributed the most Rock tracks.  
   Write a query that returns:  
   - Artist name  
   - Total Rock track count  
   Show the **top 10 Rock artists**, ordered by track count (highest first).

3. **Tracks longer than the average song length.**  
   Return all track names that have a **song length longer than the average song length** in the database.  
   - Return: track name and milliseconds for each track.  
   - Order by song length (milliseconds) in descending order (longest first).

---

## Question Set 3 – Advanced Aggregate Queries

1. **Total amount spent by each customer on each artist.**  
   Find out how much each customer has spent on each artist.  
   Write a query to return:  
   - Customer name (first + last)  
   - Artist name  
   - Total amount spent on that artist by that customer  

2. **Most popular music genre by country.**  
   The most popular genre is defined as the one with the **highest number of purchases**.  
   Write a query that returns, for each country:  
   - Country name  
   - Genre name  
   - Number of purchases for that genre in that country  
   If multiple genres tie for the maximum purchases in a country, return **all** of them.

3. **Top-spending customer per country.**  
   We want to find the **customer who spent the most on music in each country**.  
   Write a query that returns:  
   - Country  
   - Customer name  
   - Total amount spent  
   If multiple customers tie for the top spending in a country, return **all** such customers.

---

## Question Set 4 – Stored Procedures

These questions require you to design and implement **stored procedures** for the Music Store database.  
You can name the procedures as suggested, or adapt naming to your SQL dialect (MySQL / SQL Server / PostgreSQL).

1. **Stored Procedure: Get top customers by country**  
   Create a stored procedure named, for example, `sp_GetTopCustomersByCountry` that:  
   - Accepts parameters:  
     - `@CountryName` (string)  
     - `@TopN` (integer)  
   - Returns the **top N customers** from that country based on total amount spent (sum of all their invoices).  
   - Output columns: customer name, country, total spent.

2. **Stored Procedure: Invoice summary for a date range**  
   Create a stored procedure named `sp_GetInvoiceSummary` that:  
   - Accepts two parameters: `@StartDate` and `@EndDate`.  
   - Returns:  
     - Total number of invoices in that range  
     - Total revenue in that range  
     - Average invoice total in that range  

3. **Stored Procedure: Add a new customer**  
   Create a stored procedure named `sp_AddNewCustomer` that:  
   - Accepts input parameters for key customer fields (first name, last name, email, country, support rep, etc.).  
   - Inserts a new row into the `Customer` table.  
   - Optionally returns the newly created `CustomerId`.

4. **Stored Procedure: Top tracks by genre**  
   Create a stored procedure named `sp_GetTopTracksByGenre` that:  
   - Accepts parameters: `@GenreName` (string) and `@TopN` (integer).  
   - Returns the **top N tracks** in that genre based on number of times purchased.  
   - Output columns: track name, artist name, total quantity sold, total revenue.

5. **Stored Procedure: Customer purchase history**  
   Create a stored procedure named `sp_GetCustomerPurchaseHistory` that:  
   - Accepts a parameter: `@CustomerId`.  
   - Returns a detailed purchase history for that customer including:  
     - InvoiceId  
     - InvoiceDate  
     - Total invoice amount  
     - Number of tracks purchased in each invoice  

---

## Question Set 5 – User-Defined Functions (UDFs)

These questions require you to create **scalar** or **table-valued** functions that encapsulate reusable business logic.

1. **Function: Total amount spent by a customer**  
   Create a scalar function, e.g. `fn_TotalSpentByCustomer(@CustomerId)`, that:  
   - Accepts a `CustomerId` as input.  
   - Returns a **single numeric value** representing the total amount the customer has spent (sum of all invoice totals).

2. **Function: Convert milliseconds to minutes**  
   Create a scalar function named `fn_MillisecondsToMinutes(@Milliseconds)` that:  
   - Accepts a song duration in milliseconds.  
   - Returns a decimal value representing the duration in minutes (e.g., 215000 ms → 3.58 minutes).  
   - Use this function in a query to list track name, milliseconds, and minutes.

3. **Function: Is high-value invoice**  
   Create a scalar function named `fn_IsHighValueInvoice(@InvoiceId, @Threshold)` that:  
   - Accepts an `InvoiceId` and a numeric `Threshold` amount.  
   - Returns a Boolean/bit (or 0/1) indicating whether the invoice total exceeds the threshold.  
   - Use this function in a query to classify invoices as “High Value” or “Regular”.

4. **Function: Get full customer name**  
   Create a scalar function named `fn_GetCustomerFullName(@CustomerId)` that:  
   - Concatenates the customer’s first and last name in a single string (e.g., “Priya Desai”).  
   - Use this function in a query listing all customers with their full names and countries.

5. **Function: Average track price by genre**  
   Create a scalar or table-valued function named `fn_AvgTrackPriceByGenre(@GenreId)` that:  
   - Calculates the **average UnitPrice** of tracks in a given genre.  
   - Demonstrate its use by writing a query that lists:  
     - Genre name  
     - Average track price (using this function)  
   - Optionally, extend it to return all genres and their average prices (table-valued version).

---
