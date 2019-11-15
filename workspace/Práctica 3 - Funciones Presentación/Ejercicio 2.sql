/*
2) Mostrar los contratos. Indicar nombre y apellido de la persona, razón social de la empresa, fecha de inicio
del contrato y fecha de caducidad del contrato. Si la fecha no ha terminado mostrar “Contrato Vigente”.
Función IFNULL 
*/

SELECT con.nro_contrato, emp.razon_social, per.apellido, per.nombre, con.fecha_incorporacion,
ifnull(con.fecha_caducidad, "Contrato Vigente") AS "Fin Contrato"
FROM agencia_personal.contratos con
INNER JOIN agencia_personal.empresas emp ON con.cuit = emp.cuit
INNER JOIN agencia_personal.personas per ON con.dni = per.dni
ORDER BY con.nro_contrato;
