/*
12) Ídem 11) pero usar una variable para obtener el CUIL de Elias Yanes.
--> El 11) Eliminar los instructores que tienen de supervisor a Elias Yanes (CUIL 99-99999999-9).
*/

SELECT cuil INTO @vcuil FROM instructores WHERE cuil = "99-99999999-9";
SELECT * FROM instructores WHERE cuil_supervisor = @vcuil;

START TRANSACTION;
	DELETE FROM instructores WHERE cuil_supervisor = @vcuil;
COMMIT;
