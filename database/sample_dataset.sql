-- ============================================================
-- SAMPLE DATA INSERTS FOR MUSIC STORE (PostgreSQL)
-- ============================================================
-- Assumes tables:
--   Artist, Album, Genre, MediaType, Track,
--   Employee, Customer, Invoice, InvoiceLine,
--   Playlist, PlaylistTrack
-- with columns as in your schema.md
-- ============================================================

BEGIN;

-- -------------------------
-- 1. ARTIST
-- -------------------------
INSERT INTO Artist (ArtistId, Name) VALUES (1, 'A.R. Rahman');
INSERT INTO Artist (ArtistId, Name) VALUES (2, 'Arijit Singh');
INSERT INTO Artist (ArtistId, Name) VALUES (3, 'Shreya Ghoshal');
INSERT INTO Artist (ArtistId, Name) VALUES (4, 'Coldplay');
INSERT INTO Artist (ArtistId, Name) VALUES (5, 'Taylor Swift');
INSERT INTO Artist (ArtistId, Name) VALUES (6, 'Ed Sheeran');
INSERT INTO Artist (ArtistId, Name) VALUES (7, 'Imagine Dragons');
INSERT INTO Artist (ArtistId, Name) VALUES (8, 'Hans Zimmer');
INSERT INTO Artist (ArtistId, Name) VALUES (9, 'Billie Eilish');
INSERT INTO Artist (ArtistId, Name) VALUES (10, 'Dua Lipa');

-- -------------------------
-- 2. ALBUM
-- -------------------------
INSERT INTO Album (AlbumId, Title, ArtistId) VALUES (1, 'Soulful Nights', 2);
INSERT INTO Album (AlbumId, Title, ArtistId) VALUES (2, 'Melody of Dreams', 3);
INSERT INTO Album (AlbumId, Title, ArtistId) VALUES (3, 'Rhythm of India', 1);
INSERT INTO Album (AlbumId, Title, ArtistId) VALUES (4, 'Sky Full of Stars', 4);
INSERT INTO Album (AlbumId, Title, ArtistId) VALUES (5, 'Midnight Stories', 9);
INSERT INTO Album (AlbumId, Title, ArtistId) VALUES (6, 'City Lights', 6);
INSERT INTO Album (AlbumId, Title, ArtistId) VALUES (7, 'Fearless Again', 5);
INSERT INTO Album (AlbumId, Title, ArtistId) VALUES (8, 'Electro Pulse', 10);
INSERT INTO Album (AlbumId, Title, ArtistId) VALUES (9, 'Battle Scores', 8);
INSERT INTO Album (AlbumId, Title, ArtistId) VALUES (10, 'Desert Storm', 7);
INSERT INTO Album (AlbumId, Title, ArtistId) VALUES (11, 'Ocean Waves', 4);
INSERT INTO Album (AlbumId, Title, ArtistId) VALUES (12, 'Golden Hour', 6);

-- -------------------------
-- 3. GENRE
-- -------------------------
INSERT INTO Genre (GenreId, Name) VALUES (1, 'Pop');
INSERT INTO Genre (GenreId, Name) VALUES (2, 'Rock');
INSERT INTO Genre (GenreId, Name) VALUES (3, 'Jazz');
INSERT INTO Genre (GenreId, Name) VALUES (4, 'Classical');
INSERT INTO Genre (GenreId, Name) VALUES (5, 'Bollywood');
INSERT INTO Genre (GenreId, Name) VALUES (6, 'EDM');
INSERT INTO Genre (GenreId, Name) VALUES (7, 'Hip-Hop');
INSERT INTO Genre (GenreId, Name) VALUES (8, 'Country');

-- -------------------------
-- 4. MEDIATYPE
-- -------------------------
INSERT INTO MediaType (MediaTypeId, Name) VALUES (1, 'MPEG audio file');
INSERT INTO MediaType (MediaTypeId, Name) VALUES (2, 'AAC audio file');
INSERT INTO MediaType (MediaTypeId, Name) VALUES (3, 'WAV');

-- -------------------------
-- 5. TRACK
-- -------------------------
INSERT INTO Track (TrackId, Name, AlbumId, MediaTypeId, GenreId, Composer, Milliseconds, Bytes, UnitPrice) VALUES
(1, 'Midnight Breeze', 1, 1, 5, 'Arijit Singh', 210000, 4500000, 0.99),
(2, 'Rainy Streets', 1, 1, 5, 'Arijit Singh', 195000, 4300000, 0.99),
(3, 'Golden Sunrise', 2, 2, 1, 'Shreya Ghoshal', 230000, 4800000, 1.29),
(4, 'Whispers of Dawn', 2, 2, 1, 'Shreya Ghoshal', 245000, 4700000, 1.29),
(5, 'Temple Bells', 3, 3, 4, 'A.R. Rahman', 260000, 5000000, 1.29),
(6, 'Desert Wind', 3, 1, 5, 'A.R. Rahman', 200000, 4200000, 0.99),
(7, 'Skyline', 4, 1, 2, 'Coldplay', 215000, 4600000, 1.29),
(8, 'Starfall', 4, 2, 2, 'Coldplay', 240000, 4700000, 1.29),
(9, 'Soft Shadows', 5, 2, 1, 'Billie Eilish', 205000, 4400000, 1.29),
(10, 'Neon Nights', 5, 1, 6, 'Billie Eilish', 220000, 4550000, 1.29),
(11, 'City Rush', 6, 1, 7, 'Ed Sheeran', 210000, 4300000, 1.29),
(12, 'Coffee Shop', 6, 2, 1, 'Ed Sheeran', 185000, 3900000, 0.99),
(13, 'Fearless Heart', 7, 1, 1, 'Taylor Swift', 230000, 4600000, 1.29),
(14, 'Small Town Rain', 7, 1, 8, 'Taylor Swift', 215000, 4500000, 0.99),
(15, 'Bass Drop', 8, 1, 6, 'Dua Lipa', 200000, 4200000, 1.29),
(16, 'Night Drive', 8, 2, 6, 'Dua Lipa', 210000, 4300000, 1.29),
(17, 'Rising Hero', 9, 3, 2, 'Hans Zimmer', 270000, 5200000, 1.49),
(18, 'Final Stand', 9, 3, 2, 'Hans Zimmer', 300000, 5500000, 1.49),
(19, 'Thunder Run', 10, 1, 2, 'Imagine Dragons', 230000, 4700000, 1.29),
(20, 'Sandstorm Echo', 10, 1, 6, 'Imagine Dragons', 220000, 4650000, 1.29),
(21, 'Ocean Mist', 11, 2, 3, 'Coldplay', 240000, 4800000, 1.29),
(22, 'Deep Blue', 11, 2, 3, 'Coldplay', 250000, 4850000, 1.29),
(23, 'Golden Hour', 12, 1, 1, 'Ed Sheeran', 225000, 4600000, 1.29),
(24, 'Last Train Home', 12, 1, 1, 'Ed Sheeran', 235000, 4700000, 1.29);

-- -------------------------
-- 6. EMPLOYEE
-- -------------------------
INSERT INTO Employee (EmployeeId, LastName, FirstName, Title, ReportsTo, BirthDate, HireDate,
                      Address, City, State, Country, PostalCode, Phone, Fax, Email)
VALUES
(1, 'Sharma', 'Neha', 'Sales Manager', NULL, DATE '1985-06-15', DATE '2015-03-01',
 '123 Market St', 'Mumbai', 'MH', 'India', '400001', '+91-22-111111', NULL, 'neha.sharma@example.com'),
(2, 'Patel', 'Rohan', 'Sales Support', 1, DATE '1990-09-20', DATE '2018-07-10',
 '45 River Rd', 'Ahmedabad', 'GJ', 'India', '380001', '+91-79-222222', NULL, 'rohan.patel@example.com'),
(3, 'Mehta', 'Kiran', 'IT Specialist', 1, DATE '1988-02-11', DATE '2016-09-05',
 '8 Lake View', 'Vadodara', 'GJ', 'India', '390001', '+91-265-333333', NULL, 'kiran.mehta@example.com'),
(4, 'Desai', 'Isha', 'Account Manager', 1, DATE '1992-11-25', DATE '2019-01-15',
 '9 Sunrise Apt', 'Surat', 'GJ', 'India', '395001', '+91-261-444444', NULL, 'isha.desai@example.com'),
(5, 'Nair', 'Krish', 'Support Engineer', 3, DATE '1987-08-03', DATE '2017-06-20',
 '56 Green Park', 'Delhi', 'DL', 'India', '110016', '+91-11-555555', NULL, 'krish.nair@example.com');

-- -------------------------
-- 7. CUSTOMER
-- -------------------------
INSERT INTO Customer (CustomerId, FirstName, LastName, Company, Address, City, State,
                      Country, PostalCode, Phone, Fax, Email, SupportRepId)
VALUES
(1, 'Priya',  'Desai',   NULL, '12 Lake View',        'Mumbai',   'MH', 'India',    '400050', '+91-901000000', NULL, 'priya.desai@example.com', 2),
(2, 'John',   'Smith',   'TechNova',  '101 Main St',  'New York', 'NY', 'USA',      '10001',  '+1-212-5550101', NULL, 'john.smith@example.com', 1),
(3, 'Emma',   'Johnson', NULL, '22 Baker Street',     'London',   NULL, 'UK',       'NW16XE', '+44-20-5550102', NULL, 'emma.johnson@example.com', 4),
(4, 'Aarav',  'Shah',    NULL, '22 River Bank',       'Pune',     'MH', 'India',    '411001', '+91-904000000', NULL, 'aarav.shah@example.com', 2),
(5, 'Sofia',  'Garcia',  NULL, '45 Gran Via',         'Madrid',   NULL, 'Spain',    '28001',  '+34-91-5550103', NULL, 'sofia.garcia@example.com', 3),
(6, 'Liam',   'Brown',   NULL, '77 King Street',      'Toronto',  'ON', 'Canada',   'M5H2N2', '+1-416-5550104', NULL, 'liam.brown@example.com', 5),
(7, 'Diya',   'Patel',   NULL, '34 City Center',      'Surat',    'GJ', 'India',    '395003', '+91-905000000', NULL, 'diya.patel@example.com', 4),
(8, 'Lucas',  'Miller',  NULL, '89 Lindenstrasse',    'Berlin',   NULL, 'Germany',  '10115',  '+49-30-5550105', NULL, 'lucas.miller@example.com', 1),
(9, 'Harsh',  'Kumar',   NULL, '78 Central Plaza',    'Lucknow',  'UP', 'India',    '226001', '+91-917000000', NULL, 'harsh.kumar@example.com', 5),
(10,'Sara',   'Ali',     NULL, '5 Sunset Boulevard',  'Goa',      'GA', 'India',    '403001', '+91-920000000', NULL, 'sara.ali@example.com', 4);

-- -------------------------
-- 8. INVOICE
-- (Totals match the sum of related InvoiceLines below)
-- -------------------------
INSERT INTO Invoice (InvoiceId, CustomerId, InvoiceDate,
                     BillingAddress, BillingCity, BillingState,
                     BillingCountry, BillingPostalCode, Total)
VALUES
(1, 1, TIMESTAMP '2025-03-05 10:15:00', '12 Lake View',       'Mumbai',   'MH', 'India',   '400050', 2.28),
(2, 2, TIMESTAMP '2025-03-07 14:30:00', '101 Main St',        'New York', 'NY', 'USA',     '10001',  3.27),
(3, 3, TIMESTAMP '2025-03-09 09:45:00', '22 Baker Street',    'London',   NULL, 'UK',      'NW16XE', 3.87),
(4, 4, TIMESTAMP '2025-03-11 19:20:00', '22 River Bank',      'Pune',     'MH', 'India',   '411001', 3.87),
(5, 5, TIMESTAMP '2025-03-14 11:05:00', '45 Gran Via',        'Madrid',   NULL, 'Spain',   '28001',  3.27),
(6, 6, TIMESTAMP '2025-03-18 16:10:00', '77 King Street',     'Toronto',  'ON', 'Canada',  'M5H2N2', 3.87),
(7, 7, TIMESTAMP '2025-03-21 08:55:00', '34 City Center',     'Surat',    'GJ', 'India',   '395003', 2.98),
(8, 8, TIMESTAMP '2025-03-25 13:40:00', '89 Lindenstrasse',   'Berlin',   NULL, 'Germany', '10115',  3.87),
(9, 9, TIMESTAMP '2025-03-28 17:25:00', '78 Central Plaza',   'Lucknow',  'UP', 'India',   '226001', 3.87),
(10,10,TIMESTAMP '2025-04-02 12:00:00', '5 Sunset Boulevard', 'Goa',      'GA', 'India',   '403001', 3.57),
(11,2, TIMESTAMP '2025-04-05 09:20:00', '101 Main St',        'New York', 'NY', 'USA',     '10001',  3.27),
(12,4, TIMESTAMP '2025-04-08 18:45:00', '22 River Bank',      'Pune',     'MH', 'India',   '411001', 3.87);

-- -------------------------
-- 9. INVOICELINE
-- (Matches invoice totals above)
-- -------------------------
INSERT INTO InvoiceLine (InvoiceLineId, InvoiceId, TrackId, UnitPrice, Quantity) VALUES
-- Invoice 1: 0.99 + 1.29 = 2.28
(1, 1, 1, 0.99, 1),
(2, 1, 3, 1.29, 1),

-- Invoice 2: 1.29 + (0.99*2) = 3.27
(3, 2, 5, 1.29, 1),
(4, 2, 6, 0.99, 2),

-- Invoice 3: 1.29 + 1.29 + 1.29 = 3.87
(5, 3, 7, 1.29, 1),
(6, 3, 8, 1.29, 1),
(7, 3, 9, 1.29, 1),

-- Invoice 4: 1.29 + (1.29*2) = 3.87
(8, 4, 10, 1.29, 1),
(9, 4, 11, 1.29, 2),

-- Invoice 5: 0.99 + 1.29 + 0.99 = 3.27
(10, 5, 12, 0.99, 1),
(11, 5, 13, 1.29, 1),
(12, 5, 14, 0.99, 1),

-- Invoice 6: (1.29*2) + 1.29 = 3.87
(13, 6, 15, 1.29, 2),
(14, 6, 16, 1.29, 1),

-- Invoice 7: 1.49 + 1.49 = 2.98
(15, 7, 17, 1.49, 1),
(16, 7, 18, 1.49, 1),

-- Invoice 8: (1.29*2) + 1.29 = 3.87
(17, 8, 19, 1.29, 2),
(18, 8, 20, 1.29, 1),

-- Invoice 9: 1.29 + (1.29*2) = 3.87
(19, 9, 21, 1.29, 1),
(20, 9, 22, 1.29, 2),

-- Invoice 10: 1.29 + 1.29 + 0.99 = 3.57
(21, 10, 23, 1.29, 1),
(22, 10, 24, 1.29, 1),
(23, 10, 1,  0.99, 1),

-- Invoice 11: (0.99*2) + 1.29 = 3.27
(24, 11, 2,  0.99, 2),
(25, 11, 5,  1.29, 1),

-- Invoice 12: (1.29*2) + 1.29 = 3.87
(26, 12, 8,  1.29, 2),
(27, 12, 15, 1.29, 1);

-- -------------------------
-- 10. PLAYLIST
-- -------------------------
INSERT INTO Playlist (PlaylistId, Name) VALUES
(1, 'Morning Motivation'),
(2, 'Chill Evenings'),
(3, 'Workout Mix'),
(4, 'Study Session'),
(5, 'Bollywood Hits');

-- -------------------------
-- 11. PLAYLISTTRACK
-- -------------------------
INSERT INTO PlaylistTrack (PlaylistId, TrackId) VALUES
(1, 1),
(1, 3),
(1, 7),
(1, 13),
(1, 23),

(2, 2),
(2, 4),
(2, 9),
(2, 16),
(2, 21),

(3, 11),
(3, 15),
(3, 17),
(3, 19),
(3, 20),

(4, 5),
(4, 8),
(4, 12),
(4, 22),
(4, 24),

(5, 1),
(5, 2),
(5, 5),
(5, 6),
(5, 14);

COMMIT;
