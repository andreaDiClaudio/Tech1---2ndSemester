SHOW TABLES;

CREATE TABLE IF NOT EXISTS movies(
    title VARCHAR (3000) Not null
);


ALTER TABLE movies ADD COLUMN year YEAR(4) NOT NULL AFTER title;

DROP TABLE movies;

