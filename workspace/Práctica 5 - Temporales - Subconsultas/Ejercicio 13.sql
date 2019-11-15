/*
13) ¿Qué instructores que han dictado algún curso del Plan de Capacitación "Marketing 1"
en el año 2014 y no vayan a dictarlo este año? (año 2015)
*/

DROP TEMPORARY TABLE IF EXISTS temp_instruct_2015;
CREATE TEMPORARY TABLE temp_instruct_2015
	SELECT DISTINCT ci.cuil, cur.fecha_ini
    FROM afatse.cursos_instructores ci
    INNER JOIN afatse.cursos cur
    ON ci.nom_plan = cur.nom_plan AND ci.nro_curso = cur.nro_curso
    WHERE ci.nom_plan = "Marketing 1" AND year(cur.fecha_ini) = 2015;

SELECT DISTINCT ci.cuil
FROM afatse.cursos_instructores ci
INNER JOIN afatse.cursos cur
ON ci.nom_plan = cur.nom_plan AND ci.nro_curso = cur.nro_curso
WHERE ci.nom_plan = "Marketing 1" AND year(cur.fecha_ini) = 2014
AND ci.cuil NOT IN (SELECT ti15.cuil FROM temp_instruct_2015 ti15);
