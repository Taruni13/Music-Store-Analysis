-- ============================================================
-- "Stored Procedures" for Music Store DB (PostgreSQL version)
-- Implemented as SQL / PLpgSQL FUNCTIONS returning TABLEs
-- ============================================================

-- 1️⃣ Get top N customers by total spend in a given country
CREATE OR REPLACE FUNCTION sp_gettopcustomersbycountry (
    p_country TEXT,
    p_topn    INTEGER
)
RETURNS TABLE (
    customerid    INTEGER,
    customername  TEXT,
    country       TEXT,
    totalspent    NUMERIC
)
LANGUAGE sql
AS $$
    SELECT 
        c.customerid,
        CONCAT(c.firstname, ' ', c.lastname) AS customername,
        c.country,
        SUM(i.total) AS totalspent
    FROM customer c
    JOIN invoice i 
        ON i.customerid = c.customerid
    WHERE c.country = p_country
    GROUP BY c.customerid, customername, c.country
    ORDER BY totalspent DESC
    LIMIT p_topn;
$$;


-- 2️⃣ Invoice summary for a given date range
CREATE OR REPLACE FUNCTION sp_getinvoicesummary (
    p_startdate TIMESTAMP,
    p_enddate   TIMESTAMP
)
RETURNS TABLE (
    totalinvoices   INTEGER,
    totalrevenue    NUMERIC(10,2),
    avginvoicetotal NUMERIC(10,2)
)
LANGUAGE sql
AS $$
    SELECT 
        COUNT(*)::INTEGER AS totalinvoices,
        COALESCE(SUM(total), 0)::NUMERIC(10,2) AS totalrevenue,
        COALESCE(AVG(total), 0)::NUMERIC(10,2) AS avginvoicetotal
    FROM invoice
    WHERE invoicedate BETWEEN p_startdate AND p_enddate;
$$;


-- 3️⃣ Add a new customer and return the new CustomerId
CREATE OR REPLACE FUNCTION sp_addnewcustomer (
    p_firstname    TEXT,
    p_lastname     TEXT,
    p_company      TEXT,
    p_address      TEXT,
    p_city         TEXT,
    p_state        TEXT,
    p_country      TEXT,
    p_postalcode   TEXT,
    p_phone        TEXT,
    p_fax          TEXT,
    p_email        TEXT,
    p_supportrepid INTEGER
)
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_new_customerid INTEGER;
BEGIN
    INSERT INTO customer (
        firstname, lastname, company, address, city, state,
        country, postalcode, phone, fax, email, supportrepid
    )
    VALUES (
        p_firstname, p_lastname, p_company, p_address, p_city, p_state,
        p_country, p_postalcode, p_phone, p_fax, p_email, p_supportrepid
    )
    RETURNING customerid INTO v_new_customerid;

    RETURN v_new_customerid;
END;
$$;


-- 4️⃣ Get top N tracks for a given genre by quantity sold and revenue
CREATE OR REPLACE FUNCTION sp_gettoptracksbygenre (
    p_genrename TEXT,
    p_topn      INTEGER
)
RETURNS TABLE (
    trackid       INTEGER,
    trackname     TEXT,
    artistname    TEXT,
    genrename     TEXT,
    totalquantity INTEGER,
    totalrevenue  NUMERIC
)
LANGUAGE sql
AS $$
    SELECT 
        t.trackid,
        t.name AS trackname,
        ar.name AS artistname,
        g.name AS genrename,
        SUM(il.quantity)::INTEGER AS totalquantity,
        SUM(il.unitprice * il.quantity)::NUMERIC AS totalrevenue
    FROM invoiceline il
    JOIN track t 
        ON il.trackid = t.trackid
    JOIN genre g 
        ON t.genreid = g.genreid
    JOIN album al 
        ON t.albumid = al.albumid
    JOIN artist ar 
        ON al.artistid = ar.artistid
    WHERE g.name = p_genrename
    GROUP BY t.trackid, trackname, artistname, genrename
    ORDER BY totalquantity DESC, totalrevenue DESC
    LIMIT p_topn;
$$;


-- 5️⃣ Customer purchase history (invoice-level)
CREATE OR REPLACE FUNCTION sp_getcustomerpurchasehistory (
    p_customerid INTEGER
)
RETURNS TABLE (
    invoiceid      INTEGER,
    invoicedate    TIMESTAMP,
    billingcountry TEXT,
    invoicetotal   NUMERIC,
    totaltracks    INTEGER
)
LANGUAGE sql
AS $$
    SELECT 
        i.invoiceid,
        i.invoicedate,
        i.billingcountry,
        i.total AS invoicetotal,
        COALESCE(SUM(il.quantity), 0)::INTEGER AS totaltracks
    FROM invoice i
    LEFT JOIN invoiceline il 
        ON il.invoiceid = i.invoiceid
    WHERE i.customerid = p_customerid
    GROUP BY i.invoiceid, i.invoicedate, i.billingcountry, i.total
    ORDER BY i.invoicedate;
$$;


-- End of stored_procedure.sql
-- ============================================================

# Example of how to call a stored procedure (function) in PostgreSQL:

SELECT * FROM sp_gettopcustomersbycountry('India', 3);

SELECT * FROM sp_getinvoicesummary('2025-03-01', '2025-03-31');

SELECT sp_addnewcustomer('Taruni', 'Atodariya', NULL, 'Some Address', 'Stockton',
                         'CA', 'USA', '95211', '1234567890', NULL,
                         'taruni@example.com', 1);

SELECT * FROM sp_gettoptracksbygenre('Pop', 5);

SELECT * FROM sp_getcustomerpurchasehistory(2);
