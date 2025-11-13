-- ============================================================
-- ANSWERS FOR ALL QUESTIONS IN questions.md
-- Target DB: PostgreSQL (Chinook-style Music Store schema)
-- ============================================================

/****************************************************************
 Question Set 1 – Basic & Intermediate Queries
****************************************************************/

-- Q1. Who is the senior-most employee based on job title / tenure?
-- Here we assume "senior-most" means earliest HireDate.
SELECT *
FROM Employee
ORDER BY HireDate
LIMIT 1;


-- Q2. Which countries have the most invoices?
SELECT
    BillingCountry,
    COUNT(*) AS InvoiceCount
FROM Invoice
GROUP BY BillingCountry
ORDER BY InvoiceCount DESC;


-- Q3. What are the top 3 values of total invoice amount?
SELECT
    Total
FROM Invoice
ORDER BY Total DESC
LIMIT 3;


-- Q4. Which city has the best customers (highest revenue)?
-- (City that generated the highest total invoice amount)
-- If you only want the single best city, add LIMIT 1 at the end.
SELECT
    BillingCity,
    SUM(Total) AS TotalRevenue
FROM Invoice
GROUP BY BillingCity
ORDER BY TotalRevenue DESC;


-- Q5. Who is the best customer (highest total spend)?
SELECT
    c.CustomerId,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    SUM(i.Total) AS TotalSpent
FROM Customer c
JOIN Invoice i
    ON i.CustomerId = c.CustomerId
GROUP BY c.CustomerId, CustomerName
ORDER BY TotalSpent DESC
LIMIT 1;



/****************************************************************
 Question Set 2 – Joins, Filters & Sorting
****************************************************************/

-- Q1. Return all Rock music listeners (email, first name, last name, genre),
--     ordered by email.
SELECT DISTINCT
    c.Email,
    c.FirstName,
    c.LastName,
    g.Name AS Genre
FROM Customer c
JOIN Invoice i
    ON i.CustomerId = c.CustomerId
JOIN InvoiceLine il
    ON il.InvoiceId = i.InvoiceId
JOIN Track t
    ON t.TrackId = il.TrackId
JOIN Genre g
    ON g.GenreId = t.GenreId
WHERE g.Name = 'Rock'
ORDER BY c.Email;


-- Q2. Artists who have written the most Rock music (top 10 by track count).
SELECT
    ar.ArtistId,
    ar.Name AS ArtistName,
    COUNT(*) AS RockTrackCount
FROM Artist ar
JOIN Album al
    ON al.ArtistId = ar.ArtistId
JOIN Track t
    ON t.AlbumId = al.AlbumId
JOIN Genre g
    ON g.GenreId = t.GenreId
WHERE g.Name = 'Rock'
GROUP BY ar.ArtistId, ArtistName
ORDER BY RockTrackCount DESC
LIMIT 10;


-- Q3. Tracks longer than the average song length (by Milliseconds),
--     ordered from longest to shortest.
SELECT
    Name,
    Milliseconds
FROM Track
WHERE Milliseconds >
    (SELECT AVG(Milliseconds) FROM Track)
ORDER BY Milliseconds DESC;



/****************************************************************
 Question Set 3 – Advanced Aggregate Queries
****************************************************************/

-- Q1. Total amount spent by each customer on each artist.
SELECT
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    ar.Name AS ArtistName,
    SUM(il.UnitPrice * il.Quantity) AS AmountSpent
FROM Customer c
JOIN Invoice i
    ON i.CustomerId = c.CustomerId
JOIN InvoiceLine il
    ON il.InvoiceId = i.InvoiceId
JOIN Track t
    ON t.TrackId = il.TrackId
JOIN Album al
    ON al.AlbumId = t.AlbumId
JOIN Artist ar
    ON ar.ArtistId = al.ArtistId
GROUP BY CustomerName, ArtistName
ORDER BY CustomerName, AmountSpent DESC;


-- Q2. Most popular music genre for each country
--     (genre with the highest number of purchases; ties allowed).
WITH GenrePurchases AS (
    SELECT
        c.Country,
        g.GenreId,
        g.Name AS GenreName,
        COUNT(*) AS PurchaseCount
    FROM Customer c
    JOIN Invoice i
        ON i.CustomerId = c.CustomerId
    JOIN InvoiceLine il
        ON il.InvoiceId = i.InvoiceId
    JOIN Track t
        ON t.TrackId = il.TrackId
    JOIN Genre g
        ON g.GenreId = t.GenreId
    GROUP BY c.Country, g.GenreId, g.Name
),
RankedGenres AS (
    SELECT
        Country,
        GenreId,
        GenreName,
        PurchaseCount,
        RANK() OVER (
            PARTITION BY Country
            ORDER BY PurchaseCount DESC
        ) AS GenreRank
    FROM GenrePurchases
)
SELECT
    Country,
    GenreName,
    PurchaseCount
FROM RankedGenres
WHERE GenreRank = 1
ORDER BY Country, GenreName;


-- Q3. Customer who spent the most on music per country
--     (ties allowed).
WITH CustomerCountrySpend AS (
    SELECT
        c.Country,
        c.CustomerId,
        CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
        SUM(i.Total) AS TotalSpent
    FROM Customer c
    JOIN Invoice i
        ON i.CustomerId = c.CustomerId
    GROUP BY c.Country, c.CustomerId, CustomerName
),
RankedCustomers AS (
    SELECT
        Country,
        CustomerId,
        CustomerName,
        TotalSpent,
        RANK() OVER (
            PARTITION BY Country
            ORDER BY TotalSpent DESC
        ) AS SpendRank
    FROM CustomerCountrySpend
)
SELECT
    Country,
    CustomerId,
    CustomerName,
    TotalSpent
FROM RankedCustomers
WHERE SpendRank = 1
ORDER BY Country, CustomerName;



/****************************************************************
 Question Set 4 – Stored Procedures (PostgreSQL-style FUNCTIONS)
****************************************************************/

-- In PostgreSQL, we implement stored-procedure-style logic
-- using FUNCTIONS (some returning TABLE).

-- 4.1 Stored Procedure: Get top customers by country
CREATE OR REPLACE FUNCTION sp_GetTopCustomersByCountry (
    p_Country TEXT,
    p_TopN    INTEGER
)
RETURNS TABLE (
    CustomerId   INTEGER,
    CustomerName TEXT,
    Country      TEXT,
    TotalSpent   NUMERIC
)
LANGUAGE sql
AS $$
    SELECT
        c.CustomerId,
        CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
        c.Country,
        SUM(i.Total) AS TotalSpent
    FROM Customer c
    JOIN Invoice i
        ON i.CustomerId = c.CustomerId
    WHERE c.Country = p_Country
    GROUP BY c.CustomerId, CustomerName, c.Country
    ORDER BY TotalSpent DESC
    LIMIT p_TopN;
$$;


-- 4.2 Stored Procedure: Invoice summary for a date range
CREATE OR REPLACE FUNCTION sp_GetInvoiceSummary (
    p_StartDate TIMESTAMP,
    p_EndDate   TIMESTAMP
)
RETURNS TABLE (
    TotalInvoices   INTEGER,
    TotalRevenue    NUMERIC(10,2),
    AvgInvoiceTotal NUMERIC(10,2)
)
LANGUAGE sql
AS $$
    SELECT
        COUNT(*)::INTEGER AS TotalInvoices,
        COALESCE(SUM(Total), 0)::NUMERIC(10,2) AS TotalRevenue,
        COALESCE(AVG(Total), 0)::NUMERIC(10,2) AS AvgInvoiceTotal
    FROM Invoice
    WHERE InvoiceDate BETWEEN p_StartDate AND p_EndDate;
$$;


-- 4.3 Stored Procedure: Add a new customer
CREATE OR REPLACE FUNCTION sp_AddNewCustomer (
    p_FirstName    TEXT,
    p_LastName     TEXT,
    p_Company      TEXT,
    p_Address      TEXT,
    p_City         TEXT,
    p_State        TEXT,
    p_Country      TEXT,
    p_PostalCode   TEXT,
    p_Phone        TEXT,
    p_Fax          TEXT,
    p_Email        TEXT,
    p_SupportRepId INTEGER
)
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_NewCustomerId INTEGER;
BEGIN
    INSERT INTO Customer (
        FirstName, LastName, Company, Address, City, State,
        Country, PostalCode, Phone, Fax, Email, SupportRepId
    )
    VALUES (
        p_FirstName, p_LastName, p_Company, p_Address, p_City, p_State,
        p_Country, p_PostalCode, p_Phone, p_Fax, p_Email, p_SupportRepId
    )
    RETURNING CustomerId INTO v_NewCustomerId;

    RETURN v_NewCustomerId;
END;
$$;


-- 4.4 Stored Procedure: Top tracks by genre
CREATE OR REPLACE FUNCTION sp_GetTopTracksByGenre (
    p_GenreName TEXT,
    p_TopN      INTEGER
)
RETURNS TABLE (
    TrackId       INTEGER,
    TrackName     TEXT,
    ArtistName    TEXT,
    GenreName     TEXT,
    TotalQuantity INTEGER,
    TotalRevenue  NUMERIC
)
LANGUAGE sql
AS $$
    SELECT
        t.TrackId,
        t.Name AS TrackName,
        ar.Name AS ArtistName,
        g.Name AS GenreName,
        SUM(il.Quantity)::INTEGER AS TotalQuantity,
        SUM(il.UnitPrice * il.Quantity)::NUMERIC AS TotalRevenue
    FROM InvoiceLine il
    JOIN Track t
        ON il.TrackId = t.TrackId
    JOIN Genre g
        ON t.GenreId = g.GenreId
    JOIN Album al
        ON t.AlbumId = al.AlbumId
    JOIN Artist ar
        ON al.ArtistId = ar.ArtistId
    WHERE g.Name = p_GenreName
    GROUP BY t.TrackId, TrackName, ArtistName, GenreName
    ORDER BY TotalQuantity DESC, TotalRevenue DESC
    LIMIT p_TopN;
$$;


-- 4.5 Stored Procedure: Customer purchase history
CREATE OR REPLACE FUNCTION sp_GetCustomerPurchaseHistory (
    p_CustomerId INTEGER
)
RETURNS TABLE (
    InvoiceId      INTEGER,
    InvoiceDate    TIMESTAMP,
    BillingCountry TEXT,
    InvoiceTotal   NUMERIC,
    TotalTracks    INTEGER
)
LANGUAGE sql
AS $$
    SELECT
        i.InvoiceId,
        i.InvoiceDate,
        i.BillingCountry,
        i.Total AS InvoiceTotal,
        COALESCE(SUM(il.Quantity), 0)::INTEGER AS TotalTracks
    FROM Invoice i
    LEFT JOIN InvoiceLine il
        ON il.InvoiceId = i.InvoiceId
    WHERE i.CustomerId = p_CustomerId
    GROUP BY i.InvoiceId, i.InvoiceDate, i.BillingCountry, i.Total
    ORDER BY i.InvoiceDate;
$$;



/****************************************************************
 Question Set 5 – User-Defined Functions (UDFs)
****************************************************************/

-- 5.1 Function: Total amount spent by a customer
CREATE OR REPLACE FUNCTION fn_TotalSpentByCustomer (
    p_CustomerId INTEGER
)
RETURNS NUMERIC(10,2)
LANGUAGE sql
AS $$
    SELECT COALESCE(SUM(Total), 0)::NUMERIC(10,2)
    FROM Invoice
    WHERE CustomerId = p_CustomerId;
$$;


-- 5.2 Function: Convert milliseconds to minutes
CREATE OR REPLACE FUNCTION fn_MillisecondsToMinutes (
    p_Milliseconds INTEGER
)
RETURNS NUMERIC(10,2)
LANGUAGE sql
AS $$
    SELECT ROUND(p_Milliseconds / 60000.0, 2)::NUMERIC(10,2);
$$;


-- 5.3 Function: Is high-value invoice (compared to a threshold)
CREATE OR REPLACE FUNCTION fn_IsHighValueInvoice (
    p_InvoiceId INTEGER,
    p_Threshold NUMERIC(10,2)
)
RETURNS BOOLEAN
LANGUAGE plpgsql
AS $$
DECLARE
    v_Total NUMERIC(10,2);
BEGIN
    SELECT Total
    INTO v_Total
    FROM Invoice
    WHERE InvoiceId = p_InvoiceId;

    IF v_Total IS NULL THEN
        RETURN FALSE;
    ELSIF v_Total > p_Threshold THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$;


-- 5.4 Function: Get full customer name
CREATE OR REPLACE FUNCTION fn_GetCustomerFullName (
    p_CustomerId INTEGER
)
RETURNS TEXT
LANGUAGE sql
AS $$
    SELECT CONCAT(FirstName, ' ', LastName)
    FROM Customer
    WHERE CustomerId = p_CustomerId;
$$;


-- 5.5 Function: Average track price by genre
CREATE OR REPLACE FUNCTION fn_AvgTrackPriceByGenre (
    p_GenreId INTEGER
)
RETURNS NUMERIC(10,2)
LANGUAGE sql
AS $$
    SELECT ROUND(COALESCE(AVG(UnitPrice), 0), 2)::NUMERIC(10,2)
    FROM Track
    WHERE GenreId = p_GenreId;
$$;



/****************************************************************
 Example Calls (optional – for testing in psql)
****************************************************************/

-- SELECT * FROM sp_GetTopCustomersByCountry('India', 3);
-- SELECT * FROM sp_GetInvoiceSummary('2025-03-01', '2025-03-31');
-- SELECT sp_AddNewCustomer('Test', 'User', NULL, 'Somewhere', 'City', 'ST', 'Country', '00000', '123', NULL, 'test@example.com', 1);
-- SELECT * FROM sp_GetTopTracksByGenre('Pop', 5);
-- SELECT * FROM sp_GetCustomerPurchaseHistory(1);

-- SELECT fn_TotalSpentByCustomer(1);
-- SELECT Name, Milliseconds, fn_MillisecondsToMinutes(Milliseconds) AS Minutes FROM Track LIMIT 5;
-- SELECT InvoiceId, Total, fn_IsHighValueInvoice(InvoiceId, 3.50) AS IsHighValue FROM Invoice;
-- SELECT CustomerId, fn_GetCustomerFullName(CustomerId) AS FullName FROM Customer LIMIT 5;
-- SELECT g.GenreId, g.Name, fn_AvgTrackPriceByGenre(g.GenreId) AS AvgPrice FROM Genre g;
