CREATE OR REPLACE VIEW `vw_listado_cursos_con_precio` AS
	SELECT cur.nom_plan "Nombre del Plan", pc.desc_plan "Descripcion del Plan",
	cur.nro_curso "Nro. del Curso", cur.fecha_ini "Fecha Inicio", cur.fecha_fin 'Fecha Fin',
    cur.salon "Salón", cur.cupo "Cupo", count(*) "Cantidad Alumnos"
	FROM cursos cur INNER JOIN plan_capacitacion pc ON cur.nom_plan = pc.nom_plan
    INNER JOIN inscripciones ins ON cur.nom_plan = ins.nom_plan AND cur.nro_curso = ins.nro_curso
	WHERE year(cur.fecha_ini) = "2015" # year(CURRENT_DATE)
	GROUP BY cur.nom_plan, pc.desc_plan, cur.nro_curso, cur.fecha_ini, cur.fecha_fin, cur.salon, cur.cupo;
    # Hasta ahora es equivalente a la vista "vw_listado_cursos", le vamos a agregar el precio actual
    
    # Tabla temporal con la última fecha de cada plan
	DROP TEMPORARY TABLE IF EXISTS temp_planes_fechas;
	CREATE TEMPORARY TABLE temp_planes_fechas
		SELECT vp.nom_plan, max(vp.fecha_desde_plan) ult_fecha
		FROM valores_plan vp
		GROUP BY vp.nom_plan;
	
    # Llamo a recursivamente a la view actual para agregarle lo que falta
    # Nota: Si llamo directamente a la otra view ya hecha, habría problemas
    SELECT vlc.`Nombre del Plan`, vlc.`Descripcion del Plan`, vlc.`Nro. del Curso`, vlc.`Fecha Inicio`,
    vlc.`Fecha Fin`, vlc.`Salón`, vlc.`Cupo`, vlc.`Cantidad Alumnos`, tpf.ult_fecha `Valor Actual`
    FROM `vw_listado_cursos_con_precio` vlc
    INNER JOIN temp_planes_fechas tpf ON vlc.`Nombre del Plan` = tpf.nom_plan
    INNER JOIN valores_plan vp ON vlc.`Nombre del Plan` = vp.nom_plan
    WHERE tpf.ult_fecha = vp.fecha_desde_plan;
