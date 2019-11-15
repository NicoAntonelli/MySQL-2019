/*
1) Agregar el nuevo instructor Daniel Tapia con cuil: 44-44444444-4, teléfono: 444-444444,
email: dotapia@gmail.com, dirección Ayacucho 4444 y sin supervisor.

--> Insert Values!
*/

START TRANSACTION;
	INSERT INTO instructores VALUES
	("44-44444444-4", "Daniel", "Tapia", "444-444444", "dotapia@gmail.com", "Ayacucho 4444", NULL);
COMMIT;
