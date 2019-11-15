/*
7) Eliminar el plan creado en la consulta 2). Ayuda: Tener en cuenta las CF para poder eliminarlo.

--> Delete!
*/

START TRANSACTION;
	DELETE FROM valores_plan WHERE nom_plan = "Administrador de BD" ;
	DELETE FROM materiales_plan WHERE nom_plan = "Administrador de BD";
	DELETE FROM examenes_temas WHERE nom_plan = "Administrador de BD";
	DELETE FROM examenes WHERE nom_plan = "Administrador de BD";
	DELETE FROM plan_temas WHERE nom_plan = "Administrador de BD";
	DELETE FROM plan_capacitacion WHERE nom_plan = "Administrador de BD";
COMMIT;
