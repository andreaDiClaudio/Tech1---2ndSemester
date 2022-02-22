SELECT year FROM movies;

## Select ##

SELECT title, year FROM movies;

SELECT * FROM movies WHERE year = 2021;

SELECT * FROM movies WHERE year < 2021;

SELECT * FROM movies WHERE year > 2020;

SELECT * FROM movies WHERE year > now();

SELECT * FROM movies WHERE year IS NOT NULL ;

SELECT * FROM movies WHERE 1 = 1;

SELECT * FROM movies WHERE TRUE;

SELECT * FROM movies WHERE 2*2 =4;

SELECT * FROM movies ORDER BY title;

SELECT  * FROM movies ORDER BY year;

SELECT * FROM movies ORDER BY year ASC ;

SELECT * FROM movies ORDER BY year DESC;

## Insert

INSERT INTO movies (title, year) VALUES ("Uncharted", 2022);

INSERT INTO movies values ("The Pusisher", 2017);

## INSERT INTO movies (title) VALUES ("Inception");
## Won't work because we have to specify a year value since it is not null







