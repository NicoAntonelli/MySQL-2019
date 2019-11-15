/*
3) Mostrar empresas contratantes y sus promedios de comisiones pagadas o a pagar, pero sólo
de aquellas cuyo promedio supere al promedio de Tráigame eso.
*/

# Variable Temporal
SELECT avg(com.importe_comision) INTO @var_avgimport
FROM agencia_personal.empresas emp
INNER JOIN agencia_personal.contratos con ON emp.cuit = con.cuit
INNER JOIN agencia_personal.comisiones com ON con.nro_contrato = com.nro_contrato
WHERE emp.razon_social = "Traigame Eso";

SELECT emp.cuit, emp.razon_social, avg(com.importe_comision) "Importe Comisión"
FROM agencia_personal.empresas emp
INNER JOIN agencia_personal.contratos con ON emp.cuit = con.cuit
INNER JOIN agencia_personal.comisiones com ON con.nro_contrato = com.nro_contrato
GROUP BY 1, 2 HAVING avg(com.importe_comision) > @var_avgimport
