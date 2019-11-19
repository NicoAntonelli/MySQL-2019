/*
6) Empleados que no tengan referencias, o que hayan puesto de referencia a Armando Esteban
Quito o Felipe Rojas. Mostrarlos de la siguiente forma:
Pérez, Juan tiene como referencia a Felipe Rojas cuando trabajo en Constructora Gaia
S.A
*/

SELECT DISTINCT concat(per.apellido, ", ", per.nombre, " tiene como referencia a ",
ifnull(ant.persona_contacto, "No tiene contacto"), " cuando trabajó en ", emp.razon_social) AS ""
FROM agencia_personal.antecedentes ant
INNER JOIN agencia_personal.personas per USING (dni)
INNER JOIN agencia_personal.empresas emp USING (cuit)
WHERE persona_contacto IS NULL OR persona_contacto IN("Armando Esteban Quito", "Felipe Rojas");
