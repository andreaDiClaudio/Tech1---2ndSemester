-- 1. How many songs are there in the playlist “Grunge”?
SELECT COUNT(*)
FROM Track
WHERE Chinook.Track.GenreId = 16;

-- 2. Show information about artists whose name includes the text “Jack” and about artists whose name includes the text “John”, but not the text “Martin”.
SELECT name
FROM Artist
WHERE Name REGEXP 'Jack'
UNION
SELECT Name
FROM Artist
WHERE Name REGEXP 'John'
  AND NOT Name REGEXP  'Martin';

-- 3. For each country where some invoice has been issued, show the total invoice monetary amount, but only for countries where at least $100 have been invoiced. Sort the information from higher to lower monetary amount.
SELECT BillingCountry, SUM(Total) tot FROM Invoice  GROUP BY BillingCountry  HAVING SUM(Total) > 100 ORDER BY tot DESC ;

-- 4. Get the phone number of the boss of those employees who have given support to clients who have bought some song composed by “Miles Davis” in “MPEG Audio File” format.
SELECT Employee.Phone
FROM Employee
    JOIN Customer C
        ON Employee.EmployeeId = C.SupportRepId
    JOIN Invoice
        ON C.CustomerId = Invoice.CustomerId
    JOIN InvoiceLine
        ON Invoice.InvoiceId = InvoiceLine.InvoiceId
    JOIN Track T
        ON InvoiceLine.TrackId = T.TrackId WHERE Name LIKE 'Miles Davis'
UNION SELECT MediaTypeId FROM MediaType WHERE Name = 'MPEG Audio File';
-- I don't know why it is giving me just how many phone number found, instead of the actual phone number

-- 5 Show the information, without repeated records, of all albums that feature songs of the “Bossa Nova” genre whose title starts by the word “Samba”.
SELECT DISTINCT *
FROM Album
    JOIN Track T
        on Album.AlbumId = T.AlbumId
WHERE Name LIKE 'Samba%' AND GenreId = 11;

-- 6. For each genre, show the average length of its songs in minutes (without indicating seconds). Use the headers “Genre” and “Minutes”, and include only genres that have any song longer than half an hour.
SELECT Genre.Name AS Genre, AVG(FORMAT(Milliseconds / 60,000, 1)) AS minutes
FROM Genre
    JOIN Track T on Genre.GenreId = T.GenreId
GROUP BY Genre.Name;

-- 7 How many client companies have no state?
SELECT COUNT(Company) FROM Customer WHERE State IS NULL;

-- 8 For each employee with clients in the “USA”, “Canada” and “Mexico” show the number of clients from these countries s/he has given support, only when this number is higher than 6. Sort the query by number of clients.
--   Regarding the employee, show his/her first name and surname separated by a space. Use “Employee” and “Clients” as headers.
SELECT CONCAT(employee.firstname, " ", employee.lastname) AS Employee, COUNT(*) AS Client
FROM customer
    JOIN employee ON customer.supportrepid = employee.employeeid
WHERE customer.country = "USA" OR customer.country = "Mexico" OR customer.country = "Canada"
GROUP BY employeeid HAVING client > 6;

-- 9 For each client from the “USA”, show his/her surname and name (concatenated and separated by a comma) and their fax number. If they do not have a fax number, show the text “S/he has no fax”. Sort by surname and first name.
SELECT CONCAT(LastName, ', ', FirstName) AS client, COALESCE(Fax, 'S/He has no fax') AS fax
FROM Customer
ORDER BY LastName, FirstName;

-- For each employee, show his/her first name, last name, and their age at the time they were hired.
SELECT FirstName, LastName, FLOOR(DATEDIFF(HireDate, BirthDate)/365.25)
FROM Employee;

USE Chinook;
SELECT * FROM Chinook.Album; -- AlbumID(PK), Title, ArtistID(FK)
SELECT * FROM Chinook.Artist; -- ArtistID(PK), Name
SELECT * FROM Chinook.Customer; -- CostumerID(PK), FirstName, LastName, Company, Address, City ,State, Country, PostalCode, Phone, Fax, Email, SupportRepID(FK)
SELECT * FROM Chinook.Employee; -- EmployeeID(PK), LastName, FirstName, Title, ReportsTo(FK), BirthDate, HireDate, Address, City, State, Country, PostalCode, Phone, Fax, Email
SELECT * FROM Chinook.Genre; -- GenreId(PK), Name
SELECT * FROM Chinook.Invoice; -- InvoiceId(PK), CustomerId(FK), InvoiceDate, BillingAddress, BillingCity, BillingState, BillingCountry, CollingPostalCode, Total
SELECT * FROM InvoiceLine; -- InvoiceLineId(PK), InvoiceID(FK), TrackId(FK), UnitPrice, Quantity
SELECT * FROM Chinook.MediaType; -- MediaTypeId(PK), Name
SELECT * FROM Chinook.Playlist; -- PlaylistId, Name
SELECT * FROM Chinook.PlaylistTrack; -- PlaylistId(PK-FK), TrackId(PK-FK)
SELECT * FROM Chinook.Track; -- TrackId(PK), Name, AlbumId(FK), MediaTypeId(FK), GenreId(FK), Composer, Milliseconds, Bytes, UnitPrice