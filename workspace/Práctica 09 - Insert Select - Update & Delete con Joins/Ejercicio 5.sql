/*
5) Cambiar el horario de los cursos que dicta en 2009 Franz Kafka (cuil 66-66666666-6) desde las 16 hs. Moverlos una hora más temprano.
(Nota: 2009 porque era el "actual" cuando se hizo el ejercicio, lo cambio por algo que tenga sentido en la DB, tipo 2015).
*/

START TRANSACTION;
	UPDATE cursos_horarios ch
    INNER JOIN cursos_instructores ci ON ch.nom_plan = ci.nom_plan AND ch.nro_curso = ci.nro_curso
    INNER JOIN cursos cur ON ci.nom_plan = cur.nom_plan AND ci.nro_curso = cur.nro_curso
    SET ch.hora_inicio = addtime(ch.hora_inicio, -010000), ch.hora_fin = addtime(ch.hora_fin, -010000)
    WHERE ci.cuil = "66-66666666-6" AND ch.hora_inicio = "160000" AND year(cur.fecha_ini) = "2015";
COMMIT;
