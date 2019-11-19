/*
8) Determinar las empresas que pagaron en promedio la mayor o menor de las comisiones.
NOTA: MISMO ENUNCIADO QUE EL EJ5!
*/

SELECT max(com.importe_comision) INTO @var_maximport
FROM agencia_personal.comisiones com;

SELECT min(com.importe_comision) INTO @var_minimport
FROM agencia_personal.comisiones com;

SELECT emp.razon_social, avg(com.importe_comision) "Promedio"
FROM agencia_personal.contratos con
INNER JOIN agencia_personal.empresas emp ON con.cuit = emp.cuit
INNER JOIN agencia_personal.comisiones com ON con.nro_contrato = com.nro_contrato
GROUP BY emp.razon_social HAVING avg(com.importe_comision) IN (@var_maximport, @var_minimport);
