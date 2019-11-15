/*
4) Listado de personas que hayan sido contratadas y que existan registradas también con sus antecedentes.
Si se repiten mostrarlas una sola vez.
*/

SELECT DISTINCT per.dni, per.apellido, per.nombre
FROM agencia_personal.personas per
INNER JOIN agencia_personal.contratos con ON per.dni = con.dni
INNER JOIN agencia_personal.antecedentes ant ON per.dni = ant.dni

# Sin UNION. Estos INNER JOINS representan Intersección
