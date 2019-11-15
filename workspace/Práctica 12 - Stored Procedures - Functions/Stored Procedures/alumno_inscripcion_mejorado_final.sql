CREATE DEFINER=`root`@`localhost` PROCEDURE `alumno_inscripcion_mejorado_final`(dni_alumno Integer(11), plan VarChar(20), curso Integer(11))
BEGIN
	# Valido si existe la inscripcion con una variable
	SET @dni = NULL;
    SELECT ins.dni INTO @dni FROM inscripciones ins
    WHERE ins.nom_plan = plan AND ins.nro_curso = curso AND ins.dni = dni_alumno;
    
    # Si ya está inscripto, informo por pantalla. Sino, lo inscribo
    IF (@dni IS NOT NULL)
    THEN
		SELECT concat("El Alumno ", dni_alumno, " ya está inscripto a ese curso") AS "Aviso";
    ELSE
		START TRANSACTION;
			INSERT INTO inscripciones
			VALUES (plan, curso, dni_alumno, CURRENT_DATE);
			
			INSERT INTO cuotas
			VALUES (plan, curso, dni_alumno, year(adddate(CURRENT_DATE, interval 1 month)),
			month(adddate(CURRENT_DATE, interval 1 month)), CURRENT_DATE, NULL, NULL);
            
            # Variable para controlar el cupo
            SELECT cur.cupo INTO @cupo FROM cursos cur WHERE cur.nom_plan = plan AND cur.nro_curso = curso;
            
            # Variable para controlar la nueva cantidad de inscripciones
            SELECT count(ins.dni) INTO @newcupo FROM inscripciones ins
            WHERE ins.nom_plan = plan AND ins.nro_curso = curso AND year(ins.fecha_inscripcion) = year(curdate());
            
            # Solo hago Commit si el cupo no se exedió
            IF (@newcupo > @cupo)
            THEN
				ROLLBACK;
				SELECT "No se puede inscribir a este curso porque el cupo está lleno" AS "Aviso";
            ELSE
				COMMIT;
				SELECT "Inscripción realizada correctamente" AS "Aviso";
			END IF;
	END IF;
END