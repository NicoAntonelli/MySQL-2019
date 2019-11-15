CREATE DEFINER=`root`@`localhost` PROCEDURE `alumno_inscripcion`(dni_alumno Integer(11), plan VarChar(20), curso Integer(11))
BEGIN
	START TRANSACTION;
		INSERT INTO inscripciones
		VALUES (plan, curso, dni_alumno, CURRENT_DATE);
		
        INSERT INTO cuotas
		VALUES (plan, curso, dni_alumno, year(adddate(CURRENT_DATE, interval 1 month)),
		month(adddate(CURRENT_DATE, interval 1 month)), CURRENT_DATE, NULL, NULL);
    COMMIT;
END
