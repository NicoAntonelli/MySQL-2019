CREATE OR REPLACE VIEW `vw_alu_plan` AS
	SELECT alu.dni, concat(alu.nombre, " ", alu.apellido) "Nombre y Apellido",
    eva.nom_plan "Nombre Plan", eva.nro_curso "Nro. Curso", avg(eva.nota) "Promedio"
	FROM alumnos alu INNER JOIN inscripciones ins ON alu.dni = ins.dni
    INNER JOIN evaluaciones eva ON ins.dni = eva.dni AND ins.nom_plan = eva.nom_plan AND ins.nro_curso = eva.nro_curso
    GROUP BY 1 , 2, 3, 4;
    
    DROP TEMPORARY TABLE IF EXISTS temp_impagos;
	CREATE TEMPORARY TABLE temp_impagos
		SELECT dni, count(*) "Cantidad" FROM cuotas
        WHERE fecha_pago IS NULL
        GROUP BY dni;
    
	SELECT vap.`Nombre y Apellido`, vap.`Nombre Plan`, vap.`Nro. Curso`, vap.Promedio, ti.Cantidad
    FROM vw_alu_plan vap
    LEFT JOIN temp_impagos ti ON vap.dni = ti.dni;
    