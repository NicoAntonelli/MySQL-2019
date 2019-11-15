/*
1 )¿Qué personas fueron contratadas por las mismas empresas que Stefanía Lopez?
*/

# Si la tabla temporal ya existe, la borro, así no hay error con el Create.
DROP TEMPORARY TABLE IF EXISTS temp_stefania;
CREATE TEMPORARY TABLE temp_stefania
	SELECT DISTINCT con.cuit
	FROM agencia_personal.personas per
	INNER JOIN agencia_personal.contratos con ON per.dni = con.dni
	WHERE per.nombre = "Stefanía" and per.apellido = "Lopez";

SELECT DISTINCT per.dni, per.apellido, per.nombre
FROM agencia_personal.personas per
INNER JOIN agencia_personal.contratos con ON per.dni = con.dni
INNER JOIN temp_stefania ON con.cuit = temp_stefania.cuit;
