/*
1) De las empresas registradas interesa tener un listado de personas que pueden operar como contacto. Mostrar los datos
de las empresas Solicitantes con contratos y empresas de Antecedentes de personas. Indicar cuit, razón, dni de las personas
contratadas y en caso que sean empresas de antecedentes: dni de personas que la indican como antecedente, nombre, apellido,
código de cargo, descripción del cargo y en la última columna agregar “Contrato” si la persona fue contratado o “Antecedente”
si la persona figura como antecedente. Mostrar ordenado por razón.
*/

SELECT con.cuit, emp.razon_social, con.dni, per.apellido, per.nombre, con.cod_cargo "Cargo", car.desc_cargo, "Contrato" AS "tipo"
FROM agencia_personal.contratos con
INNER JOIN agencia_personal.empresas emp ON con.cuit = emp.cuit
INNER JOIN agencia_personal.personas per ON con.dni = per.dni
INNER JOIN agencia_personal.cargos car ON con.cod_cargo = car.cod_cargo
UNION
SELECT ant.cuit, emp.razon_social, ant.dni, per.apellido, per.nombre, ant.cod_cargo "cargo", car.desc_cargo, "Antecedente" AS "tipo"
FROM agencia_personal.antecedentes ant
INNER JOIN agencia_personal.empresas emp ON ant.cuit = emp.cuit
INNER JOIN agencia_personal.personas per ON ant.dni = per.dni
INNER JOIN agencia_personal.cargos car ON ant.cod_cargo = car.cod_cargo;
