/*
1) Crear una nueva lista de precios para todos los planes de capacitación, a partir del 01/06/2009
con un 20 por ciento más que su último valor. Eliminar las filas agregadas.

--> Insert Select!
*/

# Tabla temporal con la última fecha de cada plan
DROP TEMPORARY TABLE IF EXISTS temp_planes_fechas;
CREATE TEMPORARY TABLE temp_planes_fechas
	SELECT vp.nom_plan, max(vp.fecha_desde_plan) ult_fecha
	FROM valores_plan vp
	GROUP BY vp.nom_plan;

# Hago el Insert Select teniendo en cuenta los precios actuales
START TRANSACTION;
	INSERT INTO valores_plan (nom_plan, fecha_desde_plan, valor_plan)
	SELECT vp.nom_plan, '20090601', vp.valor_plan * 1.2
	FROM valores_plan vp
	INNER JOIN temp_planes_fechas tpf
	ON vp.nom_plan = tpf.nom_plan AND vp.fecha_desde_plan = tpf.ult_fecha;
COMMIT;
