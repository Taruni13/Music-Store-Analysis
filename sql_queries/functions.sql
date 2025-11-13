-- ============================================================
-- User-Defined Functions for Music Store DB (PostgreSQL)
-- ============================================================

-- 1️⃣ Total amount spent by a given customer
CREATE OR REPLACE FUNCTION fn_totalspentbycustomer (
    p_customerid INTEGER
)
RETURNS NUMERIC(10,2)
LANGUAGE sql
AS $$
    SELECT COALESCE(SUM(total), 0)::NUMERIC(10,2)
    FROM invoice
    WHERE customerid = p_customerid;
$$;


-- 2️⃣ Convert milliseconds to minutes (2 decimal places)
CREATE OR REPLACE FUNCTION fn_millisecondstominutes (
    p_milliseconds INTEGER
)
RETURNS NUMERIC(10,2)
LANGUAGE sql
AS $$
    SELECT ROUND(p_milliseconds / 60000.0, 2)::NUMERIC(10,2);
$$;


-- 3️⃣ Is an invoice high-value compared to a threshold?
CREATE OR REPLACE FUNCTION fn_ishighvalueinvoice (
    p_invoiceid INTEGER,
    p_threshold NUMERIC(10,2)
)
RETURNS BOOLEAN
LANGUAGE plpgsql
AS $$
DECLARE
    v_total NUMERIC(10,2);
BEGIN
    SELECT total
    INTO v_total
    FROM invoice
    WHERE invoiceid = p_invoiceid;

    IF v_total IS NULL THEN
        RETURN FALSE;
    ELSIF v_total > p_threshold THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$;


-- 4️⃣ Get full customer name (FirstName + LastName)
CREATE OR REPLACE FUNCTION fn_getcustomerfullname (
    p_customerid INTEGER
)
RETURNS TEXT
LANGUAGE sql
AS $$
    SELECT CONCAT(firstname, ' ', lastname)
    FROM customer
    WHERE customerid = p_customerid;
$$;


-- 5️⃣ Average track price for a given genre
CREATE OR REPLACE FUNCTION fn_avgtrackpricebygenre (
    p_genreid INTEGER
)
RETURNS NUMERIC(10,2)
LANGUAGE sql
AS $$
    SELECT ROUND(COALESCE(AVG(unitprice), 0), 2)::NUMERIC(10,2)
    FROM track
    WHERE genreid = p_genreid;
$$;

-- ============================================================

# Example of how to call these functions:
SELECT fn_totalspentbycustomer(1);

SELECT name,
       milliseconds,
       fn_millisecondstominutes(milliseconds) AS minutes
FROM track
LIMIT 5;

SELECT invoiceid,
       total,
       fn_ishighvalueinvoice(invoiceid, 3.50) AS is_high_value
FROM invoice;

SELECT customerid,
       fn_getcustomerfullname(customerid) AS full_name,
       country
FROM customer;

SELECT g.genreid,
       g.name AS genrename,
       fn_avgtrackpricebygenre(g.genreid) AS avg_price
FROM genre g;
        a.name AS artistname,
        g.name AS genrename,
        SUM(ii.quantity) AS totalquantity,
        SUM(ii.unitprice * ii.quantity) AS totalrevenue
    FROM track t
    JOIN album al ON t.albumid = al.albumid
    JOIN artist a ON al.artistid = a.artistid
    JOIN genre g ON t.genreid = g.genreid
    JOIN invoiceline ii ON t.trackid = ii.trackid
    WHERE g.name = p_genrename
    GROUP BY t.trackid, t.name, a.name, g.name
    ORDER BY totalquantity DESC, totalrevenue DESC
    LIMIT p_topn;
$$;