/*
Película(título, año, duración, encolor, presupuesto, nomestudio, idproductor)
Elenco(título, año, nombre, sueldo)
Actor(nombre, dirección, telefono, fechanacimiento, sexo)
Productor(idproductor, nombre, dirección, teléfono)
Estudio(nomestudio, dirección)
*/

-- 1. Actrices de "Las brujas de Salem"
-- Sin Subconsultas
select Actor.nombre
from Pelicula
    join Elenco on Pelitula.titulo = Elenco.titulo
        and Pelicula.anio = Elenco.anio
where Pelicula.titulo = 'Las brujas de Salem'
    and Pelicula.sexo = 'Femenino';

-- Con Subconsultas
select Actor.nombre
from Actor
where Actor.sexo = 'Femenino'
    and Actor.nombre in (select Elenco.nombre
    from Pelicula
        join Elenco on Pelicula.titulo = Elenco.titulo
            and Pelicula.anio = Elenco.anio
    where Pelicula.titulo = 'Las brujas de Salem');


-- 2. Nombres de los actores que aparecen en películas producidas por MGM en 1995.
-- Sin Subconsultas
select Actor.nombre
from Pelicula
    join Elenco on Pelitula.titulo = Elenco.titulo
        and Pelicula.anio = Elenco.anio
    join Actor on Elenco.nombre = Actor.nombre
    join Productor on Pelicula.idproductor = Productor.idproductor
    join Estudio on Pelicula.nomestudio = Estudio.nomestudio
where Estudio.nomestudio = 'MGM'
    and Pelicula.anio = 1995;

-- Con Subconsultas
select Actor.nombre
from Actor
where Actor.nombre in (
select Elenco.nombre
from Película
    join Elenco on Película.título = Elenco.título and Película.año = Elenco.año
    join Productor on Película.idproductor = Productor.idproductor
    join Estudio on Película.nomestudio = Estudio.nomestudio
WHERE Estudio.nomestudio = 'MGM' and Película.año = 1995
);


-- 3. Películas que duran más que "Lo que el viento se llevó (de 1939)".
-- Sin subconsultas
-- No se puede >:(;

-- Con subconsultas
select Pelicula.titulo
from Pelicula
where Pelicula.duracion > (select Pelicula.duracion
from Pelicula
where Pelicula.titulo = 'Lo que el viento se llevo' and Pelicula.anio = 1939);

-- 4. Productores que han hecho más películas que George Lucas.
-- Sin Subconsultas
-- No se puede >:(

-- Con Subconsultas
select Productor.nombre
from Pelicula
    join Productor on Pelicula.idproductor = Productor.idproductor
group by Productor.idproductor, Productor.nombre
having count(Pelicula.titulo) > (select count(Pelicula.titulo)
from Pelicula
    join Productor on Pelicula.idproductor = Productor.idproductor
where Productor.nombre = 'George Lucas');

-- 5.  Nombres de los productores de las peliculas en las que ha aparecido Sharon Stone.
-- Sin Subconsultas
select Productor.nombre
from Pelicula
    join Elenco on Pelicula.titulo = Elenco.titulo
        and Pelicula.anio = Elenco.anio
    join Productor on Pelicula.idproductor = Productor.idproductor
where Elenco.nombre = 'Sharon Stone';

-- Con Subconsultas
select Productor.nombre
from Productor
where Productor.idproductor in (select Pelicula.idproductor
from Pelicula
    join Elenco on Pelicula.titulo = Elenco.titulo
        and Pelicula.anio = Elenco.anio
where Elenco.nombre = 'Sharon Stone');

-- 6. Título de las películas que han sido filmadas más de una vez.
-- Sin subconsultas
-- No se puede >:(

-- Con Subconsultas
select Pelicula.titulo
from Pelicula
where Pelicula.titulo in (select Pelicula.titulo from Pelicula
                          group by Pelicula.titulo, Pelicula.anio
                          having count(Pelicula.titulo) > 1);