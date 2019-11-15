/*
1) Mostrar las comisiones pagadas por la empresa Tráigame eso. 
*/

# Nota: Todos los atributos que estén en el SELECT, deben estar en el GROUP BY (a excepción de funciones)
# Esto se debe a que desde SQL 5.7 en adelante, está activada por DEFAULT la opción "ONLY_FULL_GROUP_BY"

SELECT emp.razon_social, sum(com.importe_comision) AS "Importe Comisión"
FROM agencia_personal.comisiones com
INNER JOIN agencia_personal.contratos con ON com.nro_contrato = con.nro_contrato
INNER JOIN agencia_personal.empresas emp ON con.cuit = emp.cuit
WHERE emp.razon_social = "Traigame eso" AND com.fecha_pago IS NOT NULL
GROUP BY emp.razon_social;

# También se puede poner: "Group By 1", indicando el 1 que es el primer atributo en el Select
