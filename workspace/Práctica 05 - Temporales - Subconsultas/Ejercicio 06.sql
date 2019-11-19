/*
6) Seleccionar los empleados que no tengan educación no formal o terciario.
*/

DROP TEMPORARY TABLE IF EXISTS temp_dnis;
CREATE TEMPORARY TABLE temp_dnis
	SELECT DISTINCT sub_pt.dni
	FROM agencia_personal.personas_titulos sub_pt
	INNER JOIN agencia_personal.titulos sub_tit ON sub_pt.cod_titulo = sub_tit.cod_titulo
    WHERE sub_tit.tipo_titulo IN("Terciario", "Educacion no formal");

SELECT DISTINCT per.apellido, per.nombre
FROM agencia_personal.personas per
WHERE per.dni NOT IN (SELECT temp_dnis.dni FROM temp_dnis);
