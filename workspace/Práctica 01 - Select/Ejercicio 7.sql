/*
7) Mostrar el nombre, apellido y fecha de nacimiento de las personas nacidas entre 1980 y
2000
*/

SELECT nombre, apellido, fecha_nacimiento
FROM agencia_personal.personas
WHERE fecha_nacimiento BETWEEN "1980-01-01" AND "2000-12-31";

/*
Otra Forma de poner la comparación: WHERE fecha_nacimiento>"1980-01-01" AND fecha_nacimiento<"2000-12-31";
*/
