/*
8) Eliminar los nuevos apuntes AP-008 y AP-009. Ayuda: Tener en cuenta las CF para poder eliminarlo.
*/

# Verifico que el cod_material a eliminar no esté utilizado en materiales plan.
# Si existe, primero debo eliminar el cod_material de materiales_plan.

SELECT * FROM materiales_plan WHERE cod_material IN ( "AP-008", "AP-009");
# No existe ninguna fila, entonces puedo eliminar el material tranquilamente

START TRANSACTION;
	DELETE FROM materiales WHERE cod_material IN ("AP-008", "AP-009");
COMMIT;
