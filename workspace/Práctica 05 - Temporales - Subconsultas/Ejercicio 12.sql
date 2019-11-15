/*
12) Plan de capacitacion mas barato. Indicar los datos del plan de capacitacion y el valor actual
*/

# Tabla Temporal con las Fechas más actuales de cada Plan de Capacitación (Ej 11)
DROP TEMPORARY TABLE IF EXISTS temp_actplanes;
CREATE TEMPORARY TABLE temp_actplanes
	SELECT vp.nom_plan, max(vp.fecha_desde_plan) fecha_max_desde_plan
	FROM afatse.valores_plan vp GROUP BY vp.nom_plan;

# Tabla Temporal con los precios actuales de cada Plan de Capacitación
# Usa dentro la Tabla Temporal del Ej anterior (fechas más actuales)
DROP TEMPORARY TABLE IF EXISTS temp_actprices;
CREATE TEMPORARY TABLE temp_actprices
	SELECT vp.nom_plan, vp.fecha_desde_plan, vp.valor_plan
	FROM afatse.valores_plan vp
	INNER JOIN temp_actplanes tact ON vp.nom_plan = tact.nom_plan
	WHERE vp.fecha_desde_plan = tact.fecha_max_desde_plan;

# Selecciono el Plan de Capacitación con el Plan ACTUAL Mínimo
SELECT DISTINCT plcap.*, vp.valor_plan
FROM afatse.plan_capacitacion plcap
INNER JOIN afatse.valores_plan vp ON plcap.nom_plan = vp.nom_plan
WHERE vp.valor_plan = (SELECT min(tact.valor_plan) FROM temp_actprices tact);

# NOTA: No uso INNER JOIN con la tabla temporal, porque no podría "re-abrirla" en el where.
