## CRUD ( CREATE - READ - UPDATE - DELETE )
## READ

SELECT * FROM movies;

## CREATE
insert into movies(title) values ("spiderman");

SELECT * FROM movies;

SELECT * FROM movies WHERE title = "spiderman";

## DELETE

DELETE FROM movies WHERE title = "Spiderman vs. Godzilla";

## UPDATE

insert into movies (title) values ("spiderman");

UPDATE movies SET title = "Spiderman vs. Godzilla" WHERE title = "spiderman";

ALTER TABLE movies DROP COLUMN year;







