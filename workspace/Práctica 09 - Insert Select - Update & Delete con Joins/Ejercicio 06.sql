/*
6) Eliminar los exámenes donde el promedio general de las evaluaciones sea menor a 5.5. Eliminar también los temas que
sólo se evalúan en esos exámenes. Ayuda: Usar una tabla temporal para determinar el/los exámenes que cumplan las
condiciones y utilizar dichas tabla para los joins. Tener en cuenta las CF para poder eliminarlos.

Nota: Se están eliminando los temas evaluados en esos exámenes, pero se omite la verificación de que "solo sean evaluados ahí".

--> Delete con Join!
*/

# Tabla Temporal con los exámenes a eliminar
DROP TEMPORARY TABLE IF EXISTS temp_exa_elim;
CREATE TEMPORARY TABLE temp_exa_elim
	SELECT eva.nom_plan, eva.nro_examen, avg(eva.nota) promedio
	FROM evaluaciones eva
	GROUP BY eva.nom_plan, eva.nro_examen HAVING promedio < 5.5;

START TRANSACTION;
	# Primero elimino las evaluaciones y los temas (de examenes_temas) que cumplen las especificaciones
	DELETE eva, et FROM evaluaciones eva
	INNER JOIN temp_exa_elim tee ON eva.nom_plan = tee.nom_plan AND eva.nro_examen = tee.nro_examen
	INNER JOIN examenes_temas et ON tee.nom_plan = et.nom_plan AND tee.nro_examen = et.nro_examen;
    
    # Luego borro también los exámenes (si los borro antes que eva y et, habría problemas de Foreign Keys)
	DELETE exa FROM temp_exa_elim tee
	INNER JOIN examenes exa ON exa.nom_plan = tee.nom_plan AND exa.nro_examen = tee.nro_examen;
COMMIT;
