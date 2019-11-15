/*
16) Para conocer la disponibilidad de lugar en los cursos que empiezan en abril para lanzar una campaña se desea
conocer la cantidad de alumnos inscriptos a los cursos que comienzan a partir del 1/04/2014 indicando: Plan de 
Capacitación, curso, fecha de inicio, salón, cantidad de alumnos inscriptos y diferencia con el cupo de alumnos
registrado para el curso que tengan al menos el 80% de lugares disponibles respecto del cupo.

--> Ayuda: tener en cuenta el uso de los paréntesis y la precedencia de los operadores matemáticos.
*/

# Tabla Temporal con los Plan-Curso de abril 2014 a la fecha
DROP TEMPORARY TABLE IF EXISTS temp_cursosabril;
CREATE TEMPORARY TABLE temp_cursosabril
	SELECT * FROM afatse.cursos cur
	WHERE cur.fecha_ini >= "2014-04-01";

# Exhibo los pares Plan-Curso con disponibilidad de al menos 80%
SELECT tcur.nom_plan, tcur.nro_curso, tcur.fecha_ini, tcur.salon, tcur.cupo,
count(ins.dni) "Inscriptos", (tcur.cupo - count(ins.dni)) "Disponibilidad",
concat(round((((tcur.cupo - count(ins.dni)) / tcur.cupo) * 100), 2), "%") "% de Disponibilidad"
FROM temp_cursosabril tcur
INNER JOIN afatse.inscripciones ins ON tcur.nom_plan = ins.nom_plan AND tcur.nro_curso = ins.nro_curso
GROUP BY tcur.nom_plan, tcur.nro_curso, tcur.fecha_ini, tcur.salon, tcur.cupo
HAVING ((tcur.cupo - count(ins.dni)) / tcur.cupo) >= 0.8
ORDER BY tcur.nom_plan, tcur.nro_curso;


# Nota: Se Puede realizar directamente sin ninguna Tabla Temporal:
/*
SELECT cur.nom_plan, cur.nro_curso, cur.fecha_ini, cur.salon, cur.cupo,
count(ins.dni) "Inscriptos", (cur.cupo - count(ins.dni)) "Disponibilidad",
concat(round((((cur.cupo - count(ins.dni)) / cur.cupo) * 100), 2), "%") "% de Disponibilidad"
FROM afatse.cursos cur
INNER JOIN afatse.inscripciones ins ON cur.nom_plan = ins.nom_plan AND cur.nro_curso = ins.nro_curso
WHERE cur.fecha_ini >= "2014-04-01"
GROUP BY cur.nom_plan, cur.nro_curso, cur.fecha_ini, cur.salon, cur.cupo
HAVING ((cur.cupo - count(ins.dni)) / cur.cupo) >= 0.8
ORDER BY cur.nom_plan, cur.nro_curso;
*/
