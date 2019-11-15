CREATE DEFINER=`root`@`localhost` PROCEDURE `plan_lista_precios_a_fecha_modificado`(IN fecha_hasta DATE)
BEGIN
	select distinct plan_valor(vp.nom_plan, fecha_hasta)
    from valores_plan vp;
END