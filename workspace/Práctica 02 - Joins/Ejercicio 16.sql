/*
16) Ranking de Notas por Supervisor e Instructor. El ranking deberá indicar para cada
supervisor los instructores a su cargo y las notas de los exámenes que el instructor haya
corregido en el 2014. Indicando los datos del supervisor , nombre y apellido del instructor,
plan de capacitación, curso, nombre y apellido del alumno, examen, fecha de evaluación y
nota. Ordenado ascendente por nombre y apellido de supervisor y descendente por fecha.
*/

SELECT DISTINCT ifnull(ins2.cuil, "") AS "Cuil Supervisor", ifnull(ins2.nombre, "") AS "Nombre Supervisor",
ifnull(ins2.apellido, "") AS "Apellido Supervisor", ins1.nombre AS "Nombre Instructor",
ins1.apellido AS "Apellido Instructor", ch.nom_plan, ch.nro_curso, alu.nombre, alu.apellido,
eva.nro_examen, eva.fecha_evaluacion, eva.nota
FROM afatse.instructores ins1 LEFT JOIN afatse.instructores ins2 ON ins1.cuil_supervisor = ins2.cuil
INNER JOIN afatse.cursos_instructores ch ON ins1.cuil = ch.cuil
INNER JOIN afatse.evaluaciones eva
ON ch.nom_plan = eva.nom_plan AND ch.nro_curso = eva.nro_curso AND ch.cuil = eva.cuil
INNER JOIN afatse.alumnos alu ON eva.dni = alu.dni
WHERE eva.fecha_evaluacion >= "2014-01-01" AND eva.fecha_evaluacion <= "2014-12-31"
ORDER BY "Nombre Supervisor" ASC, "Apellido Supervisor" ASC, eva.fecha_evaluacion DESC, eva.nota DESC;

# El Enunciado tiene una diferencia con respecto a la base de datos. Revisar!
