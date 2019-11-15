/*
--> LEFT AND RIGHT JOIN...
10) Listar las empresas solicitantes mostrando la razón social y fecha de cada solicitud, y
descripción del cargo solicitado. Si hay empresas que no hayan solicitado que salga la
leyenda: Sin Solicitudes en la fecha y en la descripción del cargo.
*/

SELECT emp.cuit AS "Cuit", emp.razon_social AS "Razón Social",
ifnull(se.fecha_solicitud, "Sin Solicitudes") AS "Fecha Solicitud",
ifnull(car.desc_cargo, "Sin Solicitudes") AS "Cargo"
FROM agencia_personal.empresas emp
LEFT JOIN agencia_personal.solicitudes_empresas se ON emp.cuit = se.cuit
LEFT JOIN agencia_personal.cargos car ON se.cod_cargo = car.cod_cargo;
