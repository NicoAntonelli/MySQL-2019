USE `afatse`;
DROP procedure IF EXISTS `plan_lista_precios_actual`;

DELIMITER $$
USE `afatse`$$
CREATE PROCEDURE `plan_lista_precios_actual` ()
BEGIN
	DROP TEMPORARY TABLE IF EXISTS ult_fecha;
	CREATE TEMPORARY TABLE ult_fecha
	SELECT vp.nom_plan, max(vp.fecha_dedsde_plan)
	FROM afatse.valores_plan vp
	WHERE vp.fecha_desde_plan <= current_date()
	GROUP BY vp.nom_plan;
END$$

DELIMITER ;
