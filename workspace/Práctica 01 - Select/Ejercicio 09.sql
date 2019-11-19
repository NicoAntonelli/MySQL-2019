/*
9) Mostrar los antecedentes laborales que aún no hayan terminado su relación laboral
ordenados por fecha desde.
*/

SELECT *
FROM agencia_personal.antecedentes
WHERE fecha_hasta IS NULL
ORDER BY fecha_desde ASC;
