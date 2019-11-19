/*
2) Ídem 1) pero para todas las empresas. 
--> El 1) era: Mostrar las comisiones pagadas por la empresa Tráigame eso. 
*/

SELECT emp.razon_social, sum(com.importe_comision)
FROM agencia_personal.comisiones com
INNER JOIN agencia_personal.contratos con ON com.nro_contrato = con.nro_contrato
INNER JOIN agencia_personal.empresas emp ON con.cuit = emp.cuit
WHERE com.fecha_pago IS NOT NULL
GROUP BY emp.razon_social;
