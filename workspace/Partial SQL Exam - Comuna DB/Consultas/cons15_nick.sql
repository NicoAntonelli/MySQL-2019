/*
Consulta Nick (15):
Seleccionar las competencias que tengan un costo de inscripción mayor al promedio de todas las inscripciones a competencias,
mostrando número de evento, código y nombre de competencia, dni jurado, nombre completo del jurado, premios, costo de inscripción,
y el valor promedio de las inscripciones.
*/

SELECT avg(com.costo_inscripcion) INTO @promInscripVar
FROM comuna.competencia com;

SELECT com.nro_evento, com.codigo_tipo_competencia, tc.descripcion, com.dni_jurado, concat(jur.nombre, " ", jur.apellido) "jurado_fullname",
com.premios, com.costo_inscripcion, @promInscripVar "promedio_inscripciones"
FROM comuna.competencia com
INNER JOIN comuna.jurado jur ON com.dni_jurado = jur.dni
INNER JOIN comuna.tipo_competencia tc ON com.codigo_tipo_competencia = tc.codigo
WHERE com.costo_inscripcion > @promInscripVar;
