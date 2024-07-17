USE MovieMakers;

-- Encontrar películas con ciertas calificaciones
SELECT Nombre, PuntuacionIMDB AS Calificacion
FROM Peliculas_caracteristicas AS pc 
WHERE PuntuacionIMDB > 5;

-- Encontrar películas dirigidas por un director en particular
SELECT Nombre, Directores
FROM Peliculas_caracteristicas AS pc 
WHERE Directores = 'Joe Johnston';

-- Obtener una lista de películas ganadoras de un premio Oscar en una categoría específica
SELECT MejorPelicula 
FROM Oscars AS o;

-- ¿Qué géneros han recibido más premios Óscar?
SELECT DISTINCT COUNT(pc.Genero) AS NumOscars, pc.Genero AS Genero
FROM Peliculas_caracteristicas AS pc 
INNER JOIN Actuaciones AS a USING(IdPelicula)
INNER JOIN Actores AS a2 ON a.NombreActor = a2.Nombre
WHERE a2.Premios LIKE '%Academy Awards USA Win%' OR
	  a2.Premios LIKE '%Academy Awards USA Gan%'
GROUP BY pc.Genero
ORDER BY COUNT(pc.Genero) DESC;

-- ¿Qué género es el mejor valorado en IMDB?
SELECT pc.Genero, ROUND(AVG(pc.PuntuacionIMDB), 2) AS MediaPuntuacion
FROM Peliculas_caracteristicas AS pc 
GROUP BY pc.Genero 
ORDER BY AVG(PuntuacionIMDB) DESC; 

-- ¿En que año se estrenaron más películas?
SELECT COUNT(AnioEstreno) AS NumPeliculas, AnioEstreno 
FROM Peliculas AS p
WHERE Tipo = 'Movie'
GROUP BY AnioEstreno 
ORDER BY COUNT(AnioEstreno) DESC
LIMIT 5;

-- ¿En que año se estrenaron mas cortos?
SELECT COUNT(AnioEstreno) AS NumCortos, AnioEstreno 
FROM Peliculas AS p
WHERE Tipo = 'Short'
GROUP BY AnioEstreno 
ORDER BY COUNT(AnioEstreno) DESC
LIMIT 5;

-- ¿Cuál es la mejor serie valorada en IMDB?
SELECT pc.Nombre, pc.PuntuacionIMDB 
FROM Peliculas_caracteristicas AS pc 
INNER JOIN Peliculas AS p ON pc.IdPelicula = p.IdPelicula
WHERE Tipo = 'Short'
ORDER BY pc.PuntuacionIMDB DESC
LIMIT 1;

-- ¿Cuál es la película mejor valorada en IMDB?
SELECT pc.Nombre, pc.PuntuacionIMDB 
FROM Peliculas_caracteristicas AS pc 
INNER JOIN Peliculas AS p ON pc.IdPelicula = p.IdPelicula
WHERE Tipo = 'Movie'
ORDER BY pc.PuntuacionIMDB DESC
LIMIT 1;
