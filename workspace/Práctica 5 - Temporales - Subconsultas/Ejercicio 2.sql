/*
2) Encontrar a aquellos empleados que ganan menos que el máximo sueldo de los empleados
de Viejos Amigos.
*/

# Variable Temporal
SELECT max(con.sueldo) INTO @var_maxsueldo
FROM agencia_personal.empresas emp
INNER JOIN agencia_personal.contratos con ON emp.cuit = con.cuit
WHERE emp.razon_social = "Viejos Amigos";

SELECT per.dni, concat(per.nombre, " ", per.apellido) "nombre", con.sueldo
FROM agencia_personal.personas per
INNER JOIN agencia_personal.contratos con ON per.dni = con.dni
WHERE con.sueldo < @var_maxsueldo;
