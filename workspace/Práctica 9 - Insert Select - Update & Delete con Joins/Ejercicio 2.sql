/*
2) Crear una nueva lista de precios para todos los planes de capacitación, a partir del 01/08/2009, con la
siguiente regla: Los cursos cuyo último valor sea menor a $90 aumentarlos en un 20% al resto aumentarlos un 12%.
*/

# Tabla temporal con la última fecha de cada plan
DROP TEMPORARY TABLE IF EXISTS temp_planes_fechas;
CREATE TEMPORARY TABLE temp_planes_fechas
	SELECT vp.nom_plan, max(vp.fecha_desde_plan) ult_fecha
	FROM valores_plan vp
	GROUP BY vp.nom_plan;

# Utilizo un Case para ambos casos de la regla
START TRANSACTION;
	INSERT INTO valores_plan (nom_plan, fecha_desde_plan, valor_plan)
	SELECT vp.nom_plan, '20090801', CASE
									WHEN vp.valor_plan < 90 THEN vp.valor_plan * 1.2
                                    ELSE vp.valor_plan * 1.12
                                    END
	FROM valores_plan vp
	INNER JOIN temp_planes_fechas tpf
	ON vp.nom_plan = tpf.nom_plan AND vp.fecha_desde_plan = tpf.ult_fecha;
COMMIT;

############ OTRA FORMA ############

# Otra Forma podría ser sin utilizar el case, y hacer los dos Insert Select por separado (Acá el ordenes es importante!)
# Seguimos utilizando la tabla temporal de arriba
START TRANSACTION;
	# Primer Caso: Valores >= a 90
	INSERT INTO valores_plan (nom_plan, fecha_desde_plan, valor_plan)
	SELECT vp.nom_plan, '20090601', vp.valor_plan * 1.12
	FROM valores_plan vp
	INNER JOIN temp_planes_fechas tpf
	ON vp.nom_plan = tpf.nom_plan AND vp.fecha_desde_plan = tpf.ult_fecha
    WHERE vp.valor_plan >= 90;
    
    # Segundo Caso: Valores < a 90
    INSERT INTO valores_plan (nom_plan, fecha_desde_plan, valor_plan)
	SELECT vp.nom_plan, '20090601', vp.valor_plan * 1.2
	FROM valores_plan vp
	INNER JOIN temp_planes_fechas tpf
	ON vp.nom_plan = tpf.nom_plan AND vp.fecha_desde_plan = tpf.ult_fecha
    WHERE vp.valor_plan < 90;
COMMIT;
