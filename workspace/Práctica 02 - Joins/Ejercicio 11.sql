/*
11) Mostrar para todas las solicitudes la razón social de la empresa solicitante, el cargo y
si se hubiese realizado un contrato los datos de la(s) persona(s).
*/

SELECT DISTINCT emp.cuit AS "Cuit", emp.razon_social AS "Razón Social", car.desc_cargo AS "Desc_Cargo",
ifnull(per.dni, "Sin Contrato") AS "DNI", ifnull(per.apellido, "Sin Contrato") AS "Apellido",
ifnull(per.nombre, "Sin Contrato") AS "Nombre"
FROM agencia_personal.solicitudes_empresas se
INNER JOIN agencia_personal.cargos car ON se.cod_cargo = car.cod_cargo
LEFT JOIN agencia_personal.contratos con
ON se.cuit = con.cuit AND se.cod_cargo = con.cod_cargo AND se.fecha_solicitud = con.fecha_solicitud
LEFT JOIN agencia_personal.empresas emp ON se.cuit = emp.cuit
LEFT JOIN agencia_personal.personas per ON con.dni = per.dni;
