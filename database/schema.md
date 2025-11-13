# Music Store Database Schema 🎵

This schema represents a small online music store.  
It includes information about **artists, albums, tracks, playlists, customers, employees, and invoices**.

---

## 1. Artist

Stores basic information about music artists.

| Column    | Data Type | Constraints    | Description        |
|----------|-----------|----------------|--------------------|
| ArtistId | INTEGER   | PRIMARY KEY    | Unique artist ID   |
| Name     | VARCHAR   | NOT NULL       | Name of the artist |

---

## 2. Album

Each album belongs to exactly one artist.

| Column   | Data Type | Constraints               | Description          |
|---------|-----------|---------------------------|----------------------|
| AlbumId | INTEGER   | PRIMARY KEY               | Unique album ID      |
| Title   | VARCHAR   | NOT NULL                  | Album title          |
| ArtistId| INTEGER   | FOREIGN KEY → ArtistId    | Artist of the album  |

---

## 3. MediaType

Types of media in which tracks are available (e.g., MPEG audio, Protected AAC, etc.).

| Column     | Data Type | Constraints | Description          |
|-----------|-----------|-------------|----------------------|
| MediaTypeId | INTEGER | PRIMARY KEY | Unique media type ID |
| Name        | VARCHAR |             | Name of media type   |

---

## 4. Genre

Defines the musical genre of a track.

| Column  | Data Type | Constraints | Description         |
|--------|-----------|-------------|---------------------|
| GenreId| INTEGER   | PRIMARY KEY | Unique genre ID     |
| Name   | VARCHAR   |             | Name of the genre   |

---

## 5. Track

Represents individual songs/tracks sold by the store.

| Column       | Data Type | Constraints                          | Description                       |
|--------------|-----------|--------------------------------------|-----------------------------------|
| TrackId      | INTEGER   | PRIMARY KEY                          | Unique track ID                   |
| Name         | VARCHAR   | NOT NULL                             | Track name                        |
| AlbumId      | INTEGER   | FOREIGN KEY → Album.AlbumId         | Album this track belongs to       |
| MediaTypeId  | INTEGER   | FOREIGN KEY → MediaType.MediaTypeId | Media type of the track           |
| GenreId      | INTEGER   | FOREIGN KEY → Genre.GenreId         | Genre of the track                |
| Composer     | VARCHAR   |                                      | Composer name                     |
| Milliseconds | INTEGER   | NOT NULL                             | Track duration in milliseconds    |
| Bytes        | INTEGER   |                                      | File size in bytes                |
| UnitPrice    | DECIMAL   | NOT NULL                             | Price per track                   |

---

## 6. Playlist

Named playlists created to group tracks.

| Column    | Data Type | Constraints | Description        |
|----------|-----------|-------------|--------------------|
| PlaylistId | INTEGER | PRIMARY KEY | Unique playlist ID |
| Name       | VARCHAR |             | Playlist name      |

---

## 7. PlaylistTrack

Associative (join) table connecting playlists and tracks.  
Each row indicates that a given track appears in a given playlist.

| Column    | Data Type | Constraints                          | Description             |
|-----------|-----------|--------------------------------------|-------------------------|
| PlaylistId| INTEGER   | FOREIGN KEY → Playlist.PlaylistId    | Playlist identifier     |
| TrackId   | INTEGER   | FOREIGN KEY → Track.TrackId          | Track identifier        |

> Typically, the **primary key** is the combination `(PlaylistId, TrackId)`.

---

## 8. Employee

Employees working for the music store (e.g., sales, support, managers).

| Column    | Data Type | Constraints                      | Description                              |
|-----------|-----------|----------------------------------|------------------------------------------|
| EmployeeId| INTEGER   | PRIMARY KEY                      | Unique employee ID                       |
| LastName  | VARCHAR   | NOT NULL                         | Employee last name                       |
| FirstName | VARCHAR   | NOT NULL                         | Employee first name                      |
| Title     | VARCHAR   |                                  | Job title                                |
| ReportsTo | INTEGER   | FOREIGN KEY → Employee.EmployeeId| Manager this employee reports to         |
| BirthDate | DATE      |                                  | Date of birth                            |
| HireDate  | DATE      |                                  | Date of hire                             |
| Address   | VARCHAR   |                                  | Street address                           |
| City      | VARCHAR   |                                  | City                                     |
| State     | VARCHAR   |                                  | State/Region                             |
| Country   | VARCHAR   |                                  | Country                                  |
| PostalCode| VARCHAR   |                                  | Postal/ZIP code                          |
| Phone     | VARCHAR   |                                  | Phone number                             |
| Fax       | VARCHAR   |                                  | Fax number                               |
| Email     | VARCHAR   |                                  | Email address                            |

---

## 9. Customer

Customers who buy tracks from the store.

| Column      | Data Type | Constraints                          | Description                           |
|-------------|-----------|--------------------------------------|---------------------------------------|
| CustomerId  | INTEGER   | PRIMARY KEY                          | Unique customer ID                    |
| FirstName   | VARCHAR   | NOT NULL                             | First name                            |
| LastName    | VARCHAR   | NOT NULL                             | Last name                             |
| Company     | VARCHAR   |                                      | Company name (optional)               |
| Address     | VARCHAR   |                                      | Street address                        |
| City        | VARCHAR   |                                      | City                                  |
| State       | VARCHAR   |                                      | State/Region                          |
| Country     | VARCHAR   |                                      | Country                               |
| PostalCode  | VARCHAR   |                                      | Postal/ZIP code                       |
| Phone       | VARCHAR   |                                      | Phone number                          |
| Fax         | VARCHAR   |                                      | Fax number                            |
| Email       | VARCHAR   | NOT NULL                             | Email address                         |
| SupportRepId| INTEGER   | FOREIGN KEY → Employee.EmployeeId    | Employee responsible for this customer|

---

## 10. Invoice

Invoices / orders created when customers purchase tracks.

| Column          | Data Type | Constraints                          | Description                      |
|-----------------|-----------|--------------------------------------|----------------------------------|
| InvoiceId       | INTEGER   | PRIMARY KEY                          | Unique invoice ID                |
| CustomerId      | INTEGER   | FOREIGN KEY → Customer.CustomerId    | Customer who made the purchase   |
| InvoiceDate     | DATETIME  | NOT NULL                             | Date and time of the invoice     |
| BillingAddress  | VARCHAR   |                                      | Billing street address           |
| BillingCity     | VARCHAR   |                                      | Billing city                     |
| BillingState    | VARCHAR   |                                      | Billing state/region             |
| BillingCountry  | VARCHAR   |                                      | Billing country                  |
| BillingPostalCode| VARCHAR  |                                      | Billing postal/ZIP code          |
| Total           | DECIMAL   | NOT NULL                             | Total amount of the invoice      |

---

## 11. InvoiceLine

Line items within each invoice, representing individual track purchases.

| Column       | Data Type | Constraints                          | Description                    |
|--------------|-----------|--------------------------------------|--------------------------------|
| InvoiceLineId| INTEGER   | PRIMARY KEY                          | Unique invoice line ID         |
| InvoiceId    | INTEGER   | FOREIGN KEY → Invoice.InvoiceId      | Invoice this line belongs to   |
| TrackId      | INTEGER   | FOREIGN KEY → Track.TrackId          | Purchased track                |
| UnitPrice    | DECIMAL   | NOT NULL                             | Price per track at purchase    |
| Quantity     | INTEGER   | NOT NULL                             | Quantity purchased (usually 1) |

---

You can use this schema with PostgreSQL, MySQL, or SQLite with minor type adjustments.
