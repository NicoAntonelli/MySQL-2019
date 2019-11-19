/*
6) El alumno Victor Hugo se ha mudado. Actualizar su dirección a Italia 2323 y su teléfono nuevo es 23232323.
*/

SELECT dni INTO @dni_v FROM alumnos
WHERE nombre = "Victor" AND apellido = "Hugo";

START TRANSACTION;
	UPDATE alumnos SET direccion = "Italia 2323", tel = "23232323" WHERE dni = @dni_v;
COMMIT;
