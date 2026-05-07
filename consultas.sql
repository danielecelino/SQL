-- 1) Países de autores
USE biblioteca;
SELECT distinct pais
from autor;

-- 2) Autores por nombre o país
USE biblioteca;
SELECT nombre as autor
from autor
where nombre like '%ki%' or pais like 'E%';

-- 3) Libros antiguos de Terror o Ciencia  ficción
USE biblioteca;
SELECT codigo_libro, titulo, genero
from libro
where anio_publicacion < '1990' and genero = 'Terror' or genero = 'Ciencia ficcion'
order by codigo_libro desc;

-- 4) Socios recientes con gmail o teléfono 555
USE biblioteca;
SELECT id, nombre, email, telefono, fecha_alta
from socio
where fecha_alta between '2023-01-01' and '2024-12-31' and email like '%gmail%' and telefono like '555%';

-- 5) Libro y autor 
USE biblioteca;
SELECT l.titulo, a.nombre as autor
from libro l
join escribe e on l.id = e.libro_id
join autor a on a.id = e.autor_id;

-- 6) Libros y número de préstamos
USE biblioteca;
SELECT l.codigo_libro, l.titulo, count(p.libro_id) as total_prestamos
from libro l
left join prestamo p on p.libro_id = l.id
group by l.id ;

-- 7) Libros con préstamo
USE biblioteca;
SELECT l.codigo_libro, l.titulo, count(p.libro_id) as total_prestamos
from libro l
join prestamo p on p.libro_id = l.id
group by l.id ;

-- 8) Total de multas por socio
USE biblioteca;
SELECT s.id, s.nombre, sum(m.importe) as total_multas
from multa m 
join prestamo p on p.id = m.prestamo_id
join socio s on s.id = p.socio_id
group by s.id;

-- 9) Socios con más de 2 préstamos
SELECT s.id, s.nombre, COUNT(p.id) as total_prestamos
FROM socio s
JOIN prestamo p ON s.id = p.socio_id
GROUP BY s.id, s.nombre
HAVING total_prestamos > 2;

-- 10) Autor más prestado
SELECT a.nombre as escritor, COUNT(p.id) as total_prestamos
FROM autor a
JOIN escribe e ON a.id = e.autor_id
JOIN libro l ON e.libro_id = l.id
JOIN prestamo p ON l.id = p.libro_id
GROUP BY a.id, a.nombre
ORDER BY total_prestamos DESC
LIMIT 1;


