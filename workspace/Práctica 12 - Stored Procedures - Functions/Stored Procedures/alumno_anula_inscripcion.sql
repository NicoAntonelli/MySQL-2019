CREATE DEFINER=`root`@`localhost` PROCEDURE `alumno_anula_inscripcion`(IN alumno INTEGER(11), IN plan VARCHAR(20), IN curso INTEGER(11))
BEGIN
	DECLARE cuotas_pagas INTEGER(11);
	SELECT count(*) INTO cuotas_pagas FROM cuotas
	WHERE nom_plan = plan AND nro_curso = curso AND dni = alumno AND fecha_pago IS NOT NULL;
	
    IF (cuotas_pagas <= 0)
    THEN
		START TRANSACTION;
			DELETE FROM cuotas
			WHERE nom_plan = plan AND nro_curso = curso AND dni = alumno AND fecha_pago IS NULL;
			
			DELETE FROM inscripciones WHERE nom_plan = plan AND nro_curso = curso AND dni = alumno;
		COMMIT;
        SELECT "Inscripción eliminada correctamente" AS "Aviso";
	ELSE
		SELECT "No se puede eliminar la inscripción porque el alumno ya pagó al menos una cuota" AS "Aviso";
	END IF;
END