CREATE DEFINER=`root`@`localhost` PROCEDURE `plan_lista_precios_actual_modificado`()
BEGIN
	call plan_lista_precios_a_fecha(current_date());
END