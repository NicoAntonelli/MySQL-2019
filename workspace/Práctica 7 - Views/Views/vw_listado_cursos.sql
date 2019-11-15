CREATE OR REPLACE VIEW `vw_listado_cursos` AS
	SELECT cur.nom_plan "Nombre del Plan", pc.desc_plan "Descripcion del Plan",
	cur.nro_curso "Nro. del Curso", cur.fecha_ini "Fecha Inicio", cur.fecha_fin 'Fecha Fin',
    cur.salon "Salón", cur.cupo "Cupo", count(*) "Cantidad Alumnos"
	FROM cursos cur INNER JOIN plan_capacitacion pc ON cur.nom_plan = pc.nom_plan
    INNER JOIN inscripciones ins ON cur.nom_plan = ins.nom_plan AND cur.nro_curso = ins.nro_curso
	WHERE year(cur.fecha_ini) = "2015" # year(CURRENT_DATE)
	GROUP BY cur.nom_plan, pc.desc_plan, cur.nro_curso, cur.fecha_ini, cur.fecha_fin, cur.salon, cur.cupo;
