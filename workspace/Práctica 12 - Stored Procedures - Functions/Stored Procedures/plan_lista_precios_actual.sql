CREATE DEFINER=`root`@`localhost` PROCEDURE `plan_lista_precios_actual`()
BEGIN
	drop temporary table if exists valor_actual;
	create temporary table valor_actual (
	select vp.`nom_plan`, max(vp.`fecha_desde_plan`) ult_fecha
	from `valores_plan` vp
	group by vp.`nom_plan`);
    
	select pc.`nom_plan`, pc.`modalidad`, vp.`valor_plan` valor_actual
	from `plan_capacitacion` pc
	inner join valor_actual va on pc.`nom_plan`=va.nom_plan
	inner join `valores_plan` vp on va.`nom_plan`=vp.`nom_plan` and va.ult_fecha=vp.`fecha_desde_plan`;
END
