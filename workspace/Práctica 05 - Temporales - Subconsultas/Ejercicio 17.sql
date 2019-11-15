/*
17) Indicar el último incremento de los valores de los planes de capacitación, consignando nombre del plan,
fecha del valor actual, fecha del valor anterior, valor actual, valor anterior y diferencia entre los valores.
Si el curso tiene un único valor mostrar la fecha anterior en NULL el valor anterior en 0 y la diferencia en 0.
*/

# Tabla Temporal con las Fechas más actuales de cada Plan de Capacitación (Ej 11)
DROP TEMPORARY TABLE IF EXISTS temp_actplanes;
CREATE TEMPORARY TABLE temp_actplanes
	SELECT vp.nom_plan, max(vp.fecha_desde_plan) "act_fecha_plan"
	FROM afatse.valores_plan vp GROUP BY vp.nom_plan;

# Tabla Temporal con los precios actuales de cada Plan de Capacitación
# Usa dentro la Tabla Temporal anterior (fechas más actuales)
DROP TEMPORARY TABLE IF EXISTS temp_actprices;
CREATE TEMPORARY TABLE temp_actprices
	SELECT vp.nom_plan, vp.fecha_desde_plan "act_fecha_plan", vp.valor_plan
	FROM afatse.valores_plan vp
	INNER JOIN temp_actplanes tact ON vp.nom_plan = tact.nom_plan
	WHERE vp.fecha_desde_plan = tact.act_fecha_plan;

# Tabla Temporal con la fecha anterior a la última de cada Plan de Capacitación
DROP TEMPORARY TABLE IF EXISTS temp_lastplanes;
CREATE TEMPORARY TABLE temp_lastplanes
	SELECT vp.nom_plan, max(vp.fecha_desde_plan) "last_fecha_plan"
    FROM afatse.valores_plan vp
    WHERE vp.fecha_desde_plan <> (
		SELECT tact.act_fecha_plan FROM temp_actprices tact WHERE vp.nom_plan = tact.nom_plan)
        # Uso "<>" y no uso "NOT IN", porque retorna un solo valor, y es innecesario
    GROUP BY vp.nom_plan;

# Tabla Temporal con el precio anterior al último de cada Plan de Capacitación
# Usa dentro la Tabla Temporal anterior (Fecha anterior a la última de cada plan)
DROP TEMPORARY TABLE IF EXISTS temp_lastprices;
CREATE TEMPORARY TABLE temp_lastprices
	SELECT vp.nom_plan, vp.fecha_desde_plan "last_fecha_plan", vp.valor_plan
	FROM afatse.valores_plan vp
	INNER JOIN temp_lastplanes tlast ON vp.nom_plan = tlast.nom_plan
	WHERE vp.fecha_desde_plan = tlast.last_fecha_plan;

# Calculo diferencias de valores, exhibo fechas y valores, LEFT JOIN para tener en cuenta los planes
# que solo fueron cargados sus precios una vez sola (osea aparecen en actprices y no en lastprices)
SELECT tact.nom_plan "Nombre Plan", tact.act_fecha_plan "Act Fecha", tact.valor_plan "Valor Actual",
tlast.last_fecha_plan "Last Fecha", ifnull(tlast.valor_plan, 0) "Valor Anterior",
ifnull((tact.valor_plan - tlast.valor_plan), 0) "Diferencia de Valores"
FROM temp_actprices tact
LEFT JOIN temp_lastprices tlast ON tact.nom_plan = tlast.nom_plan;
