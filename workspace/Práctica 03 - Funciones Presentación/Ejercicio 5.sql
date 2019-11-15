/*
5) Mostrar en qué día mes y año nacieron las personas (mostrarlos en columnas separadas), y sus nombres
y apellidos concatenados. Funciones DAY, YEAR, MONTH y CONCAT 
*/

SELECT concat(per.apellido, " ", per.nombre) AS "Nombre y Apellido", per.fecha_nacimiento,
day(per.fecha_nacimiento) AS "Día", month(per.fecha_nacimiento) AS "Mes", year(per.fecha_nacimiento) AS "Año"
FROM agencia_personal.personas per;
