/*
10) Mostrar aquellos antecedentes laborales que finalizaron y cuya fecha hasta no esté entre
junio del 2013 a diciembre de 2013, ordenados por número de DNI del empleado.
*/

SELECT *
FROM agencia_personal.antecedentes
WHERE fecha_hasta IS NOT NULL AND fecha_hasta NOT BETWEEN "2013-06-01" AND "2013-12-31"
ORDER BY dni ASC;
