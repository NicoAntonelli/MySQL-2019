CREATE DEFINER=`root`@`localhost` PROCEDURE `alumno_inscripcion_mejorado`(dni_alumno Integer(11), plan VarChar(20), curso Integer(11))
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
            
            SELECT "Inscripción realizada correctamente" AS "Aviso";
		COMMIT;
	END IF;
END