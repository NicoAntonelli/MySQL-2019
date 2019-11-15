/*
7) Ídem 6) para aquellos cuya cantidad de entrevistas por código de evaluación sea mayor que 1.
Ordenado por nombre en forma descendente y por código de evalucación en forma ascendente 
	El 6) era: Ídem 4) pero para todos los entrevistadores. Mostrar nombre y cantidad. Ordenado por             
	cantidad de entrevistas.
	El 4) era: Ídem 3) pero para Angélica Doria, con promedio mayor a 71. Ordenar por código de evaluación. 
	El 3) era: Mostrar el promedio, desviación estándar y varianza del puntaje de las evaluaciones de entrevistas,
	por tipo de evaluación y entrevistador. Ordenar por promedio en forma ascendente y luego por
	desviación estándar en forma descendente. 
*/

SELECT ent.nombre_entrevistador, ee.cod_evaluacion, count(*), round(avg(ee.resultado), 4) "Promedio Resultado",
round(std(ee.resultado), 4) "Desviación Estandard"
FROM agencia_personal.entrevistas ent
INNER JOIN agencia_personal.entrevistas_evaluaciones ee ON ent.nro_entrevista = ee.nro_entrevista
GROUP BY ee.cod_evaluacion, ent.nombre_entrevistador HAVING avg(ee.resultado) > 71 AND count(ee.cod_evaluacion) > 1
ORDER BY 1 DESC, 2 ASC;
