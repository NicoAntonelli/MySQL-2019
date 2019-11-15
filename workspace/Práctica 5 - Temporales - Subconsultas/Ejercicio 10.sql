/*
10) En el año 2014, qué cantidad de alumnos se han inscripto a los Planes de Capacitación
indicando para cada Plan de Capacitación la cantidad de alumnos inscriptos y el porcentaje que
representa respecto del total de inscriptos a los Planes de Capacitación dictados en el año.
*/

SELECT count(*) INTO @var_tot_alumnos
FROM afatse.inscripciones ins
WHERE year(ins.fecha_inscripcion) = 2014;
# Es lo mismo poner 2014 y "2014"

SELECT plcap.nom_plan, count(*) "Alumnos", concat(((count(*) * 100) / @var_tot_alumnos), "%") "% Total"
FROM afatse.inscripciones ins
INNER JOIN afatse.plan_capacitacion plcap ON ins.nom_plan = plcap.nom_plan
WHERE year(ins.fecha_inscripcion) = 2014
GROUP BY plcap.nom_plan;
