/*
2) Mostrar la estructura de la tabla Personas. Mostrar el apellido y nombre y la fecha de
registro en la agencia.
*/

DESCRIBE agencia_personal.personas;

SELECT apellido, nombre, fecha_registro_agencia AS "FECHA INGRESO" FROM agencia_personal.personas;
