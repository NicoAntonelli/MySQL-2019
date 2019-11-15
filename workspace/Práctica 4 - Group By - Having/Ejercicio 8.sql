/*
8) Mostrar para cada contrato cantidad total de las comisiones, cantidad a pagar, cantidad pagadas. 
*/

SELECT con.nro_contrato, count(*) "Total", count(com.fecha_pago) "Pagadas", (count(*) - count(com.fecha_pago)) "A Pagar"
FROM agencia_personal.contratos con
INNER JOIN agencia_personal.comisiones com ON con.nro_contrato = com.nro_contrato
GROUP BY 1;
