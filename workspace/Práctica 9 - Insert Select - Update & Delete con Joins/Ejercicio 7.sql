/*
7) Eliminar las inscripciones a los cursos de este año de los alumnos que adeuden cuotas impagas del año pasado.
(Nota: El EJ es de 2009, pero la DB se actualizó unos años después, por lo que lo pienso como 2015 para que tenga sentido con los datos)
*/

# Tabla Temporal con los alumnos que adeudan cuotas del año 2014 (El "anterior" al año propuesto en el enunciado)
DROP TEMPORARY TABLE IF EXISTS temp_alumnos_deudores;
CREATE TEMPORARY TABLE temp_alumnos_deudores
	SELECT DISTINCT cuo.dni FROM cuotas cuo
    WHERE cuo.fecha_pago IS NULL AND year(cuo.fecha_emision) = 2014;

START TRANSACTION;
	DELETE ins FROM inscripciones ins
    INNER JOIN temp_alumnos_deudores tad ON ins.dni = tad.dni
    WHERE year(ins.fecha_inscripcion) = 2015;
COMMIT;

# También podría haber usado el año actual real con algunas de estas formas: "curdate()", "CURRENT_DATE", "CURRENT_DATE()"
