/*
15) Alumnos cuyo promedio supere al del curso que realizan (el último). Mostrar dni,
nombre y apellido, promedio y promedio del curso (cambio por: promedio del par plan-curso);
*/

# Tabla Temporal con los promedios de cada último par plan-curso (última fecha de curso)
DROP TEMPORARY TABLE IF EXISTS temp_pcpromedios;
CREATE TEMPORARY TABLE temp_pcpromedios
	SELECT eva.nom_plan, eva.nro_curso, max(eva.fecha_evaluacion) "fecha", avg(eva.nota) prom_plan_curso
    FROM afatse.evaluaciones eva GROUP BY eva.nom_plan, eva.nro_curso;

# Tabla Temporal con la fecha del último curso de cada alumno
# Nota: se podría tomar otra medida para indicar "ultimo curso", como última cuota pagada o última evaluación
DROP TEMPORARY TABLE IF EXISTS temp_lastcourses;
CREATE TEMPORARY TABLE temp_lastcourses
	SELECT DISTINCT eva.dni, max(eva.fecha_evaluacion) fecha_last_curso
	FROM afatse.evaluaciones eva GROUP BY eva.dni;

# Tabla Temporal con los promedios de cada alumno en su último curso
DROP TEMPORARY TABLE IF EXISTS temp_alupromedios;
CREATE TEMPORARY TABLE temp_alupromedios
	SELECT eva.dni, eva.nom_plan, eva.nro_curso, avg(eva.nota) prom_alu
    FROM afatse.evaluaciones eva
    INNER JOIN temp_lastcourses tlc ON eva.dni = tlc.dni AND eva.fecha_evaluacion = tlc.fecha_last_curso
    GROUP BY eva.dni, eva.nom_plan, eva.nro_curso;

# Muestro los promedios de cada alumno que haya superado al promedio de su último curso
SELECT alu.dni, alu.nombre, alu.apellido, tap.nom_plan, tap.nro_curso, tap.prom_alu "Prom Alumno",
tpcp.prom_plan_curso "Prom Plan-Curso"
FROM temp_alupromedios tap
INNER JOIN afatse.alumnos alu ON tap.dni = alu.dni
INNER JOIN temp_pcpromedios tpcp ON tap.nom_plan = tpcp.nom_plan AND tap.nro_curso = tpcp.nro_curso
WHERE tap.prom_alu > tpcp.prom_plan_curso;
