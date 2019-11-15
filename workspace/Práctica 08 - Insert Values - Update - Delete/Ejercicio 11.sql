/*
11) Eliminar los instructores que tienen de supervisor a Elias Yanes (CUIL 99-99999999-9).
*/

# Verfico cuales son los instructores que tienen de supervisor a Elías
SELECT * FROM `instructores` WHERE cuil_supervisor = "99-99999999-9";

START TRANSACTION;
	DELETE FROM instructores WHERE cuil_supervisor = "99-99999999-9";
ROLLBACK; # Para poder resolver el ejercicio 12.
