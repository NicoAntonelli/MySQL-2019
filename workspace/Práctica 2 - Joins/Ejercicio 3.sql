/*
3) Listado de las solicitudes consignando razón social, dirección y e_mail de la empresa,
descripción del cargo solicitado y años de experiencia solicitados, ordenado por fecha de
solicitud y descripción de cargo.
*/

SELECT emp.razon_social, emp.direccion, emp.e_mail, car.desc_cargo, se.anios_experiencia
FROM agencia_personal.empresas emp
INNER JOIN agencia_personal.solicitudes_empresas se USING (cuit)
INNER JOIN agencia_personal.cargos car ON se.cod_cargo = car.cod_cargo
ORDER BY se.fecha_solicitud, car.desc_cargo;
