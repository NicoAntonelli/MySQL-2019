/*
3) Como resultado de una mudanza a otro edificio más grande se ha incrementado la capacidad de los salones,
además la experiencia que han adquirido los instructores permite ampliar el cupo de los cursos.
Para todos los curso con modalidad presencial y semipresencial aumentar el cupo de la siguiente forma:
● 50% para los cursos con cupo menor a 20
● 25% para los cursos con cupo mayor o igual a 20

--> Update!
*/

START TRANSACTION;
	# Primero Update a los los >=20, porque si aumentamos primero el cupo de los <20,
    # en el Update de abajo podrían llegar a ser modificados por segunda vez erróneamente
	UPDATE cursos SET cupo = cupo*1.25 WHERE cupo >= 20;
	UPDATE cursos SET cupo = cupo*1.5 WHERE cupo < 20;
COMMIT;
