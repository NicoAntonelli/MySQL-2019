/*
--> Cambio Base de Datos: AFSATE!
9) Alumnos que se hayan inscripto a más cursos que Antoine de Saint-Exupery. Mostrar
todos los datos de los alumnos, la cantidad de cursos a la que se inscribió y cuantas
veces más que Antoine de Saint-Exupery.
*/

SELECT DISTINCT count(DISTINCT cur.nro_curso) INTO @var_cantcursos
FROM afatse.inscripciones ins
INNER JOIN afatse.cursos cur ON ins.nro_curso = cur.nro_curso AND ins.nom_plan = cur.nom_plan
INNER JOIN afatse.alumnos alu ON ins.dni = alu.dni
WHERE concat(alu.nombre, " ", alu.apellido) = "Antoine de Saint-Exupery";
# count(DISTINCT cur.nro_curso) si es que no se usó la PK Completa de Curso en el ON

SELECT DISTINCT alu.*, count(*) "Cantidad", (count(*) - @var_cantcursos) "Más que Saint-Exupery"
FROM afatse.inscripciones ins
INNER JOIN afatse.cursos cur ON ins.nro_curso = cur.nro_curso AND ins.nom_plan = cur.nom_plan
INNER JOIN afatse.alumnos alu ON ins.dni = alu.dni
GROUP BY alu.dni HAVING count(*) > @var_cantcursos ORDER BY alu.dni;
