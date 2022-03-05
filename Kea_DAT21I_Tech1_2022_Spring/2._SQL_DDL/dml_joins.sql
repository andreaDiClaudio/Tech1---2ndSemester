SELECT directors.name, movies.title, movies.year
FROM directors JOIN movies ON directors.movie_id =  movies.id
WHERE movie_id = 1;

-- SELECT * FROM (directos, movies) WHERE directors.movie.id = directors.movie_id;