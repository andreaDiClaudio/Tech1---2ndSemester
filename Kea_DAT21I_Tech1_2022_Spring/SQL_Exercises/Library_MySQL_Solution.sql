-- 1. Show the members under the name "Jens S." who were born before 1970 that became members of the library in 2013.
SELECT * FROM library.tmember WHERE cName = "Jens S." AND dBirth < "1970-01-01" AND dNewMember > "2013-01-01" AND dNewMember < "2013-12-31";

-- 2. Show those books that have not been published by the publishing companies with ID 15 and 32, except if they were published before 2000.
SELECT * FROM tbook WHERE npublishingcompanyid NOT IN (15, 32) or npublishingyear < 2000 ORDER BY nPublishingCompanyID;

-- 3. Show the name and surname of the members who have a phone number, but no address.
SELECT * FROM tmember WHERE cPhoneNo IS NOT NULL AND cAddress IS NULL;

-- 4. Show the authors with surname "Byatt" whose name starts by an "A" (uppercase) and contains an "S" (uppercase).
SELECT * FROM tauthor WHERE cSurname = "Byatt" AND cName = "A. S." ;

-- 5. Show the number of books published in 2007 by the publishing company with ID 32.
SELECT COUNT(*) FROM tbook WHERE npublishingyear = 2007 AND npublishingcompanyid = 32;

-- 6. For each day of the year 2014, show the number of books loaned by the member with CPR "0305393207";
SELECT COUNT(*) FROM tloan WHERE dLoan BETWEEN "2014-01-01" AND "2014-12-31" AND cCPR = 0305393207;

-- 7. Modify the previous clause so that only those days where the member has loaned more than one book appear.
SELECT COUNT(dLoan) AS cnt FROM tloan WHERE dLoan BETWEEN "2014-01-01" AND "2014-12-31" AND cCPR = 0305393207 GROUP BY dLoan HAVING cnt > 1;

-- 8. Show all library members from the newest to the oldest.
--    Those who became members on the same day will be sorted alphabetically (by surname and name) within that day.
SELECT * FROM tmember ORDER BY dNewMember DESC, cSurname ASC, cName ASC;

-- 8. Show the title of all books published by the publishing company with ID 32 along with their theme or themes.
