/*
1) Para aquellos contratos que no hayan terminado, calcular la fecha de caducidad como la fecha de solicitud
más 30 días (no actualizar la base de datos). Función ADDDATE 
*/

SELECT con.nro_contrato, con.fecha_incorporacion, con.fecha_finalizacion_contrato,
adddate(con.fecha_solicitud,30) AS "Fecha Caducidad" 
FROM agencia_personal.contratos con
WHERE fecha_caducidad IS NULL;
