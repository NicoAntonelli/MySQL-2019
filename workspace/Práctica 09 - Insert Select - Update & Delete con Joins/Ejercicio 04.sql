/*
4) Cambiar el supervisor de aquellos instructores que dictan "Reparac PC Avanzada" este año a 66-66666666-6 (Franz Kafka).

--> Update con Join!
*/

START TRANSACTION;
	UPDATE instructores ins
	INNER JOIN cursos_instructores ci ON ins.cuil = ci.cuil
    SET cuil_supervisor = "66-66666666-6"
	WHERE ci.nom_plan = "Reparac PC Avanzada";
COMMIT;
