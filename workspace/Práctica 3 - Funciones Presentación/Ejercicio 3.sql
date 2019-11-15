/*
3) Para aquellos contratos que terminaron antes de la fecha de finalización, indicar la cantidad
de días que finalizaron antes de tiempo. Función DATEDIFF 
*/

SELECT *, datediff(con.fecha_finalizacion_contrato, con.fecha_caducidad) AS "Días Antes"
FROM agencia_personal.contratos con
WHERE con.fecha_caducidad < con.fecha_finalizacion_contrato;
