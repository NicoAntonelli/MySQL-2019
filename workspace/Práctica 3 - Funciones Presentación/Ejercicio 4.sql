/*
4) Emitir un listado de comisiones impagas para cobrar. Indicar cuit, razón social de la empresa y dirección,
año y mes de la comisión, importe y la fecha de vencimiento que se calcula como la fecha actual más dos meses.
Función ADDDATE con INVERVAL 
*/

SELECT con.cuit, emp.razon_social, emp.direccion, com.anio_contrato, com.mes_contrato,
com.importe_comision, adddate(curdate(), interval 2 month) AS "Fecha Vencimiento"
FROM agencia_personal.contratos con
INNER JOIN agencia_personal.comisiones com ON con.nro_contrato = com.nro_contrato
INNER JOIN agencia_personal.empresas emp ON con.cuit = emp.cuit;
