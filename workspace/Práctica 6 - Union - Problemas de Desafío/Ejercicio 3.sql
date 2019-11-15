/*
3) Listar las empresas solicitantes mostrando la razón social y fecha de cada solicitud, y descripción del cargo solicitado.
Si hay empresas que no hayan solicitado que muestre la leyenda: Sin Solicitudes en la fecha y en la descripción del cargo.
Además mostrar todos los cargos incluso los que no han sido solicitados nunca, en ese caso indicar en razón social y fecha
de solicitud la leyenda "Cargo no solicitado"
*/

SELECT emp.cuit, emp.razon_social, ifnull(con.fecha_solicitud, "Sin Solicitudes") "Fecha Solicitud",
ifnull(car.desc_cargo, "Sin Solicitudes") "Cargo"
FROM agencia_personal.contratos con
INNER JOIN agencia_personal.cargos car ON con.cod_cargo = car.cod_cargo
RIGHT JOIN agencia_personal.empresas emp ON con.cuit = emp.cuit
UNION
SELECT ifnull(emp.cuit, "Cargo No Solicitado"), ifnull(emp.razon_social, "Cargo No Solicitado"),
ifnull(con.fecha_solicitud, "Cargo No Solicitado") "Fecha Solicitud", car.desc_cargo
FROM agencia_personal.contratos con
INNER JOIN agencia_personal.empresas emp ON con.cuit = emp.cuit
RIGHT JOIN agencia_personal.cargos car ON con.cod_cargo = car.cod_cargo;

# El resultado es ligeramente distinto al apunte?
