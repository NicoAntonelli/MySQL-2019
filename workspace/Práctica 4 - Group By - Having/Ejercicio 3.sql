/*
3) Mostrar el promedio, desviación estándar y varianza del puntaje de las evaluaciones de entrevistas,
por tipo de evaluación y entrevistador. Ordenar por promedio en forma ascendente y luego por
desviación estándar en forma descendente. 
*/

SELECT ent.nombre_entrevistador, ee.cod_evaluacion, avg(ee.resultado) "Promedio Resultado",
std(ee.resultado) "Desviación Estandard"
FROM agencia_personal.entrevistas ent
INNER JOIN agencia_personal.entrevistas_evaluaciones ee ON ent.nro_entrevista = ee.nro_entrevista
GROUP BY ee.cod_evaluacion, ent.nombre_entrevistador
ORDER BY 3 ASC, 4 DESC;
