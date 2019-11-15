/*
12) Mostrar para todas las solicitudes la razón social de la empresa solicitante, el cargo de
las solicitudes para las cuales no se haya realizado un contrato.
*/

SELECT emp.cuit, emp.razon_social, car.desc_cargo
FROM agencia_personal.solicitudes_empresas se
LEFT JOIN agencia_personal.cargos car ON se.cod_cargo = car.cod_cargo
LEFT JOIN agencia_personal.contratos con
ON se.cuit = con.cuit AND se.cod_cargo = con.cod_cargo AND se.fecha_solicitud = con.fecha_solicitud
LEFT JOIN agencia_personal.empresas emp ON se.cuit = emp.cuit
WHERE con.nro_contrato IS NULL;
