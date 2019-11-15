/*
6) Ídem 4) pero para todos los entrevistadores. Mostrar nombre y cantidad. Ordenado por             
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
GROUP BY ee.cod_evaluacion, ent.nombre_entrevistador HAVING avg(ee.resultado) > 71
ORDER BY 3 ASC, 4 DESC, 5 ASC; 
