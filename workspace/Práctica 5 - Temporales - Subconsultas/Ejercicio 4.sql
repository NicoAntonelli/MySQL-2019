/*
4) Seleccionar las comisiones pagadas que tengan un importe menor al promedio de todas las
comisiones(pagas y no pagas), mostrando razón social de la empresa contratante, mes
contrato, año contrato , nro. contrato, nombre y apellido del empleado.
*/

SELECT avg(com.importe_comision) INTO @var_avgimport
FROM agencia_personal.comisiones com;

SELECT emp.razon_social, per.nombre, per.apellido, com.nro_contrato,
com.mes_contrato "Mes", com.anio_contrato "Año", com.importe_comision
FROM agencia_personal.comisiones com
INNER JOIN agencia_personal.contratos con
ON con.nro_contrato = com.nro_contrato
INNER JOIN agencia_personal.empresas emp ON con.cuit = emp.cuit
INNER JOIN agencia_personal.personas per ON con.dni = per.dni
WHERE com.fecha_pago IS NOT NULL AND com.importe_comision < @var_avgimport;

# Me quedó un poco diferente al enunciado
