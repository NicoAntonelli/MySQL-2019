/*
5) Cuantas entrevistas fueron hechas por cada entrevistador en octubre de 2014. 
*/

SELECT ent.nombre_entrevistador, count(*) "Cantidad de Entrevistas"
FROM agencia_personal.entrevistas ent
WHERE year(ent.fecha_entrevista) = 2014 AND month(ent.fecha_entrevista) = 10
GROUP BY ent.nombre_entrevistador;
