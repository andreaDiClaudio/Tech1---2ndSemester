-- 1. Show the members under the name "Jens S." who were born before 1970 that became members of the library in 2013.
SELECT * FROM library.tmember
WHERE cName = "Jens S."
  AND dBirth < "1970-01-01"
  AND dNewMember > "2013-01-01"
  AND dNewMember < "2013-12-31";

-- 2. Show those books that have not been published by the publishing companies with ID 15 and 32, except if they were published before 2000.
SELECT * FROM tbook
WHERE npublishingcompanyid NOT IN (15, 32)
   OR npublishingyear < 2000
ORDER BY nPublishingCompanyID;

-- 3. Show the name and surname of the members who have a phone number, but no address.
SELECT * FROM tmember
WHERE cPhoneNo IS NOT NULL
  AND cAddress IS NULL;

-- 4. Show the authors with surname "Byatt" whose name starts by an "A" (uppercase) and contains an "S" (uppercase).
SELECT * FROM tauthor
WHERE cSurname = "Byatt"
  AND cName = "A. S." ;

-- 5. Show the number of books published in 2007 by the publishing company with ID 32.
SELECT COUNT(*) FROM tbook
WHERE npublishingyear = 2007
  AND npublishingcompanyid = 32;

-- 6. For each day of the year 2014, show the number of books loaned by the member with CPR "0305393207";
SELECT COUNT(*) FROM tloan
WHERE dLoan BETWEEN "2014-01-01" AND "2014-12-31"
  AND cCPR = 0305393207;

-- 7. Modify the previous clause so that only those days where the member has loaned more than one book appear.
SELECT COUNT(dLoan) AS cnt FROM tloan
WHERE dLoan BETWEEN "2014-01-01" AND "2014-12-31"
  AND cCPR = 0305393207
GROUP BY dLoan
HAVING cnt > 1;

-- 8. Show all library members from the newest to the oldest.
--    Those who became members on the same day will be sorted alphabetically (by surname and name) within that day.
SELECT * FROM tmember
ORDER BY dNewMember DESC, cSurname ASC, cName ASC;

-- 9. Show the title of all books published by the publishing company with ID 32 along with their theme or themes.
SELECT cTitle, cName
FROM library.tbook, library.ttheme, tbooktheme
WHERE tbook.nBookID = tbooktheme.nBookID
  AND ttheme.nThemeID = tbooktheme.nThemeID
  AND tbook.nPublishingCompanyID = 32;

-- 10. Show the name and surname of every author along with the number of books authored by them, but only for authors who have registered books on the database.
SELECT cName, cSurname, COUNT(tauthorship.nBookID IS NOT NULL ) AS bookPublished
FROM tauthor JOIN tauthorship
    ON tauthor.nAuthorID = tauthorship.nAuthorID
GROUP BY cName, cSurname;

-- 11. Show the name and surname of all the authors with published books along with the lowest publishing year for their books.
SELECT cName name, cSurname surname, MIN(nPublishingYear) AS firstPublication
FROM tauthor JOIN tauthorship t ON tauthor.nAuthorID = t.nAuthorID
    JOIN tbook t2 on t.nBookID = t2.nBookID
GROUP BY cName, cSurname;

-- 12 For each signature and loan date, show the title of the corresponding books and the name and surname of the member who had them loaned.
SELECT tloan.csignature AS signature,
       tloan.dloan AS date,
       tbook.ctitle AS title,
       tmember.cname AS memberName,
       tmember.csurname AS memberSurname
FROM tloan
    JOIN tbookcopy
        ON tloan.csignature = tbookcopy.csignature
    JOIN tbook
        ON tbookcopy.nbookid = tbook.nbookid
    JOIN tmember
        ON tloan.ccpr = tmember.ccpr
ORDER BY signature, date;

-- 14  Show all theme names along with the titles of their associated books. All themes must appear (even if there are no books for some particular themes). Sort by theme name.
SELECT ttheme.cName, tbook.cTitle
FROM ttheme
    LEFT JOIN tbooktheme
        On ttheme.nThemeID = tbooktheme.nThemeID
    LEFT JOIN tbook
        ON tbooktheme.nBookID = tbook.nBookID;

-- 15 Show the name and surname of all members who joined the library in 2013 along with the title of the books they took on loan during that same year. All members must be shown, even if they did not take any book on loan during 2013. Sort by member surname and name.
SELECT tmember.cName, tmember.cSurname, tmember.dNewMember, tbook.cTitle
FROM tmember
    JOIN tloan
        ON tmember.cCPR = tloan.cCPR
    JOIN tbookcopy
        ON tloan.cSignature = tbookcopy.cSignature
    JOIN tbook
        ON tbookcopy.nBookID= tbook.nBookID
WHERE dNewMember
    BETWEEN "2013-01-01" AND "2013-12-31"
ORDER BY tmember.cName, tmember.cSurname;

-- 16 Show the name and surname of all authors along with their nationality or nationalities and the titles of their books. Every author must be shown, even though s/he has no registered books. Sort by author name and surname.
SELECT tauthor.cName, tauthor.cSurname, tcountry.cName, tbook.cTitle
FROM tauthor
    JOIN tnationality
        ON tauthor.nAuthorID = tnationality.nAuthorID
    JOIN tcountry
        ON tnationality.nCountryID = tcountry.nCountryID
    JOIN tauthorship
        ON tauthor.nAuthorID = tauthorship.nAuthorID
    JOIN tbook
        ON tauthorship.nBookID = tbook.nBookID
ORDER BY tauthor.cName, tauthor.cSurname;

-- 17 Show the title of those books which have had different editions published in both 1970 and 1989.
SELECT tbook.cTitle, COUNT(*) AS c
FROM tbook
WHERE nPublishingYear = 1970
   OR nPublishingYear = 1989
GROUP BY tbook.cTitle
HAVING c > 1;

-- 18 Show the surname and name of all members who joined the library in December 2013 followed by the surname and name of those authors whose name is “William”.
SELECT tmember.cName, tmember.cSurname
FROM tmember
WHERE dNewMember
    BETWEEN "2013-12-01" AND "2013-12-31"
UNION SELECT tauthor.cName, tauthor.cSurname
FROM tauthor WHERE cName = "William";

-- 19. Show the name and surname of the first chronological member of the library using subqueries.
SELECT cName, cSurname FROM tmember WHERE cCPR = (SELECT cCPR FROM tmember ORDER BY dNewMember ASC LIMIT 1);

-- 20 For each publishing year, show the number of book titles published by publishing companies from countries that constitute the nationality for at least three authors. Use subqueries.
SELECT DISTINCT(nPublishingYear), COUNT(nPublishingYear) AS numberOfBook FROM tbook WHERE nPublishingCompanyID IN (SELECT tpublishingcompany.nPublishingCompanyID FROM tpublishingcompany WHERE nCountryID IN (SELECT tnationality.nCountryID FROM tnationality WHERE nAuthorID IN (SELECT tauthor.nAuthorID FROM tauthor) GROUP BY tnationality.nCountryID HAVING count(*) > 3)) GROUP BY nPublishingYear ORDER BY nPublishingYear;

-- 21 Show the name and country of all publishing companies with the headings "Name" and "Country"
SELECT tpublishingcompany.cName Name, tcountry.cName FROM tpublishingcompany JOIN tcountry ON tpublishingcompany.nCountryID = tcountry.nCountryID;

-- 22 Show the titles of the books published between 1926 and 1978 that were not published by the publishing company with ID 32.
SELECT tbook.cTitle FROM tbook WHERE nPublishingYear BETWEEN "1926-01-01" AND "1978-01-01" AND NOT tbook.nPublishingCompanyID = 32;

-- 23 Show the name and surname of the members who joined the library after 2016 and have no address
SELECT tmember.cName, tmember.cSurname FROM tmember WHERE dNewMember > "2016-12-31" AND cAddress IS NULL;

-- 24  Show the country codes for countries with publishing companies. Exclude repeated values.
SELECT DISTINCT tpublishingcompany.nCountryID FROM tpublishingcompany WHERE nPublishingCompanyID IS NOT NULL;

-- 25  Show the titles of books whose title starts by "The Tale" and that are not published by "Lynch Inc".
SELECT tbook.cTitle FROM tbook  WHERE cTitle LIKE ("The Tale%") AND nPublishingCompanyID IN (SELECT nPublishingCompanyID FROM tpublishingcompany WHERE cName NOT IN ("Lynch Inc"));

-- 26  Show the list of themes for which the publishing company "Lynch Inc" has published books, excluding repeated values.
SELECT DISTINCT ttheme.cName FROM ttheme WHERE nThemeID IN (SELECT nThemeID FROM tbooktheme WHERE nBookID IN (SELECT nBookID FROM tbook WHERE nPublishingCompanyID IN (SELECT nPublishingCompanyID FROM tpublishingcompany WHERE tpublishingcompany.cName = "Lynch Inc" )));

-- 27 Show the titles of those books which have never been loaned
SELECT cTitle FROM tbook WHERE nBookID NOT IN (SELECT nBookID FROM tbookcopy WHERE cSignature IN (SELECT cSignature FROM tloan WHERE dLoan ));

-- 28  For each publishing company, show its number of existing books under the heading "No. of Books".
SELECT DISTINCT tbook.nPublishingCompanyID, COUNT(cTitle) AS "No. of books" FROM tbook GROUP BY nPublishingCompanyID;

-- 29. Show the number of members who took some book on a loan during 2013.
SELECT COUNT(cCPR) FROM tmember WHERE cCPR IN (SELECT cCPR FROM tloan WHERE dLoan BETWEEN "2013-01-01" AND "2013-12-31");

-- 30 For each book that has at least two authors, show its title and number of authors under the heading "No. of Authors".
SELECT tbook.cTitle, COUNT(tauthorship.nAuthorID) AS "No. of Authors" FROM tbook JOIN tauthorship ON tbook.nBookID = tauthorship.nBookID WHERE tbook.nBookID IN (SELECT tauthorship.nBookID FROM tauthorship GROUP BY  tauthorship.nBookID HAVING COUNT(nAuthorID) > 1 ) GROUP BY cTitle;

SELECT * FROM tauthor; -- nAuthorId + cName + cSurname
SELECT * FROM tauthorship; -- nBookID + nAuthorID
SELECT * FROM tbook; -- nBookID + cTitle + nPublishingYear + nPublishingCompanyID
SELECT * FROM tbookcopy; -- cSignature + nBookID
SELECT * FROM tbooktheme; -- nBookID + nThemeID
SELECT * FROM tcountry; -- nCountryID + cName
SELECT * FROM tloan; -- cSignature + cCPR + dLoan
SELECT * FROM tmember; -- cCPR + cName + cSurname + cAddress + cPhoneNo + dBirth + dNewMember
SELECT * FROM tnationality; -- nAuthorID + nCountryID
SELECT * FROM tpublishingcompany; -- nPublishingCompanyID + cName + nCountryID
SELECT * FROM ttheme; -- nThemeID + cName




