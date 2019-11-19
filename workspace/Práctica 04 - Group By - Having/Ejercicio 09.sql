/*
9) Mostrar para cada contrato la cantidad de comisiones, el % de comisiones pagas y el % de impagas. 
*/

SELECT con.nro_contrato, count(*) "Total", concat(count(com.fecha_pago)*100/count(*), "%") "Pagadas",
concat((count(*) - count(com.fecha_pago))*100/count(*), "%") "A Pagar"
FROM agencia_personal.contratos con
INNER JOIN agencia_personal.comisiones com ON con.nro_contrato = com.nro_contrato
GROUP BY 1;
