/*
11) Indicar el valor actual de los planes de Capacitación
*/

# Tabla Temporal con las Fechas más actuales de cada Plan de Capacitación
DROP TEMPORARY TABLE IF EXISTS temp_actplanes;
CREATE TEMPORARY TABLE temp_actplanes
	SELECT vp.nom_plan, max(vp.fecha_desde_plan) fecha_max_desde_plan
	FROM afatse.valores_plan vp GROUP BY vp.nom_plan;

# Retorno solo los precios de cada plan en esa fecha
SELECT vp.nom_plan, vp.fecha_desde_plan, vp.valor_plan
# Se podía haber puesto directamente vp.* ya que usamos todos los atributos
FROM afatse.valores_plan vp
INNER JOIN temp_actplanes tact ON vp.nom_plan = tact.nom_plan
WHERE vp.fecha_desde_plan = tact.fecha_max_desde_plan;

# Otra Forma de Resolver este Ej: Subquery utilizando atributos de la primer Query!
/*
SELECT *
FROM afatse.valores_plan vp
WHERE vp.fecha_desde_plan = (
	SELECT max(sub_vp.fecha_desde_plan)
    FROM afatse.valores_plan sub_vp
    WHERE vp.nom_plan = sub_vp.nom_plan);
*/
