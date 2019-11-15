/*
9) Eliminar al instructor Daniel Tapia. Ayuda: Tener en cuenta las CF para poder eliminarlo.
*/

# Verificar si el instructor "44-44444444-4", tiene registros en cursos_instructores, evaluaciones y si existe como cuil_supervisor.
# En los dos 1eros casos no se debería eliminar, en el 3ero debemos actualizar el cuil del supervisor con valor nulo o con otro supervisor.

START TRANSACTION;
	UPDATE instructores SET cuil_supervisor = NULL
	WHERE cuil_supervisor = "44-44444444-4";
	DELETE FROM instructores WHERE cuil = "44-44444444-4";
COMMIT;
