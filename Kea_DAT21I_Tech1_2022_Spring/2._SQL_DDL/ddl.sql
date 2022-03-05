SHOW TABLES;

## One to one relationship. When you have a one to one relationship you can avoid specifying what id it is, because every action we need to call the table (movies.id / directors.id )
# Design phase
CREATE TABLE IF NOT EXISTS movies(
    id INT AUTO_INCREMENT PRIMARY KEY,  -- Since primary key is already unique, you do not need to add NOT NULL.
    title VARCHAR (255) NOT NULL,
    year YEAR
);

CREATE TABLE IF NOT EXISTS directors  (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR (100) NOT NULL,
    movie_id INT NOT NULL,
    FOREIGN KEY (movie_id) REFERENCES movies(id)
);

# Migration phase
ALTER TABLE movies ADD COLUMN year YEAR(4) NOT NULL AFTER title;

DROP TABLE directors;



