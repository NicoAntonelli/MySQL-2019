/*
13) Listar todos los cargos y para aquellos que hayan sido realizados (como antecedente) por
alguna persona indicar nombre y apellido de la persona y empresa donde lo ocupó.
*/

SELECT car.desc_cargo AS "Cargo", ifnull(per.dni, "Sin Antecedente") AS "DNI",
ifnull(per.apellido, "Sin Antecedente") AS "Apellido",
ifnull(emp.razon_social, "Sin Antecedente") AS "Razón Social"
FROM agencia_personal.cargos car
LEFT JOIN agencia_personal.antecedentes ant ON car.cod_cargo = ant.cod_cargo
LEFT JOIN agencia_personal.empresas emp ON ant.cuit = emp.cuit
LEFT JOIN agencia_personal.personas per ON ant.dni = per.dni;
